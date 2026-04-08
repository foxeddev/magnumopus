execute as @e[type=marker, tag=magnumopus.structure.temple_basement.spawn] at @s:
    execute store result score .middle_height temp run random value 4..8

    function ./loop:
        place template magnumopus:temple_basement/middle_slice ~-1 ~ ~-1
        scoreboard players remove .middle_height temp 1
        execute if score .middle_height temp matches ..0 run return:
            place template magnumopus:temple_basement/bottom ~-1 ~-6 ~-6
            kill @s
        execute positioned ~ ~-1 ~ run function ./loop

    execute positioned ~ ~-1 ~ run function ./loop

execute as @e[type=marker, tag=magnumopus.structure.temple_basement.bounds] at @s positioned ~-0.5 ~-0.5 ~-0.5:
    execute as @a[dx=16, dy=6, dz=12]:
        advancement grant @s only magnumopus:display/root
