extends Control

@onready var playerui = $"."

func _process(delta):
	playerui.global_position = playerui.get_global_mouse_position() - playerui.size/2
