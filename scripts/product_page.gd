extends Node2D

@onready var product_icon: TextureRect = $"Control/VBoxContainer/HBoxContainer/Product Icon"
@onready var product_name: RichTextLabel = $"Control/VBoxContainer/HBoxContainer/VBoxContainer/Product Name"
@onready var product_price: RichTextLabel = $Control/VBoxContainer/HBoxContainer/VBoxContainer/Price
@onready var background: Sprite2D = $"Background"

@onready var add_cart: Button = $"Control/VBoxContainer/HBoxContainer2/Add Cart"
@onready var remove: Button = $Control/VBoxContainer/HBoxContainer2/remove
@onready var count: RichTextLabel = $Control/VBoxContainer/HBoxContainer2/Count
@onready var add: Button = $Control/VBoxContainer/HBoxContainer2/add
@onready var return_button: Button = $"Control/VBoxContainer/HBoxContainer2/Return Button"

var popup_scene = preload("res://scenes/popup.tscn")

var order_count:int = 1
var price:float
var product_info:Dictionary = {}

func _ready() -> void:
	#product page setup
	return_button.pressed.connect(_returned)
	add_cart.pressed.connect(_add_cart)
	remove.pressed.connect(_remove)
	add.pressed.connect(_add)
	var current_product = load("user://resources/current_product.tres")
	if current_product:
		product_name.text = current_product.product_name
		product_icon.texture = load(current_product.product_icon)
		product_price.text = "$" + str(current_product.product_price)
		price = current_product.product_price

func _process(delta: float) -> void:
	#updating the order count display
	count.text = "[center][wave amp=20 freq=2][outline_size=10]" + str(order_count)

func _add_cart():
	#add the current product to the cart
	var product = load("user://resources/current_product.tres")
	product_info["name"] = product.product_name
	product_info["icon"] = product.product_icon
	product_info["price"] = product.product_price
	product_info["amount"] = order_count
	product_info["member"] = ScriptManager.user["name"]
	
	var group_list = ResourceLoader.load("user://resources/group.tres", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	ScriptManager.update_cart()
	if ScriptManager.add_product(product_info.duplicate(true)):
		#reset order_count for action feedback
		order_count = 1
		group_list.update_cart(ScriptManager.group,ScriptManager.cart)
		var popup = popup_scene.instantiate()
		popup.message = "The product has been added\nto you cart!"
		get_tree().current_scene.add_child(popup)
		print("User " + ScriptManager.user["name"] + " purchased " + str(product_info["amount"]) + " " + product_info["name"])
	else:
		var popup = popup_scene.instantiate()
		popup.message = "Unable to add the product\nThe cart is full"
		get_tree().current_scene.add_child(popup)
		print("User " + ScriptManager.user["name"] + " tried to purchase " + str(product_info["amount"]) + " " + product_info["name"] + " but cart is full")

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
