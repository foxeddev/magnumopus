execute positioned ~0.5 ~0.5 ~0.5 if entity @n[type=lightning_bolt, distance=..3] at @s:
    # remove all combusted items if not cauldron
    execute unless block ~ ~ ~ minecraft:cauldron run return:
        data remove entity @s data.magnumopus.combusted_items

    tag @s add current_marker
    execute as @e[type=item, dx=0, dy=0, dz=0] at @s unless data entity @s {Item: {components: {"minecraft:custom_data": {magnumopus: {item: "air_essence"}}}}}:
        data modify entity @n[tag=current_marker] data.magnumopus.combusted_items append from entity @s Item
        playsound minecraft:entity.breeze.idle_air block @a ~ ~ ~
        kill @s

    tag @s remove current_marker

# calculate air level
scoreboard players set .air_level temp 0
execute if data entity @s data.magnumopus.combusted_items[{id: "minecraft:feather"}]:
    scoreboard players add .air_level temp 1
execute if data entity @s data.magnumopus.combusted_items[{id: "minecraft:wind_charge"}]:
    scoreboard players add .air_level temp 1
execute if data entity @s data.magnumopus.combusted_items[{id: "minecraft:dragon_breath"}]:
    scoreboard players add .air_level temp 1
execute if data entity @s data.magnumopus.combusted_items[{id: "minecraft:phantom_membrane"}]:
    scoreboard players add .air_level temp 1
execute if data entity @s data.magnumopus.combusted_items[{components: {"minecraft:custom_data": {magnumopus: {item: "shulker_soul"}}}}]:
    scoreboard players add .air_level temp 1

execute if score .air_level temp matches 5:
    playsound minecraft:entity.experience_orb.pickup block @a ~ ~ ~
    loot spawn ~0.5 ~0.5 ~0.5 loot magnumopus:item/air_essence
    data remove entity @s data.magnumopus.combusted_items
