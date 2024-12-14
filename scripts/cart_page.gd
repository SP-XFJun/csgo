extends Node2D

@onready var product_list: VBoxContainer = $"Control/ScrollContainer/Product List"
@onready var background: Sprite2D = $Background
@onready var shop_page_button: TextureRect = $"Control/Shop Page Button"
@onready var cart_check_out_button: TextureRect = $"Control/Cart Check Out Button"

var total_cost:float = 0

func _ready() -> void:
	#run setup
	ScriptManager.update_cart()
	page_setup()

func _process(delta: float) -> void:
	var group_list = ResourceLoader.load("user://resources/group.tres", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	if group_list:
		if ScriptManager.cart != group_list.group_list[group_list.find_group(ScriptManager.group) - 1]["cart"]:
			ScriptManager.update_cart()
			page_setup()
	#performance booster
	await get_tree().create_timer(0.5).timeout

func page_setup() -> void:
	#cart page setup
	total_cost = 0
	#updates size+1 products for product removal purposes, but not exceed 30(max slots)
	for i in range(min(ScriptManager.cart.size() + 1,30)):
		if (i == ScriptManager.cart.size()):
			product_list.get_child(floor(i / 5)).get_child(i % 5).product = {}
			product_list.get_child(floor(i / 5)).get_child(i % 5).action.visible = false
		else:
			product_list.get_child(floor(i / 5)).get_child(i % 5).product = ScriptManager.cart[i]
			product_list.get_child(floor(i / 5)).get_child(i % 5).action.visible = false
			if ScriptManager.cart[i]["member"] == ScriptManager.user["name"]:
				total_cost += ScriptManager.cart[i]["amount"] * ScriptManager.cart[i]["price"]
	ScriptManager.total_cost = total_cost
