extends Node2D

@onready var product_icon: TextureRect = $Control/VBoxContainer/HBoxContainer/TextureRect
@onready var product_name: RichTextLabel = $"Control/VBoxContainer/HBoxContainer/VBoxContainer/Product Name"
@onready var product_price: RichTextLabel = $Control/VBoxContainer/HBoxContainer/VBoxContainer/Price

@onready var add_cart: Button = $"Control/VBoxContainer/HBoxContainer2/Add Cart"
@onready var remove: Button = $Control/VBoxContainer/HBoxContainer2/remove
@onready var count: RichTextLabel = $Control/VBoxContainer/HBoxContainer2/Count
@onready var add: Button = $Control/VBoxContainer/HBoxContainer2/add
@onready var return_button: Button = $"Control/VBoxContainer/HBoxContainer2/Return Button"

var order_count:int = 1
var price:float
var product_info:Dictionary = {}

func _ready() -> void:
	#product page setup
	return_button.pressed.connect(_returned)
	add_cart.pressed.connect(_add_cart)
	remove.pressed.connect(_remove)
	add.pressed.connect(_add)
	var current_product = load("res://resources/current_product.tres")
	if current_product:
		#adjusting the product image
		var img = Image.load_from_file(current_product.product_icon)
		img.resize(img.get_width() * 0.5, img.get_height() * 0.5)
		var image := Texture2D.new()
		image = ImageTexture.create_from_image(img)
		image.update(img)
		product_icon.texture = image
		
		product_name.text = current_product.product_name
		product_price.text = "$" + str(current_product.product_price)
		price = current_product.product_price

func _process(delta: float) -> void:
	#updating the order count display
	count.text = "[center][wave amp=20 freq=2][outline_size=10]" + str(order_count)

func _add_cart():
	#add the current product to the cart
	var product = load("res://resources/current_product.tres")
	product_info["name"] = product.product_name
	product_info["icon"] = product.product_icon
	product_info["price"] = product.product_price
	product_info["amount"] = order_count
	#reset order_count for action feedback
	order_count = 1
	ScriptManager.add_product(product_info.duplicate(true))

func _remove():
	#reducing order count by 1
	if order_count > 1:
		order_count -= 1

func _add():
	#increasing order count by 1
	if order_count < 99:
		order_count += 1

func _returned():
	#when return button is clicked
	get_tree().change_scene_to_file("res://scenes/shop_page.tscn")
