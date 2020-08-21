tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ready = false

export (int, LAYERS_2D_PHYSICS) var collision_layer = 2 setget set_collision_layer
export (int, LAYERS_2D_PHYSICS) var collision_mask = 2 setget set_collision_mask

func set_collision_layer(layer):
	collision_layer = layer
	if ready:
		for x in '012':
			for y in '012':
				var cell = $cells.get_node("C"+x+y)
				cell.collision_layer = layer
		
func set_collision_mask(mask):
	collision_mask = mask
	if ready:
		for x in '012':
			for y in '012':
				var cell = $cells.get_node("C"+x+y)
				cell.collision_mask = mask

# Called when the node enters the scene tree for the first time.
func _ready():
	ready = true
	set_collision_layer(collision_layer)
	set_collision_mask(collision_mask)

func craft():
	var item_ids = []
	var items = []
	for x in '012':
		for y in '012':
			var cell = $cells.get_node("C"+x+y)
			var l = cell.get_overlapping_areas()
			if len(l) == 0:
				item_ids.push_back(0)
			else:
				item_ids.push_back(l[0].get_parent().tile_id())
				items.push_back(l[0].get_parent())
	# print(item_ids)
	# print(items)
	if recipes.has(item_ids):
		var item_name = recipes[item_ids]
		# 1 - delete items on top of the box
		for item in items:
			item.get_parent().remove_child(item)
			item.queue_free()
		# 2 - create a node in the center of the box
		var item = $items.create(item_name)
		item.position = $cells/C11.position
		item.collision_layer = 3
		item.collision_mask = 3
		self.add_child(item)
		print("you made a %s" % item_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

const recipes = {
# single resource processing
	[0,0,0,  0,726,0,  0,0,0]: "feather",
	[0,0,0,  0,528,0,  0,0,0]: "string",
	[0,0,0,  0,829,0,  0,0,0]: "croko hide",
	[0,0,0,  0,102,0,  0,0,0]: "planks",
	[0,0,0,  0,103,0,  0,0,0]: "planks",
	[0,0,0,  0,105,0,  0,0,0]: "planks",
	[0,0,0,  0,206,0,  0,0,0]: "wooden stick",
	[0,0,0,  0,205,0,  0,0,0]: "stone slab",
	[0,0,0,  0,343,0,  0,0,0]: "fire",
# wooden stuff
	[0,1219,0,  0,1219,0,  0,1219,0]: "wooden stick",
	[1219,1219,1219, 1219,0,1219,  1219,1219,1219]: "chest",
	[0,232,0, 0,232,0, 0,232,0]: "ladder",
	[0,0,0, 0,0,0, 232,232,232]: "fence",
	[232,1219,1219, 0,1219,1219, 232,1219,1219]: "door",
	[0,0,0, 1219,232,1219, 1219,1219,1219]: "boat",
	[0,0,0, 234,234,234, 1219,1219,1219]: "bed",
# fire stuff
	[0,0,0, 0,2,0, 232,0,0]: "torch",
	[0,232,0, 232,2,232, 1219,1219,1219]: "campfire",
	[0,0,0, 0,1,0, 0,1015,0]: "bricks",
	[0,0,0, 0,1034,0, 0,1015,0]: "iron",
	[0,0,0, 0,6,0, 0,1015,0]: "bottle",
	[0,0,0, 0,4,0, 4,1014,4]: "furnace",
# iron stuff
	[3,0,3, 3,0,3, 3,3,3]: "cauldron",
	[0,0,0, 3,0,3, 0,3,0]: "bucket",
	[0,0,0, 3,0,3, 3,3,3]: "minecart",
	[3,232,3, 3,232,3, 3,232,3]: "rails",
# armor
## croko
	[1811,1811,1811, 1811,0,1811, 0,0,0]: "croko helm",
	[1811,0,1811, 1811,1811,1811, 1811,1811,1811]: "croko chest",
	[0,1232,1811, 1232,1811,1232, 1811,1232,0]: "croko shield",
	[0,0,0, 1811,0,1811, 1811,0,1811]: "croko boots",
	[1811,0,1811, 1811,0,1811, 0,0,0]: "croko gloves",
## iron
	[3,3,3, 3,0,3, 0,0,0]: "iron helm",
	[3,0,3, 3,3,3, 3,3,3]: "iron chest",
	[0,1034,3, 1034,3,1034, 3,1034,0]: "iron shield",
	[0,0,0, 3,0,3, 3,0,3]: "iron boots",
	[3,0,3, 3,0,3, 0,0,0]: "iron gloves",
# weapons and tools
## wood
	[0,0,1219, 0,1219,0, 232,0,0]: "wooden sword",
	[0,0,0, 0,232,1219, 232,0,0]: "wooden axe",
	[1219,1219,0, 0,232,1219, 232,0,1219]: "wooden pickaxe",
## stone
	[0,0,4, 0,4,0, 232,0,0]: "stone sword",
	[0,0,0, 0,232,4, 232,0,0]: "stone axe",
	[4,4,0, 0,232,4, 232,0,4]: "stone pickaxe",
## iron
	[0,0,3, 0,3,0, 232,0,0]: "iron sword",
	[0,0,0, 0,232,3, 232,0,0]: "iron axe",
	[3,3,0, 0,232,3, 232,0,3]: "iron pickaxe",
## misc
	[0,232,1219, 232,1219,232, 1219,232,0]: "wooden shield",
	[0,0,1411, 0,1411,232, 1411,232,0]: "bow",
	[0,0,1034, 0,232,0, 234,0,0]: "arrow",
	[0,0,232, 0,232,0, 232,0,0]: "stave",
	[0,0,0, 0,1033,0, 432,0,0]: "scepter",
# buildings
	[0,0,0, 1306,1306,1306, 1306,303,1306]: "room",
	[0,1306,0, 1306,1306,1306, 1306,303,1306]: "house",
	[1306,0,1306, 1306,1306,1306, 1306,303,1306]: "tower",
	[0,0,0, 1306,1306,1306, 1306,1306,1306]: "wall",
	[1902,1907,1902, 1907,0,1907, 1902,1907,1902]: "castle",
# misc
	[0,0,0, 1032,1033,1032, 1032,1032,1032]: "crown",
	[0,1033,0, 1032,0,1032, 0,1032,0]: "ruby ring",
	[0,3,0, 3,1906,3, 0,3,0]: "UFO",
#	"room": 1908
#	"house": 1901
#	"tower": 1902
#	"castle": 1906
}
