extends Node2D

var item_scene = load("res://scenes/Item.tscn")

func create(item_name):
	if items.has(item_name):
		var params = items[item_name]
		var item = item_scene.instance()
		item.tile_x = params[0]
		item.tile_y = params[1]
		item.color = params[2]
		item.collision_mask = 3
		item.collision_layer = 3
		return item
	return null

func _ready():
	pass

const items = {
# animals
	"chicken":
			[26,  7, "e0e0e0"],
	"spider":
			[28,  5, "303030"],
	"croko":
			[29,  8, "309030"],
# some trees
	"tree":
			[ 2,  1, "309030"],
	"2 trees":
			[ 3,  1, "309030"],
	"big tree":
			[ 5,  1, "309030"],
# misc
	"feather":
			[34, 2, "ffffff"],
	"string":
			[11, 14, "ffffff"],
	"croko hide":
			[11, 18, "309030"],
	"dirt": 
			[ 1,  0, "553300"],
	"coal": 
			[ 2,  0, "1b1b1b"],
	"stone": 
			[ 5,  2, "9b9b9b"],
	"sand":
			[ 6,  0, "d0d0a0"],
	"bottle":
			[33, 14, "e0e0e0"],
	"gold":
			[32, 10, "ac9515"],
	"ruby":
			[33, 10, "ac1515"],
# wooden stuff
	"fence":
			[ 1,  3, "ca9c60"],
	"wooden stick":
			[32,  2, "ca9c60"],
	"door":
			[ 3,  3, "ca9c60"],
	"planks":
			[19, 12, "ca9c60"],
	"ladder":
			[ 0,  6, "ca9c60"],
	"chest":
			[ 8,  6, "ca9c60"],
	"boat":
			[11, 19, "ca9c60"],
	"bed":
			[ 5,  8, "ca9c60"],
	"branches":
			[ 6,  2, "ca9c60"],
# fire stuff
	"fire":
			[15, 10, "c53030"],
	"torch": 
			[43,  3, "e81919"],
	"campfire":
			[14, 10, "c53030"],
	"bricks":
			[ 6, 13, "c53030"],
	"furnace":
			[ 8, 21, "c53030"],
# metal stuff
	"metal":
			[3, 0, "7b7b7b"],
	"metal ingot":
			[34, 10, "7b7b7b"],
	"cauldron":
			[ 5, 14, "7b7b7b"],
	"minecart":
			[15, 13, "7b7b7b"],
	"rails":
			[ 3,  5, "7b7b7b"],
	"mine":
			[ 5, 17, "7b7b7b"],


}
