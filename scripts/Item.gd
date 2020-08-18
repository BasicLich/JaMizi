tool
extends Node2D

export var tile_x = 1 setget set_tile_x
export var tile_y = 0 setget set_tile_y
#export var pos_x = 0 setget set_pos_x
#export var pos_y = 0 setget set_pos_y
var tile_size = 16
var ready = false

func update_region_rect():
	if ready:
		$Sprite.region_rect = Rect2(tile_x * tile_size, tile_y * tile_size, tile_size, tile_size)

func set_tile_x(x):
	tile_x = x
	update_region_rect()

func set_tile_y(y):
	tile_y = y
	update_region_rect()

#func set_pos_x(x):
#	pos_x = x


func _ready():
	ready = true
	update_region_rect()

func _process(delta):
	pass
