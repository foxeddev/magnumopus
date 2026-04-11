execute as @e[type=marker, tag=magnumopus.ritual] at @s:
    execute if score @s magnumopus.ritual_animation_time matches 1.. run return:
        execute if score @s magnumopus.ritual_animation_time matches 180..250:
            particle flash{color:[0.141,0.067,0.012,0.50]} ~ ~ ~ 2 2 2 0 0 normal
        execute if score @s magnumopus.ritual_animation_time matches 130..200:
            particle flash{color:[0.659,0.914,0.929,0.50]} ~ ~ ~ 2 2 2 0 0 normal
        execute if score @s magnumopus.ritual_animation_time matches 80..150:
            particle flash{color:[1.000,0.878,0.098,0.50]} ~ ~ ~ 2 2 2 0 0 normal
        execute if score @s magnumopus.ritual_animation_time matches 30..100:
            particle flash{color:[1.000,0.000,0.000,0.50]} ~ ~ ~ 2 2 2 0 0 normal
        execute if score @s magnumopus.ritual_animation_time matches 20:
            playsound minecraft:block.end_portal.spawn block @a ~ ~ ~ 1 0
            function magnumopus:block/philosophers_stone/create

        scoreboard players remove @s magnumopus.ritual_animation_time 1

    execute as @n[type=item_display,tag=aj.magnumopus.root]:
        function animated_java:magnumopus/animations/ritual/stop
        function animated_java:global/remove/entity_stack
    kill @s
