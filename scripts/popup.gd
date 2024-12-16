extends Node2D

@export var message: String

@onready var popup_layer: TextureRect = $"Popup Layer"
@onready var cart_button: Button = $"Cart Button"
@onready var label: Label = $Label

var wait_time:float = 0

func _ready() -> void:
	popup_layer.gui_input.connect(_on_input)
	cart_button.pressed.connect(_cart)
	label.text = message

func _process(delta: float) -> void:
	#manually decreasing mouse click interval
	if wait_time > 0:
		wait_time -= delta

func _on_input(event: InputEvent):
	#when click outside the popup
	if event.is_action_pressed("mouse left click"):
		wait_time = 0.2 #only continue proccessing if mouse clicked and released within 0.2 seconds
	if event.is_action_released("mouse left click") and wait_time > 0:
		queue_free()

func _cart():
	get_tree().change_scene_to_file("res://scenes/cart_page.tscn")
