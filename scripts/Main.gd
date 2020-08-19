extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	showcase()

#func at(x,y):
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_right"):
		$UFO.move("right")
	if Input.is_action_just_released("ui_left"):
		$UFO.move("left")
	if Input.is_action_just_released("ui_down"):
		$UFO.move("down")
	if Input.is_action_just_released("ui_up"):
		$UFO.move("up")
	if Input.is_action_just_released("ui_select"):
		if $UFO.grabbing:
			var item = $UFO.release()
			if item != null:
				$items.add_child(item)
		else:
			$UFO.grab()
		$CraftBox.craft()

func showcase():
	var max_x = 16
	var max_y = 9
	var x = 0
	var y = 0
	for item_name in $CraftBox/items.items:
		var item = $CraftBox/items.create(item_name)
		$items.add_child(item)
		item.position.x = x*16+8
		item.position.y = y*16+8
		x += 1
		if x == max_x:
			x = 0
			y += 1
