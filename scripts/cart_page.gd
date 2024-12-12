extends Node2D

@onready var product_list: VBoxContainer = $"Control/ScrollContainer/Product List"
@onready var background: Sprite2D = $Background
@onready var shop_page_button: TextureRect = $"Control/Shop Page Button"
@onready var cart_check_out_button: TextureRect = $"Control/Cart Check Out Button"

var total_cost:float = 0

func _ready() -> void:
	#run setup
	page_setup()

func page_setup() -> void:
	#cart page setup
	total_cost = 0
	#updates size+1 products for product removal purposes, but not exceed 30(max slots)
	for i in range(min(ScriptManager.cart.size() + 1,30)):
		if (i == ScriptManager.cart.size()):
			product_list.get_child(floor(i / 5)).get_child(i % 5).product = {}
		else:
			product_list.get_child(floor(i / 5)).get_child(i % 5).product = ScriptManager.cart[i]
			total_cost += ScriptManager.cart[i]["amount"] * ScriptManager.cart[i]["price"]
		print("product" + str(i) + ":" + str(product_list.get_child(floor(i / 5)).get_child(i % 5).product))
	ScriptManager.total_cost = total_cost
