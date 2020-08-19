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
	print(item_ids)
	print(items)
	if recipes.has(item_ids):
		var item_name = recipes[item_ids]
		# 1 - delete items on top of the box
		for item in items:
			item.get_parent().remove_child(item)
			item.queue_free()
		# 2 - create a node in the center of the box
		var item = $items.create(item_name)
		item.position = $cells/C11.position
		print(item.collision_layer)
		print(item.collision_mask)
		self.add_child(item)
		print("you made a %s" % item_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

const recipes = {
	[0, 0, 0,  0, 1219, 0,  0, 1219, 0]: "wooden stick",
	[1219, 1219, 1219,  1219, 0, 1219,  1219, 1219, 1219]: "chest",
	[0, 0, 0, 0, 2, 0, 0, 232, 0]: "torch",
	[232, 0, 232, 232, 232, 232, 232, 0, 232]: "ladder",
	[0, 0, 0, 1219, 232, 1219, 1219, 232, 1219]: "fence",
	[1219, 1219, 0, 1219, 1219, 0, 1219, 1219, 0]: "door",
	[0, 0, 0, 0, 0, 0, 0, 0, 0]: "minecart",
}
#	"dirt": [1, 0, "553300"],
#	"coal": [2, 0, "1b1b1b"],
#	"stone": [3, 0, "7b7b7b"],
#	"torch": [43, 3, "e81919"],
#	"fence": [1, 3, "ca9c60"],
#	"wooden stick": [32, 2, "ca9c60"],
#	"door": [3, 3, "ca9c60"],
#	"planks": [19, 12, "ca9c60"],
#	"ladder": [0, 6, "ca9c60"],
