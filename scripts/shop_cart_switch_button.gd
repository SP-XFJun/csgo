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
		wait_time = 0.2 #only continue proccessing and loading the product page 
						#if mouse clicked and released within 0.2 seconds
	if event.is_action_released("mouse left click") and wait_time > 0:
		if get_tree().current_scene.scene_file_path == "res://scenes/shop_page.tscn":
			get_tree().change_scene_to_file("res://scenes/cart_page.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/shop_page.tscn")
