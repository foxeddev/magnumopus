execute summon marker:
    data merge entity @s {Tags: ["magnumopus.cauldron"], data: {name: "Cauldron"}}

execute summon item_display:
    data merge entity @s {Tags: ["magnumopus.cauldron.earth"], transformation:{left_rotation:[0.707f,0f,0f,-0.707f],right_rotation:[0f,0f,0f,1f],translation:[0.5f,0.25f,0.5f],scale:[1f,1f,0f]}, item: {id: "minecraft:recovery_compass", count: 1, components: {"minecraft:item_model": "magnumopus:block/cauldron/earth"}}}
