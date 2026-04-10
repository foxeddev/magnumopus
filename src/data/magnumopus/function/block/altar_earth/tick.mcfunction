execute as @e[type=marker, tag=magnumopus.altar_earth, tag=!is_active] at @s:
    scoreboard players set .item temp 0
    execute positioned ~-0.5 ~0.5 ~-0.5:
        execute as @n[type=item, dx=0, dy=0, dz=0] if data entity @s {Item: {components: {"minecraft:custom_data": {magnumopus: {item: "earth_essence"}}}}}:
            scoreboard players set .item temp 1
            kill @s
    execute if score .item temp matches 1:
        # activate
        data modify entity @n[type=item_display, distance=..0.01] item.components."minecraft:item_model" set value "magnumopus:block/altar_earth"
        tag @s add is_active
