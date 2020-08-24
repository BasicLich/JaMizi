extends Node2D

export var animation_speed = 1.0 setget set_animation_speed
var action_history = []
var action_index = 0
var autopilot = false

var grabbing
var ready = false

signal drop_item(item)

func set_animation_speed(speed):
	animation_speed = speed
	if ready:
		$pivot/AnimationPlayer.playback_speed = animation_speed

func _ready():
	ready = true
	$pivot.position = Vector2(0,0)
	$pivot/sprite.collision_layer = 0
	$pivot/sprite.collision_mask = 1
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
	if autopilot:
		if anim_name != "wait":
			action_index += 1
		if action_index == len(action_history):
			action_index = 0
		var next_action = action_history[action_index]
#		print("%s next action is %s" % [self, next_action])
		if next_action in ["up", "down", "left", "right"]:
			move(next_action)
		elif next_action == "release":
			var item = release()
			if item:
				$pivot/AnimationPlayer.queue("success")
			else:
				$pivot/AnimationPlayer.queue("wait")
		else:
			var item = grab(next_action)
#			print("item grabbed is %s " % item.item_name)
			if item == null:
				$pivot/AnimationPlayer.queue("wait")
			else:
				$pivot/AnimationPlayer.queue("success")

func wait():
	$pivot/AnimationPlayer.queue("wait")

func _on_AnimationPlayer_animation_changed(anim_name, _new_name):
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

func grab(what = ""):
	if not grabbing:
		var ll = $pivot/sprite/Area2D.get_overlapping_areas()
		if len(ll) != 0:
			for l in ll:
				var item = l.get_parent()
				if not item.taken:
					var item_name = item.item_name
					if what == "" or what == item_name:
						item.position = Vector2(0,0)
						item.get_parent().remove_child(item)
						$pivot/bag.add_child(item)
						item.collision_mask = 0
						item.collision_layer = 0
						item.taken = true
#						print("%s grabbed %s" % [self, item.item_name])
						grabbing = true
						return item
#	print("%s grabbed nothing" % self)
	return null

func release():
	if grabbing:
		var l = $pivot/sprite/Area2D.get_overlapping_areas()
		if len(l) == 0:
			var item = $pivot/bag.get_child(0)
			$pivot/bag.remove_child(item)
			item.position = position
			item.collision_mask = 3
			item.collision_layer = 3
			item.taken = false
			grabbing = false
#			print("%s dropped %s" % [self, item.item_name])
			emit_signal("drop_item", item)
			return item
	return null

