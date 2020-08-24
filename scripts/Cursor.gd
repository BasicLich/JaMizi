extends Node2D

var active_drone = null
var hidden_drone = null
var UFO_scene = load("res://scenes/UFO.tscn")

signal drone_created(drone)

func _ready():
	create_hidden_drone()

func move(dir):
	if active_drone:
		active_drone.action_history.push_back(dir)
	if dir == "left":
		position.x -= 16
	if dir == "right":
		position.x += 16
	if dir == "down":
		position.y += 16
	if dir == "up":
		position.y -= 16

func create_hidden_drone():
	hidden_drone = UFO_scene.instance()
	$pivot/bag.add_child(hidden_drone)
	hidden_drone.visible = false

func create_drone():
	active_drone = hidden_drone
	active_drone.visible = true
	hidden_drone = null

func press_space():
	if active_drone == null:
		var ll = $pivot/sprite/Area2D.get_overlapping_areas()
		for l in ll:
			var item = l.get_parent()
			if not item.taken:
				create_drone()
				var item_2 = active_drone.grab()
				var item_name = item_2.item_name
				active_drone.action_history.push_back(item_name)
				break
		return null
	else:
		if not active_drone.grabbing:
			# should never happen
			return null
		else:
			active_drone.action_history.push_back("release")
			# extend drone history to go backwards
			var opposite = {
				"left": "right",
				"right": "left",
				"up": "down",
				"down": "up",
			}
			var moves = []
			for m in active_drone.action_history:
				if opposite.has(m):
					moves.push_back(opposite[m])
			moves.invert()
			for m in active_drone.action_history:
				moves.push_back(m)
			active_drone.action_history = moves
#			print(active_drone.action_history)
			$pivot/bag.remove_child(active_drone)
			emit_signal("drone_created", active_drone)
			create_hidden_drone()
			var item = active_drone.release()
			active_drone = null
			return item

