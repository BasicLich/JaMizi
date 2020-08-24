extends Control

var levels = [
	"00 planks",
	"01 stick",
	"02 ladder",
	"03 fence",
	"04 chest",
	"05 boat",
	"06 ladder 2",
	"07 door",
	"08 scepter",
	"10 iron",
	"11 cauldron",
	"12 potion",
	"13 rails",
	"14 shield",
	"20 bricks",
	"21 house",
	"22 furnace",
]

var level_index = 0

func _ready():
	populate_levels()

func _on_Credits_accepted():
	$Credits.visible = false
	$Credits.disconnect("accepted", self, "_on_Credits_accepted")
#	remove_child(c)
#	c.queue_free()
	$Controls.visible = true
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_timer_process_mode(0)
	timer.set_wait_time(0.01)
	timer.connect("timeout", self, "connect_controls")
	self.add_child(timer)
	timer.start()

func _process(_delta):
	if $level_selection.visible:
		if Input.is_action_just_released("ui_cancel"):
			$level_selection.visible = false
			$MainMenu.visible = true

func connect_controls():
	$Controls.connect("accepted", self, "_on_Controls_accepted")

func _on_Controls_accepted():
	$Controls.visible = false
	$Controls.disconnect("accepted", self, "_on_Controls_accepted")
	$Notes.visible = true
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_timer_process_mode(0)
	timer.set_wait_time(0.01)
	timer.connect("timeout", self, "connect_notes")
	self.add_child(timer)
	timer.start()


func connect_notes():
	$Notes.connect("accepted", self, "_on_Notes_accepted")

func _on_Notes_accepted():
	$Notes.disconnect("accepted", self, "_on_Notes_accepted")
	$Notes.visible = false
	$MainMenu.visible = true
	$MainMenu/c/v/new_game.connect("pressed", self, "_on_new_game_pressed")
	$MainMenu/c/v/levels.connect("pressed", self, "_on_levels_pressed")

func _on_new_game_pressed():
	$MainMenu.visible = false
	level_index = 0
	$Gameplay.load_level(levels[level_index])
	show_gameplay()

func _on_levels_pressed():
	$MainMenu.visible = false
	$level_selection.visible = true

func _on_Gameplay_level_done():
	$Gameplay.load_level("")
	level_index += 1
	hide_gameplay()
	if level_index == len(levels):
		$game_done.visible = true
		$game_done.connect("accepted", self, "_on_game_done_accepted")
	else:
		$level_done.visible = true
		$level_done.connect("accepted", self, "_on_level_done_accepted")

func _on_level_done_accepted():
	$level_done.disconnect("accepted", self, "_on_level_done_accepted")
	$level_done.visible = false
	$Gameplay.load_level(levels[level_index])
	show_gameplay()

func _on_game_done_accepted():
	$game_done.disconnect("accepted", self, "_on_game_done_accepted")
	$game_done.visible = false
	$MainMenu.visible = true

func populate_levels():
	for i in range(levels.size()):
		var l = levels[i]
		var b = Button.new()
		b.text = l
		b.align = Button.ALIGN_LEFT
		b.flat = true
		b.connect("pressed", self, "_on_level_chosen", [i])
		$level_selection/v.add_child(b)

func _on_level_chosen(level_id):
	$level_selection.visible = false
	level_index = level_id
	$Gameplay.load_level(levels[level_index])
	show_gameplay()

func _on_gameplay_open_menu():
	hide_gameplay()
	$MainMenu.visible = true

func _on_gameplay_open_craft_wiki():
	hide_gameplay()
	show_craft_wiki()

func show_gameplay():
	$Gameplay.visible = true
	$Gameplay.connect("open_menu", self, "_on_gameplay_open_menu")
	$Gameplay.connect("open_craft_wiki", self, "_on_gameplay_open_craft_wiki")
	$Gameplay.connect("skip_level", self, "_on_gameplay_skip_level")
	$Gameplay.connect("go_back", self, "_on_gameplay_go_back")

func hide_gameplay():
	$Gameplay.visible = false
	$Gameplay.disconnect("open_menu", self, "_on_gameplay_open_menu")
	$Gameplay.disconnect("open_craft_wiki", self, "_on_gameplay_open_craft_wiki")
	$Gameplay.disconnect("skip_level", self, "_on_gameplay_skip_level")
	$Gameplay.disconnect("go_back", self, "_on_gameplay_go_back")

func show_craft_wiki():
	$CraftWiki.visible = true
	$CraftWiki.connect("close", self, "_on_craft_wiki_close")

func hide_craft_wiki():
	$CraftWiki.visible = false
	$CraftWiki.disconnect("close", self, "_on_craft_wiki_close")

func _on_craft_wiki_close():
	hide_craft_wiki()
	show_gameplay()

func _on_gameplay_skip_level():
	level_index += 1
	if level_index == len(levels):
		_on_gameplay_open_menu()
	else:
		$Gameplay.load_level(levels[level_index])

func _on_gameplay_go_back():
	level_index -= 1
	if level_index == -1:
		_on_gameplay_open_menu()
	else:
		$Gameplay.load_level(levels[level_index])
