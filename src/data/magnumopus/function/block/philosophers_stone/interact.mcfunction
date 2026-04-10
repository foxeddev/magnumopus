advancement revoke @s only magnumopus:block/philosophers_stone/interact
execute on target run data remove entity @s interaction

execute if data entity @s {SelectedItem: {id: "minecraft:glass_bottle"}} run return:
    playsound minecraft:item.bottle.fill_dragonbreath player @s
    item replace entity @s weapon.mainhand with minecraft:recovery_compass[
        minecraft:custom_data={
            "magnumopus": {
                "item": "elixir_of_life"
            }
        },
        minecraft:item_name="Elixir of Life",
        minecraft:item_model="magnumopus:item/elixir_of_life",
        minecraft:rarity="uncommon",
        minecraft:max_stack_size=1,
        minecraft:consumable={
            "animation": "drink",
            "sound": "minecraft:entity.generic.drink",
            "has_consume_particles": false,
            "on_consume_effects": []
        },
        minecraft:use_remainder={
            "id": "minecraft:glass_bottle"
        }
    ]

title @s actionbar "Use a Glass Bottle on this!"
