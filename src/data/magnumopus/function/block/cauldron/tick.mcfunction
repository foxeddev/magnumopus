execute as @e[type=marker, tag=magnumopus.cauldron] at @s:
    execute unless block ~ ~ ~ cauldron run kill

execute as @e[type=interaction, tag=magnumopus.cauldron] at @s:
    execute unless block ~ ~ ~ cauldron run kill

    execute positioned ~-0.5 ~0.001 ~-0.5 run tag @n[type=marker, tag=magnumopus.cauldron, distance=..0.01] add current_marker

    execute if data entity @s interaction:
        execute unless data entity @n[tag=current_marker] data.magnumopus.item:
            data remove storage ./temp item
            execute on target run data modify storage ./temp item set from entity @s SelectedItem
            data modify storage ./temp item.count set value 1

            execute if data storage ./temp item:
                data modify entity @n[tag=current_marker] data.magnumopus.item set from storage ./temp item

                execute on target run item modify entity @s[gamemode=!creative] weapon.mainhand {
                    "function": "minecraft:set_count",
                    "count": -1,
                    "add": true,
                    "conditions": []
                }

        data remove entity @s interaction

    execute if data entity @s attack:
        execute if data entity @n[tag=current_marker] data.magnumopus.item:
            data remove storage ./temp item
            data modify storage ./temp item set from entity @n[tag=current_marker] data.magnumopus.item
            summon item ~ ~1 ~ {Item: {id: "minecraft:stick"}, Tags: ["new"]}
            execute as @n[type=item, tag=new]:
                data modify entity @s Item set from storage ./temp item
            data remove entity @n[tag=current_marker] data.magnumopus.item

        data remove entity @s attack

    tag @e[tag=current_marker] remove current_marker

    scoreboard players add @s magnumopus.age 1
    execute if score @s magnumopus.age matches 2.. run kill

function ./raycast:
    scoreboard players set .rc_limit temp 50
    function ./raycast_loop:
        scoreboard players remove .rc_limit temp 1
        execute if score .rc_limit temp matches ..0 run return fail
        execute if block ~ ~ ~ cauldron run return:
            # cauldron found

            execute align xyz:
                execute:
                    # summon marker if none exists
                    execute unless entity @n[type=marker, tag=magnumopus.cauldron, distance=..0.01] summon marker run return:
                        data merge entity @s {Tags:["magnumopus.cauldron", "current_marker"], data: {name: "Cauldron"}}

                    # else give the existing one a tag
                    execute as @n[type=marker, tag=magnumopus.cauldron]:
                        tag @s add current_marker

                execute positioned ~0.5 ~-0.001 ~0.5:
                    # test for same item in cauldron and player's hand
                    execute unless data entity @n[tag=current_marker] data.magnumopus.item unless data entity @s SelectedItem run return fail

                    # summon interaction if none exists
                    execute unless entity @n[type=interaction, tag=magnumopus.cauldron, distance=..0.01] summon interaction run return:
                        data merge entity @s {Tags:["magnumopus.cauldron"], width: 1.002, height: 1.002, response: true}

                    # else keep the existing one
                    execute as @n[type=interaction, tag=magnumopus.cauldron]:
                        scoreboard players set @s magnumopus.age 0

                tag @e[tag=current_marker] remove current_marker

        execute positioned ^ ^ ^0.1 run function ./raycast_loop

    function ./raycast_loop

execute as @a at @s anchored eyes run function ./raycast
