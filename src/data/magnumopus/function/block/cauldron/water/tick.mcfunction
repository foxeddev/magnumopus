execute:
    # remove all boiled items if not water cauldron
    execute unless block ~ ~ ~ minecraft:water_cauldron[level=3] run return:
        data remove entity @s data.magnumopus.boiled_items
    # stop boiling new items if heat source is missing
    execute unless block ~ ~-1 ~ #magnumopus:cauldron_heat_source run return fail

    tag @s add current_marker
    execute as @e[type=item, dx=0, dy=0, dz=0] at @s:
        tag @s add magnumopus.is_being_boiled
        execute unless score @s magnumopus.boil_time matches 1..:
            execute store result score @s magnumopus.max_boil_time run random value 100..150

        scoreboard players operation .timer temp = @s magnumopus.boil_time
        scoreboard players set .interval temp 16
        scoreboard players operation .timer temp %= .interval temp
        execute if score .timer temp matches 0:
            playsound minecraft:entity.player.swim block @a ~ ~ ~ 0.1 1

        execute if score @s magnumopus.boil_time > @s magnumopus.max_boil_time run return:
            data modify entity @n[tag=current_marker] data.magnumopus.boiled_items append from entity @s Item
            playsound minecraft:entity.generic.burn block @a ~ ~ ~
            kill @s
        scoreboard players add @s magnumopus.boil_time 1

    tag @s remove current_marker

# calculate earth level
scoreboard players set .water_level temp 0
execute if data entity @s data.magnumopus.boiled_items[{id: "minecraft:glow_ink_sac"}]:
    scoreboard players add .water_level temp 1
execute if data entity @s data.magnumopus.boiled_items[{id: "minecraft:nautilus_shell"}]:
    scoreboard players add .water_level temp 1
execute if data entity @s data.magnumopus.boiled_items[{id: "minecraft:heart_of_the_sea"}]:
    scoreboard players add .water_level temp 1
execute if data entity @s data.magnumopus.boiled_items[{id: "minecraft:prismarine_crystals"}]:
    scoreboard players add .water_level temp 1
# TODO: replace with custom ice crystal item
execute if data entity @s data.magnumopus.boiled_items[{id: "minecraft:recovery_compass"}]:
    scoreboard players add .water_level temp 1

# test for infusion
execute:
    execute unless score .water_level temp matches 5 run return:
        scoreboard players reset @s magnumopus.infuse_time
    execute if predicate {
        "condition": "minecraft:location_check",
        "predicate": {
            "can_see_sky": false
        }
    } run return:
        scoreboard players reset @s magnumopus.infuse_time
    execute unless score @s magnumopus.infuse_time matches 1..:
        execute store result score @s magnumopus.max_infuse_time run random value 20000..24000
    execute if score @s magnumopus.infuse_time > @s magnumopus.max_infuse_time run return:
        playsound minecraft:entity.experience_orb.pickup block @a ~ ~ ~
        loot spawn ~0.5 ~0.5 ~0.5 loot magnumopus:water_essence
        data remove entity @s data.magnumopus.boiled_items
    scoreboard players add @s magnumopus.infuse_time 1
