extends Node2D

@onready var product_icon: TextureRect = $Control/VBoxContainer/HBoxContainer/TextureRect
@onready var product_name: RichTextLabel = $"Control/VBoxContainer/HBoxContainer/VBoxContainer/Product Name"
@onready var product_price: RichTextLabel = $Control/VBoxContainer/HBoxContainer/VBoxContainer/Price

@onready var return_button: Button = $"Control/VBoxContainer/HBoxContainer2/Return Button"

var price:float

func _ready() -> void:
	return_button.button_down.connect(_returned)
	var current_product = load("res://resources/current_product.tres")
	if current_product:
		product_icon.texture.resource_path = current_product.product_icon
		product_name.text = current_product.product_name
		product_price.text = "$" + str(current_product.product_price)
		price = current_product.product_price
	else:
		print("error loading product")

func _process(delta: float) -> void:
	pass

func _returned():
	get_tree().change_scene_to_file("res://scenes/shop_page.tscn")
