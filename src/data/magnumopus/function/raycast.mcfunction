execute as @a at @s anchored eyes:
    scoreboard players set .raycast_limit temp 50

    function ./raycast_loop:
        execute if score .raycast_limit temp matches ..0 run return fail
        execute unless block ~ ~ ~ #minecraft:replaceable run return:
            execute if block ~ ~ ~ #minecraft:cauldrons align xyz run function ./block/cauldron/raycast
            execute if data entity @s {SelectedItem: {components: {"minecraft:custom_data": {magnumopus: {item: "pestle"}}}}} align xyz run function ./item/pestle/raycast

        scoreboard players remove .raycast_limit temp 1
        execute positioned ^ ^ ^0.1 run function ./raycast_loop

    function ./raycast_loop
