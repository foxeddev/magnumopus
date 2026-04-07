execute:
    execute if block ~ ~ ~ minecraft:cauldron run return:
        item modify entity @s weapon.mainhand {
            "function": "minecraft:set_components",
            "components": {
                "minecraft:consumable": {
                    "consume_seconds": 2147483647,
                    "animation": "brush",
                    "has_consume_particles": false
                },
            },
            "conditions": []
        }
        execute if entity @s[tag=magnumopus.using_pestle]:
            item modify entity @s weapon.mainhand {
              "function": "minecraft:set_damage",
              "damage": -0.005,
              "add": true,
              "conditions": []
            }
            execute if data entity @s {SelectedItem: {components: {"minecraft:damage": 1000}}}:
                item modify entity @s weapon.mainhand {
                    "function": "minecraft:set_count",
                    "count": -1,
                    "add": true,
                    "conditions": []
                }
                playsound minecraft:entity.item.break player @s

    item modify entity @s weapon.mainhand {
        "function": "minecraft:set_components",
        "components": {
            "!minecraft:consumable": {}
        },
        "conditions": []
    }
