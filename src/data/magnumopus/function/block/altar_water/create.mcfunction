execute align xyz positioned ~0.5 ~0.5 ~0.5:
    setblock ~ ~ ~ minecraft:barrier
    execute summon minecraft:marker:
        tag @s add magnumopus.altar_water
        tag @s add magnumopus.altar
    execute summon minecraft:item_display:
        tag @s add magnumopus.altar_water
        tag @s add magnumopus.altar
        data modify entity @s item set value {id: "minecraft:recovery_compass", components: {"minecraft:item_model": "magnumopus:block/altar"}}
