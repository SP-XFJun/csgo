extends Node2D

@onready var total_price: RichTextLabel = $"Control/VBoxContainer/HBoxContainer/VBoxContainer/Total Price"

@onready var background: Sprite2D = $Background
@onready var check_out_button: Button = $"Control/VBoxContainer/HBoxContainer2/Check Out Button"
@onready var total_cost: RichTextLabel = $"Control/VBoxContainer/HBoxContainer2/Total Cost"
@onready var return_button: Button = $"Control/VBoxContainer/HBoxContainer2/Return Button"

func _ready() -> void:
	#check out page setup
	check_out_button.pressed.connect(_check_out)
	return_button.pressed.connect(_returned)
	total_price.text = "$" + str(ScriptManager.total_cost)
	#user will not pay for delivery fees if they did not buy anything
	if ScriptManager.total_cost == 0:
		total_cost.text = "[wave amp=20 freq=2][outline_size=10] $0"
	else:
		total_cost.text = "[wave amp=20 freq=2][outline_size=10] $" + str(ScriptManager.total_cost + 5)
	#adjusting the background image
	var img = Image.load_from_file("res://sprites/white background.jpg")
	img.resize(img.get_width() * 1.5, img.get_height() * 1.5)
	var image := Texture2D.new()
	image = ImageTexture.create_from_image(img)
	image.update(img)
	background.texture = image

func _check_out():
	#when user pays the bill, will be worked on
	pass

func _returned():
	#when return button is clicked
	get_tree().change_scene_to_file("res://scenes/cart_page.tscn")
