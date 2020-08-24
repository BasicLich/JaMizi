extends Control

var level_name = ""

signal level_done
signal open_menu
signal open_craft_wiki
signal skip_level
signal go_back

var level = null
var speed_level = 3
var speed_levels = [
	1.0/8.0,
	1.0/4.0,
	1.0/2.0,
	1.0,
	2.0,
	4.0,
	8.0,
]

func _ready():
	level = $level
	update_speed(speed_level)

func speed_up():
	update_speed(speed_level+1)

func slow_down():
	update_speed(speed_level-1)

func update_speed(new_speed_level):
	speed_level = clamp(new_speed_level, 0, 6)
	var speed = speed_levels[speed_level]
	$UI/speed/Sprite.region_rect = Rect2(612+17*speed_level,289,16,16)
#	print(speed)
	for d in $drones.get_children():
		d.animation_speed = speed

func _process(_delta):
	if visible:
		if Input.is_action_just_released("ui_q"):
			slow_down()
		if Input.is_action_just_released("ui_e"):
			speed_up()
		if Input.is_action_pressed("ui_c"):
			emit_signal("open_craft_wiki")
		if Input.is_action_just_released("ui_cancel"):
			emit_signal("open_menu")
		if Input.is_action_just_released("ui_restart"):
			reload_level()
		if Input.is_action_just_released("ui_right"):
			$Cursor.move("right")
		if Input.is_action_just_released("ui_left"):
			$Cursor.move("left")
		if Input.is_action_just_released("ui_down"):
			$Cursor.move("down")
		if Input.is_action_just_released("ui_up"):
			$Cursor.move("up")
		if Input.is_action_just_released("ui_select"):
			$Cursor.press_space()
#			var item = $Cursor.press_space()
#			if item:
#				item.position = $Cursor.position
#				$items.add_child(item)
		update_things()

func update_things():
	if level:
		for b in $level/boxes.get_children():
			b.craft()
		for s in $level/spawns.get_children():
			s.spawn()
		for e in $level/exits.get_children():
			e.despawn()
		var level_done = true
		for e in $level/exits.get_children():
			if e.collected < 10:
				level_done = false
				break
		if level_done:
			emit_signal("level_done")

func load_level(new_level_name):
	level_name = new_level_name
	if level:
		$level.queue_free()
		remove_child($level)
		level = null
	clean($items)
	clean($drones)
	$Cursor.queue_free()
	remove_child($Cursor)
	var cursor = load("res://scenes/Cursor.tscn").instance()
	add_child(cursor)
	$Cursor.position = Vector2(8,8)
#	$Cursor.position = Vector2(104,72)
	$Cursor.connect("drone_created", self, "add_new_drone")
	if level_name == "":
		return
	if level_name == null:
		return
	level = load("res://scenes/levels/%s.tscn" % level_name).instance()
	level = load("res://scenes/levels/%s.tscn" % level_name).instance()
	add_child(level)

func reload_level():
	load_level(level_name)

func clean(node):
	for c in node.get_children():
		node.remove_child(c)
		c.queue_free()

func _on_drone_item_drop(item):
	$items.add_child(item)

func add_new_drone(drone):
	drone.position = $Cursor.position
	$drones.add_child(drone)
	drone.connect("drop_item", self, "_on_drone_item_drop")
	drone.autopilot = true
	drone.animation_speed = speed_levels[speed_level]
#	drone.get_node("pivot/sprite").color.r += (randf()-0.5) / 10
#	drone.get_node("pivot/sprite").color.g += (randf()-0.5) / 10
#	drone.get_node("pivot/sprite").color.b += (randf()-0.5) / 10
	drone.wait()


func _on_craft_wiki_pressed():
	emit_signal("open_craft_wiki")

func _on_menu_pressed():
	emit_signal("open_menu")


func _on_skip_pressed():
	emit_signal("skip_level")


func _on_back_pressed():
	emit_signal("go_back")
