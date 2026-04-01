execute unless entity @n[type=marker, tag=magnumopus.cauldron, distance=..0.01]:
    # register cauldron
    function ./create

execute if entity @s[tag=magnumopus.using_pestle]:
    # player is using pestle
    tag @s add current_player
    execute align xyz:
        tag @n[type=marker, tag=magnumopus.cauldron, distance=..0.01] add current_marker

    execute as @e[type=item, dx=0, dy=0, dz=0] at @s:
        tag @s add magnumopus.is_being_grinded
        execute unless score @s magnumopus.grind_time matches 1..:
            execute store result score @s magnumopus.max_grind_time run random value 100..150

        scoreboard players operation .timer temp = @s magnumopus.grind_time
        scoreboard players set .interval temp 8
        scoreboard players operation .timer temp %= .interval temp
        execute if score .timer temp matches 0:
            playsound minecraft:block.sand.break player @p[tag=current_player]

        execute if score @s magnumopus.grind_time > @s magnumopus.max_grind_time run return:
            data modify entity @n[tag=current_marker] data.magnumopus.grinded_items append from entity @s Item
            playsound minecraft:block.gravel.break player @a[tag=current_player]
            kill @s
        scoreboard players add @s magnumopus.grind_time 1

    tag @s remove current_player
    tag @e[tag=current_marker] remove current_marker
