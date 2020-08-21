extends Node2D

var item_scene = load("res://scenes/Item.tscn")

func create(item_name):
	if items.has(item_name):
		var params = items[item_name]
		var item = item_scene.instance()
		item.tile_x = params[0]
		item.tile_y = params[1]
		var color = params[2]
		if colors.has(color):
			color = colors[color]
		item.color = color
		item.collision_mask = 0
		item.collision_layer = 0
		return item
	return null

func from_id(id):
	for item_name in items:
		var params = items[item_name]
		if id == params[0] + params[1] * 100:
			return item_name
	return null

func clear():
	for item in get_children():
		remove_child(item)
		item.queue_free()

func load_items(level):
	for item_name in level:
		for pos in level[item_name]:
			var item = create(item_name)
			item.collision_mask = 3
			item.collision_layer = 3
			item.position.x = pos[0] * 16 + 8
			item.position.y = pos[1] * 16 + 8
			add_child(item)

func _ready():
	pass

const colors = {
	"croko": "309030",
	"stone": "706965",
	"wood": "ca9c60",
	"fire": "c53030",
	"iron": "758e9b",
	"brick": "ef6f00",
	"tree": "306030",
	"white": "ffffff",
	"gold": "ac9515",
	"ruby": "ac1515",
}

const items = {
# animals
	"chicken":
			[26,  7, "e0e0e0"],
	"spider":
			[28,  5, "303030"],
	"croko":
			[29,  8, "309030"],
	"fish":
		[33, 17, "7070b0"],
# some trees
	"tree":
			[ 2,  1, "tree"],
	"2 trees":
			[ 3,  1, "tree"],
	"big tree":
			[ 5,  1, "tree"],
# misc
	"feather":
			[34, 2, "white"],
	"string":
			[11, 14, "white"],
	"croko hide":
			[11, 18, "croko"],
	"dirt": 
			[ 1,  0, "553300"],
	"coal": 
			[ 2,  0, "1b1b1b"],
	"stone": 
			[ 5,  2, "stone"],
	"stone slab": 
			[ 4,  0, "stone"],
	"sand":
			[ 6,  0, "d0d0a0"],
	"bottle":
			[33, 14, "e0e0e0"],
	"gold":
			[32, 10, "gold"],
	"crown":
			[43,  2, "gold"],
	"ruby":
			[33, 10, "ruby"],
	"ruby ring":
			[45,  6, "ruby"],
	"UFO":
			[14, 20, "8804bc"],
	"bone":
			[32, 12, "white"],
# wooden stuff
	"fence":
			[ 1,  3, "wood"],
	"wooden stick":
			[32,  2, "wood"],
	"door":
			[ 3,  3, "wood"],
	"planks":
			[19, 12, "wood"],
	"ladder":
			[ 0,  6, "wood"],
	"chest":
			[ 8,  6, "wood"],
	"boat":
			[11, 19, "wood"],
	"bed":
			[ 5,  8, "wood"],
	"branches":
			[ 6,  2, "ca8060"],
# fire stuff
	"fire":
			[15, 10, "fire"],
	"torch": 
			[43,  3, "fire"],
	"campfire":
			[14, 10, "fire"],
	"bricks":
			[ 6, 13, "brick"],
	"furnace":
			[ 8, 21, "brick"],
# iron stuff
	"iron":
			[3, 0, "iron"],
	"iron ore":
			[34, 10, "iron"],
	"cauldron":
			[ 5, 14, "iron"],
	"minecart":
			[15, 13, "iron"],
	"rails":
			[ 3,  5, "iron"],
	"bucket":
			[47, 3, "iron"],
# armor
## croko
	"croko helm":
			[35,  0, "croko"],
	"croko chest":
			[32,  1, "croko"],
	"croko shield":
			[37,  2, "croko"],
	"croko boots":
			[40,  1, "croko"],
	"croko gloves":
			[41,  1, "croko"],
## iron
	"iron helm":
			[32,  0, "iron"],
	"iron chest":
			[35,  1, "iron"],
	"iron shield":
			[38,  4, "iron"],
	"iron boots":
			[40,  0, "iron"],
	"iron gloves":
			[41,  0, "iron"],
# weapons and tools
## wood
	"wooden sword":
			[33,  7, "wood"],
	"wooden axe":
			[41,  8, "wood"],
	"wooden pickaxe":
			[43,  5, "wood"],
## stone
	"stone sword":
			[34,  8, "stone"],
	"stone axe":
			[41,  7, "stone"],
	"stone pickaxe":
			[43,  5, "stone"],
## iron
	"iron sword":
			[32,  8, "iron"],
	"iron axe":
			[40,  7, "iron"],
	"iron pickaxe":
			[43,  5, "iron"],
## misc
	"wooden shield":
			[39,  2, "wood"],
	"bow":
			[40,  6, "wood"],
	"arrow":
			[40,  5, "iron"],
	"stave":
			[32,  4, "wood"],
	"scepter":
			[33,  5, "ruby"],
# buildings
	"room":
			[ 8, 19, "brick"],
	"house":
			[ 1, 19, "brick"],
	"tower":
			[ 2, 19, "brick"],
	"wall":
			[ 7, 19, "brick"],
	"castle":
			[ 6, 19, "brick"],
}
