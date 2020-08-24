extends Control

signal accepted
func _ready():
	pass
func _process(_delta):
	if Input.is_action_just_released("ui_accept"):
		emit_signal("accepted")
