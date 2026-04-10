execute align xyz positioned ~0.5 ~0.5 ~0.5:
    particle minecraft:explosion_emitter
    playsound minecraft:entity.generic.explode block @a ~ ~ ~ 1 0
    advancement grant @a[distance=..8] only magnumopus:display/philosophers_stone
    setblock ~ ~ ~ minecraft:barrier
    execute summon minecraft:marker:
        tag @s add magnumopus.philosophers_stone
    execute summon minecraft:item_display:
        tag @s add magnumopus.philosophers_stone
        data modify entity @s item set value {id: "minecraft:recovery_compass", components: {"minecraft:item_model": "magnumopus:block/philosophers_stone"}}
    execute positioned ~ ~-0.51 ~ summon minecraft:interaction:
        tag @s add magnumopus.philosophers_stone
        data merge entity @s {width: 1.02, height: 1.02}
