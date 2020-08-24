extends Node2D


onready var UFO = $level/UFO

func _ready():
	pass # Replace with function body.

#func at(x,y):
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_released("ui_right"):
		UFO.move("right")
	if Input.is_action_just_released("ui_left"):
		UFO.move("left")
	if Input.is_action_just_released("ui_down"):
		UFO.move("down")
	if Input.is_action_just_released("ui_up"):
		UFO.move("up")
	if Input.is_action_just_released("ui_select"):
		if UFO.grabbing:
			var item = UFO.release()
			if item != null:
				$items.add_child(item)
		else:
			UFO.grab()
	else:
		$level/Spawner.spawn()
		$level/CraftBox.craft()
		$level/Despawner.despawn()

func showcase():
	var max_x = 16
	var max_y = 9
	var x = 0
	var y = 0
	for item_name in $items.items:
		var item = $items.create(item_name)
		$items.add_child(item)
		item.position.x = x*16+8
		item.position.y = y*16+8
		x += 1
		if x == max_x:
			x = 0
			y += 1
