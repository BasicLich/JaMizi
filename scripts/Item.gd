tool
extends Node2D

var ready = false
var tile_size = 16
export (int) var tile_x setget set_tile_x
export (int) var tile_y setget set_tile_y
export (Color, RGBA) var color setget set_color
export (int, LAYERS_2D_PHYSICS) var collision_layer = 3 setget set_collision_layer
export (int, LAYERS_2D_PHYSICS) var collision_mask = 3 setget set_collision_mask

func tile_id():
	return tile_x + tile_y * 100

func set_collision_layer(layer):
	collision_layer = layer
	if ready:
		$Area2D.collision_layer = layer
		
func set_collision_mask(mask):
	collision_mask = mask
	if ready:
		$Area2D.collision_mask = mask

func set_color(c):
	color = c
	if ready:
		$Sprite.modulate = c

func update_region_rect():
	if ready:
		$Sprite.region_rect = Rect2(tile_x * (tile_size+1), tile_y * (tile_size+1), tile_size, tile_size)

func set_tile_x(x):
	tile_x = x
	update_region_rect()

func set_tile_y(y):
	tile_y = y
	update_region_rect()

func _ready():
	ready = true
	update_region_rect()
	set_collision_layer(collision_layer)
	set_collision_mask(collision_mask)
	set_color(color)

func _process(delta):
	pass
