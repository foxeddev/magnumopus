advancement revoke @s only ./use

tag @s add magnumopus.using_pestle
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
