execute summon minecraft:marker:
    tag @s add magnumopus.ritual
    scoreboard players set @s magnumopus.ritual_animation_time 240

playsound minecraft:entity.ender_dragon.death block @a ~ ~ ~ 0.5 1

execute positioned ~ ~0.01 ~:
    function animated_java:magnumopus/summon {args: {}}
    execute as @n[type=item_display,tag=aj.magnumopus.root]:
        function animated_java:magnumopus/animations/ritual/play
