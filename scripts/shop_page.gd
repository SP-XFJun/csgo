extends Node2D

@onready var product_list: VBoxContainer = $"Control/ScrollContainer/Product List"

@onready var background: Sprite2D = $Background
@onready var cart_page_button: TextureRect = $"Control/Cart Page Button"
#Predefined shop product
const APPLE = preload("res://sprites/product/apple.png")
const BANANA = preload("res://sprites/product/banana.png")
const BEEF = preload("res://sprites/product/beef.png")
const BROCCOLI = preload("res://sprites/product/broccoli.png")
const CARROT = preload("res://sprites/product/carrot.png")
const CHICKEN = preload("res://sprites/product/chicken.png")
const CORN = preload("res://sprites/product/corn.png")
const CSGO_PASS = preload("res://sprites/product/csgo_pass.png")
const CUCUMBER = preload("res://sprites/product/cucumber.png")
const DESK_LAMP = preload("res://sprites/product/desk_lamp.png")
const EMPTY_SLOT = preload("res://sprites/product/empty_slot.png")
const ERASER = preload("res://sprites/product/eraser.png")
const IPHONE = preload("res://sprites/product/iphone.png")
const KETCHUP = preload("res://sprites/product/ketchup.png")
const KEYBOARD = preload("res://sprites/product/keyboard.png")
const KIWI = preload("res://sprites/product/kiwi.png")
const LEMON = preload("res://sprites/product/lemon.png")
const LETTUCE = preload("res://sprites/product/lettuce.png")
const MILK = preload("res://sprites/product/milk.png")
const MUSHROOM = preload("res://sprites/product/mushroom.png")
const ONION = preload("res://sprites/product/onion.png")
const ORANGE = preload("res://sprites/product/orange.png")
const PEACH = preload("res://sprites/product/peach.png")
const PEN = preload("res://sprites/product/pen.png")
const POTATO = preload("res://sprites/product/potato.png")
const SHAMPOO = preload("res://sprites/product/shampoo.png")
const SHOPPING_BAG = preload("res://sprites/product/shopping_bag.png")
const TOMATO = preload("res://sprites/product/tomato.png")
const WATER = preload("res://sprites/product/water.png")
const XIAOMI = preload("res://sprites/product/xiaomi.png")
const YOGURT = preload("res://sprites/product/yogurt.png")
var shop_product: Array = [{"name": "Water", "icon": WATER, "price": 10.5},
	{"name": "Banana", "icon": BANANA, "price": 3.75},
	{"name": "Lettuce", "icon": LETTUCE, "price": 3.95},
	{"name": "Orange", "icon": ORANGE, "price": 3.99},
	{"name": "Carrot", "icon": CARROT, "price": 6.99},
	{"name": "Kiwi", "icon": KIWI, "price": 7.99},
	{"name": "Peach", "icon": PEACH, "price": 13.75},
	{"name": "Lemon", "icon": LEMON, "price": 7.5},
	{"name": "Broccoli", "icon": BROCCOLI, "price": 12.95},
	{"name": "Tomato", "icon": TOMATO, "price": 4.7},
	{"name": "Ketchup", "icon": KETCHUP, "price": 15.5},
	{"name": "Potato", "icon": POTATO, "price": 4.25},
	{"name": "Cucumber", "icon": CUCUMBER, "price": 5.8},
	{"name": "Corn", "icon": CORN, "price": 10.5},
	{"name": "Mushroom", "icon": MUSHROOM, "price": 9.99},
	{"name": "Apple", "icon": APPLE, "price": 5.99},
	{"name": "Apple IPhone 12 256 GB", "icon": IPHONE, "price": 1299.99},
	{"name": "Onion", "icon": ONION, "price": 4.5},
	{"name": "Chicken", "icon": CHICKEN, "price": 18.9},
	{"name": "Beef", "icon": BEEF, "price": 33.5},
	{"name": "Milk", "icon": MILK, "price": 14.99},
	{"name": "Yogurt", "icon": YOGURT, "price": 6.99},
	{"name": "Shopping Bag", "icon": SHOPPING_BAG, "price": 7.5},
	{"name": "Shampoo", "icon": SHAMPOO, "price": 21.99},
	{"name": "Pen", "icon": PEN, "price": 9.99},
	{"name": "Eraser", "icon": ERASER, "price": 1.5},
	{"name": "Desk Lamp", "icon": DESK_LAMP, "price": 14.99},
	{"name": "Xiaomi Redmi 14c Dual Sim", "icon": XIAOMI, "price": 479.99},
	{"name": "Asus Rog Azoth Extreme Rgb Gaming Keyboard", "icon": KEYBOARD, "price": 2149.99},
	{"name": "Csgo Shanghai Major Pass", "icon": CSGO_PASS, "price": 69.99}
]

func _ready() -> void:
	#shop page setup
	for i in range(30):
		var the_product = product_list.get_child(floor(i / 5)).get_child(i % 5)
		the_product.product_name = shop_product[i]["name"]
		the_product.product_icon = shop_product[i]["icon"]
		the_product.product_price = shop_product[i]["price"]
		the_product.product_setup()
