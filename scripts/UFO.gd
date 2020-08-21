extends Node2D

export var animation_speed = 1.0 setget set_animation_speed

var grabbing
var ready = false

func set_animation_speed(speed):
	animation_speed = speed
	if ready:
		$pivot/AnimationPlayer.playback_speed = animation_speed

func _ready():
	ready = true
	$pivot.position = Vector2(0,0)
	grabbing = false
	set_animation_speed(animation_speed)


func move(dir):
	$pivot/AnimationPlayer.queue(dir)
#	$pivot/AnimationPlayer.play(dir, -1, animation_speed)

#func _process(delta):
#	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "left":
		position.x -= 16
	if anim_name == "right":
		position.x += 16
	if anim_name == "down":
		position.y += 16
	if anim_name == "up":
		position.y -= 16
	$pivot.position = Vector2(0,0)

func _on_AnimationPlayer_animation_changed(anim_name, new_name):
	if anim_name == "left":
		position.x -= 16
	if anim_name == "right":
		position.x += 16
	if anim_name == "down":
		position.y += 16
	if anim_name == "up":
		position.y -= 16
	$pivot.position = Vector2(0,0)
	pass # Replace with function body.

func grab():
	if not grabbing:
		var l = $pivot/sprite/Area2D.get_overlapping_areas()
		if len(l) != 0:
			var item = l[0].get_parent()
			item.position = Vector2(0,0)
			item.get_parent().remove_child(item)
			$pivot/bag.add_child(item)
			item.collision_mask = 0
			item.collision_layer = 0
			print("grabbed a thing")
			grabbing = true
			return
	print("grabbed nothing")

func release():
	if grabbing:
		var l = $pivot/sprite/Area2D.get_overlapping_areas()
		if len(l) == 0:
			var item = $pivot/bag.get_child(0)
			$pivot/bag.remove_child(item)
			item.position = position
			item.collision_mask = 3
			item.collision_layer = 3
			grabbing = false
			print("dropped a thing")
			return item
	return null

