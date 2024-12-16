extends Node2D

@onready var product_list: VBoxContainer = $"Control/ScrollContainer/Product List"

@onready var background: Sprite2D = $Background
@onready var cart_page_button: TextureRect = $"Control/Cart Page Button"
@onready var back_button: Button = $"Control/Back Button"

#Predefined shop product
var shop_product: Array = [
	{"name": "Water", "icon": "res://sprites/product/water.png", "price": 10.5},
	{"name": "Banana", "icon": "res://sprites/product/banana.png", "price": 3.75},
	{"name": "Lettuce", "icon": "res://sprites/product/lettuce.png", "price": 3.95},
	{"name": "Orange", "icon": "res://sprites/product/orange.png", "price": 3.99},
	{"name": "Carrot", "icon": "res://sprites/product/carrot.png", "price": 6.99},
	{"name": "Kiwi", "icon": "res://sprites/product/kiwi.png", "price": 7.99},
	{"name": "Peach", "icon": "res://sprites/product/peach.png", "price": 13.75},
	{"name": "Lemon", "icon": "res://sprites/product/lemon.png", "price": 7.5},
	{"name": "Broccoli", "icon": "res://sprites/product/broccoli.png", "price": 12.95},
	{"name": "Tomato", "icon": "res://sprites/product/tomato.png", "price": 4.7},
	{"name": "Ketchup", "icon": "res://sprites/product/ketchup.png", "price": 15.5},
	{"name": "Potato", "icon": "res://sprites/product/potato.png", "price": 4.25},
	{"name": "Cucumber", "icon": "res://sprites/product/cucumber.png", "price": 5.8},
	{"name": "Corn", "icon": "res://sprites/product/corn.png", "price": 10.5},
	{"name": "Mushroom", "icon": "res://sprites/product/mushroom.png", "price": 9.99},
	{"name": "Apple", "icon": "res://sprites/product/apple.png", "price": 5.99},
	{"name": "Apple IPhone 12 256 GB", "icon": "res://sprites/product/iphone.png", "price": 1299.99},
	{"name": "Onion", "icon": "res://sprites/product/onion.png", "price": 4.5},
	{"name": "Chicken", "icon": "res://sprites/product/chicken.png", "price": 18.9},
	{"name": "Beef", "icon": "res://sprites/product/beef.png", "price": 33.5},
	{"name": "Milk", "icon": "res://sprites/product/milk.png", "price": 14.99},
	{"name": "Yogurt", "icon": "res://sprites/product/yogurt.png", "price": 6.99},
	{"name": "Shopping Bag", "icon": "res://sprites/product/shopping_bag.png", "price": 7.5},
	{"name": "Shampoo", "icon": "res://sprites/product/shampoo.png", "price": 21.99},
	{"name": "Pen", "icon": "res://sprites/product/pen.png", "price": 9.99},
	{"name": "Eraser", "icon": "res://sprites/product/eraser.png", "price": 1.5},
	{"name": "Desk Lamp", "icon": "res://sprites/product/desk_lamp.png", "price": 14.99},
	{"name": "Xiaomi Redmi 14c Dual Sim", "icon": "res://sprites/product/xiaomi.png", "price": 479.99},
	{"name": "Asus Rog Azoth Extreme RGB Gaming Keyboard", "icon": "res://sprites/product/keyboard.png", "price": 2149.99},
	{"name": "Csgo Shanghai Major Pass", "icon": "res://sprites/product/csgo_pass.png", "price": 69.99}
]

func _ready() -> void:
	#shop page setup
	back_button.pressed.connect(_back)
	#for i in range(30):
	#	var the_product = product_list.get_child(floor(i / 5)).get_child(i % 5)
	#	the_product.product_name = shop_product[i]["name"]
	#	the_product.product_icon = shop_product[i]["icon"]
	#	the_product.product_price = shop_product[i]["price"]
	#	the_product.product_setup()

func _back():
	print("User " + ScriptManager.user["name"] + " logged out")
	get_tree().change_scene_to_file("res://scenes/login_page.tscn")
