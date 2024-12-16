extends Node

var user:Dictionary
var group:Dictionary
var cart:Array = []
var total_cost:float = 0
var delivery_fees:float = 0
var total_member:Array = []

func add_product(product:Dictionary) -> bool:
	#add product to cart
	var found = false
	if cart.size() < 30:
		for i in range(cart.size()):
			if cart[i]["name"] == product["name"] and cart[i]["member"] == product["member"]:
				found = true
				cart[i]["amount"] = cart[i]["amount"] + product["amount"]
				break
		if !found:
			cart.append(product)
		return true
	else:
		return false

func update_cart() -> void:
	var group_list = ResourceLoader.load("user://resources/group.tres", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	ScriptManager.group = group_list.group_list[group_list.find_group(group) - 1]
	ScriptManager.cart = ScriptManager.group["cart"]
