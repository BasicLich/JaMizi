extends Node2D

export var item_name = "planks" setget set_item_name

var collected = 0

func set_item_name (new_name):
	item_name = new_name
	update_item()

func update_item():
	var item = $items.create(item_name)
	$template.tile_x = item.tile_x
	$template.tile_y = item.tile_y
	$CPUParticles2D.modulate = item.color
	$CPUParticles2D.modulate.a = 0.5

signal collected_item

func _ready():
	$template.collision_layer = 0
	$template.collision_mask = 2
	update_item()

func spawn():
	var l = $template/Area2D.get_overlapping_areas()
	if len(l) == 0:
		var item = $items.create(item_name)
		item.collision_layer = 3
		item.collision_mask = 3
		$items.add_child(item)

func despawn():
	var l = $template/Area2D.get_overlapping_areas()
	if len(l) != 0:
		var item = l[0].get_parent()
		if $items.get_item_name(item) == item_name:
			item.get_parent().remove_child(item)
			item.queue_free()
			collected += 1
			emit_signal("collected_item")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
