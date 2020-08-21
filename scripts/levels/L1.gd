extends Node2D

var ready = false

func _ready():
	ready = true
	update_items()

func _process(delta):
	pass
#	if Input.is_action_just_released("ui_select"):
#		update_items()

func update_items():
	if ready:
		$items.clear()
		stuff()
		$items.load_items(starting_items)

func cmp_pos(p,q):
	if p[1] < q[1]:
		return true
	if p[1] > q[1]:
		return false
	if p[0] < q[0]:
		return true
	return false

func stuff():
	print ('{')
	for i in starting_items:
		starting_items[i].sort_custom(self, "cmp_pos")
		print('"%s":'%i)
		print(starting_items[i])
		print(',')
	print ('}')

func reset_starting_items():
	starting_items = {
		"tree": [
		],
		"big tree": [
		],
		"2 trees": [
		],
		"branches": [
		]
	}
	
func randomize_starting_items():
	for i in starting_items:
		for n in range(randi()%10+20):
			starting_items[i].push_back([randi()%15, randi()%9])
	for i in starting_items:
		var filtered = []
		for pos in starting_items[i]:
			if 3 < pos[0] and pos[0] < 11 and 0 < pos[1] and pos[1] < 8:
				continue
			else:
				filtered.push_back(pos)
		starting_items[i] = filtered
	print(starting_items)

var starting_items = {
	"2 trees": [
		[13, 0], [1, 1], [11, 1], [12, 1],
		[0, 4], [3, 4], [12, 6], [0, 8], [1, 8],
		[5, 8]],
	"big tree": [
		[0, 0], [1, 0], [2, 1], [13, 1], [14, 1],
		[13, 7], [3, 8]],
	"branches": [
		[7, 0], [11, 0], [3, 3], [1, 4], 
		[13, 5], [1, 7], [7, 8], [9, 8], [12, 8]],
	"tree": [
		[5, 0], [8, 0], [9, 0], [12, 0], [12, 2], [0, 3], [14, 3],
		[3, 5], [2, 6], [11, 6], [14, 6], [0, 7],  [11, 8], 
		[14, 8]],
}
