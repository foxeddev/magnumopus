execute as @e[type=marker, tag=magnumopus.altar_egg] at @s:
    execute if entity @s[tag=is_active] run return:
        scoreboard players set .active_altars temp 1
        execute as @n[type=marker, tag=magnumopus.altar_earth, tag=is_active, distance=..3]:
            scoreboard players add .active_altars temp 1
        execute as @n[type=marker, tag=magnumopus.altar_water, tag=is_active, distance=..3]:
            scoreboard players add .active_altars temp 1
        execute as @n[type=marker, tag=magnumopus.altar_fire, tag=is_active, distance=..3]:
            scoreboard players add .active_altars temp 1
        execute as @n[type=marker, tag=magnumopus.altar_air, tag=is_active, distance=..3]:
            scoreboard players add .active_altars temp 1
        execute if score .active_altars temp matches 5:
            execute positioned ~ ~1 ~ run function magnumopus:ritual/start
            execute as @e[type=marker, tag=magnumopus.altar, distance=..3] at @s:
                tag @s remove is_active
                execute as @n[type=item_display, tag=magnumopus.altar, distance=..0.01]:
                    data modify entity @s item set value {id: "minecraft:recovery_compass", components: {"minecraft:item_model": "magnumopus:block/altar"}}

    execute if block ~ ~1 ~ minecraft:dragon_egg:
        setblock ~ ~1 ~ minecraft:air
        # activate
        data modify entity @n[type=item_display, distance=..0.01] item.components."minecraft:item_model" set value "magnumopus:block/altar_egg"
        tag @s add is_active
