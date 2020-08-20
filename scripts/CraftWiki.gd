extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var items_scene = load("res://scenes/Items.tscn")
var craftbox_scene = load("res://scenes/CraftBox.tscn")
onready var items = items_scene.instance()
onready var craftbox = craftbox_scene.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in craftbox.recipes.values():
		add_item(item)
	
func add_item(item_name):
	var x = items.create(item_name)
	x.position = Vector2(8,8)
	var button = TextureButton.new()
	button.rect_min_size = Vector2(16,16)
	button.add_child(x)
	$root/items/item_list.add_child(button)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
