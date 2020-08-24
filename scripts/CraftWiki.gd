extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var items_scene = load("res://scenes/Items.tscn")
var craftbox_scene = load("res://scenes/CraftBox.tscn")
onready var items = items_scene.instance()
onready var craftbox = craftbox_scene.instance()

signal close

# Called when the node enters the scene tree for the first time.
func _ready():
	for recipe in craftbox.recipes:
		add_recipe(recipe, craftbox.recipes[recipe])
	
func add_recipe(recipe, result):
	var item = items.create(result)
	item.position = Vector2(8,8)
	var button = TextureButton.new()
	button.rect_min_size = Vector2(16,16)
	button.add_child(item)
	button.connect("pressed", self, "button_clicked", [button, recipe, result])
	$root/items/item_list.add_child(button)

func button_clicked(_target, recipe, result):
	for node in $root/recipe/from/items.get_children():
		$root/recipe/from/items.remove_child(node)
	for node in $root/recipe/to/items.get_children():
		$root/recipe/to/items.remove_child(node)
	for i in range(9):
		var item_id = recipe[i]
		if item_id != 0:
			var item_name = items.from_id(item_id)
			var item = items.create(item_name)
			item.position = $root/recipe/from/cells.get_child(i).position
			item.collision_layer = 0
			$root/recipe/from/items.add_child(item)
	var item = items.create(result)
	item.position = $root/recipe/to/cells/C11.position
	item.collision_layer = 0
	$root/recipe/to/items.add_child(item)

func _process(_delta):
	if Input.is_action_just_released("ui_c"):
		emit_signal("close")
	if Input.is_action_just_released("ui_cancel"):
		emit_signal("close")
