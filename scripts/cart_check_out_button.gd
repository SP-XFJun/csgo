extends TextureRect

var wait_time = 0

func _ready() -> void:
	gui_input.connect(_clicked)

func _process(delta: float) -> void:
	#manually decreasing mouse click interval
	if wait_time > 0:
		wait_time -= delta

func _clicked(event: InputEvent):
	if event.is_action_pressed("mouse left click"):
		wait_time = 0.2 #only continue proccessing and loading the check out page
						#if mouse clicked and released within 0.2 seconds
	if event.is_action_released("mouse left click") and wait_time > 0:
		get_tree().change_scene_to_file("res://scenes/check_out_page.tscn")