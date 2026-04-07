execute:
    # remove all burnt items if not lava cauldron
    execute unless block ~ ~ ~ minecraft:lava_cauldron run return:
        data remove entity @s data.magnumopus.burnt_items

    tag @s add current_marker
    execute as @e[type=item, dx=0, dy=0, dz=0] at @s unless data entity @s {Item: {components: {"minecraft:custom_data": {magnumopus: {item: "fire_essence"}}}}}:
        data modify entity @n[tag=current_marker] data.magnumopus.burnt_items append from entity @s Item
        playsound minecraft:entity.generic.burn block @a ~ ~ ~
        kill @s

    tag @s remove current_marker

# calculate fire level
scoreboard players set .fire_level temp 0
execute if data entity @s data.magnumopus.burnt_items[{id: "minecraft:magma_cream"}]:
    scoreboard players add .fire_level temp 1
execute if data entity @s data.magnumopus.burnt_items[{id: "minecraft:blaze_powder"}]:
    scoreboard players add .fire_level temp 1
execute if data entity @s data.magnumopus.burnt_items[{id: "minecraft:gunpowder"}]:
    scoreboard players add .fire_level temp 1
execute if data entity @s data.magnumopus.burnt_items[{id: "minecraft:coal"}]:
    scoreboard players add .fire_level temp 1
execute if data entity @s data.magnumopus.burnt_items[{components: {"minecraft:custom_data": {magnumopus: {item: "ember_seeds"}}}}]:
    scoreboard players add .fire_level temp 1

execute if score .fire_level temp matches 5:
    playsound minecraft:entity.experience_orb.pickup block @a ~ ~ ~
    loot spawn ~0.5 ~0.5 ~0.5 loot magnumopus:fire_essence
    data remove entity @s data.magnumopus.burnt_items
