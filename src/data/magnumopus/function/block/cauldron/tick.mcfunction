execute as @e[type=marker, tag=magnumopus.cauldron] at @s:
    tag @n[type=item_display, tag=magnumopus.cauldron.earth, distance=..0.01] add current_earth_display
    execute unless block ~ ~ ~ minecraft:cauldron:
        kill @n[tag=current_earth_display]
        kill @s

    # calculate earth level
    scoreboard players set .earth_level temp 0
    execute if data entity @s data.magnumopus.grinded_items[{id: "minecraft:raw_iron"}]:
        scoreboard players add .earth_level temp 1
    execute if data entity @s data.magnumopus.grinded_items[{id: "minecraft:amethyst_shard"}]:
        scoreboard players add .earth_level temp 1
    execute if data entity @s data.magnumopus.grinded_items[{id: "minecraft:bone_meal"}]:
        scoreboard players add .earth_level temp 1
    execute if data entity @s data.magnumopus.grinded_items[{id: "minecraft:clay_ball"}]:
        scoreboard players add .earth_level temp 1
    # TODO: replace with custom mandrake root item
    execute if data entity @s data.magnumopus.grinded_items[{id: "minecraft:recovery_compass"}]:
        scoreboard players add .earth_level temp 1

    # show earth level
    scoreboard players set .visible_earth_height temp 20
    scoreboard players set .visible_earth_height_multiplier temp 15
    scoreboard players operation .visible_earth_height_multiplier temp *= .earth_level temp
    scoreboard players operation .visible_earth_height temp += .visible_earth_height_multiplier temp
    execute store result entity @n[tag=current_earth_display] transformation.translation[1] float 0.01 run scoreboard players get .visible_earth_height temp

    # test for burying
    execute:
        execute unless score .earth_level temp matches 5 run return:
            scoreboard players reset @s magnumopus.bury_time
        execute if predicate {
            "condition": "minecraft:location_check",
            "predicate": {
                "can_see_sky": true
            }
        } run return:
            scoreboard players reset @s magnumopus.bury_time
        execute unless score @s magnumopus.bury_time matches 1..:
            execute store result score @s magnumopus.max_bury_time run random value 200..240 # 20000..24000
        execute if score @s magnumopus.bury_time > @s magnumopus.max_bury_time run return:
            playsound minecraft:entity.experience_orb.pickup block @a ~ ~ ~
            loot spawn ~0.5 ~0.5 ~0.5 loot magnumopus:earth_essence
            data remove entity @s data.magnumopus.grinded_items
        scoreboard players add @s magnumopus.bury_time 1

    tag @e[tag=current_earth_display] remove current_earth_display

execute as @e[type=item]:
    execute unless entity @s[tag=magnumopus.is_being_grinded] run return:
        scoreboard players reset @s magnumopus.grind_time

    tag @s remove magnumopus.is_being_grinded
