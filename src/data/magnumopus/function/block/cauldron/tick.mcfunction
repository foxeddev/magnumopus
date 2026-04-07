execute as @e[type=marker, tag=magnumopus.cauldron] at @s:
    tag @n[type=item_display, tag=magnumopus.cauldron.earth, distance=..0.01] add current_earth_display
    execute unless block ~ ~ ~  #minecraft:cauldrons:
        kill @n[tag=current_earth_display]
        kill @s

    function ./earth/tick
    function ./water/tick
    function ./fire/tick

    tag @e[tag=current_earth_display] remove current_earth_display

execute as @e[type=item]:
    execute unless entity @s[tag=magnumopus.is_being_grinded]:
        scoreboard players reset @s magnumopus.grind_time

    execute unless entity @s[tag=magnumopus.is_being_boiled]:
        scoreboard players reset @s magnumopus.boil_time

    tag @s remove magnumopus.is_being_grinded
    tag @s remove magnumopus.is_being_boiled
