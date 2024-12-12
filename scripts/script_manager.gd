extends Node

var cart:Array = []
var total_cost:float = 0

func add_product(product:Dictionary):
	#add product to cart
	var found = false
	if cart.size() < 30:
		for i in range(cart.size()):
			if cart[i]["name"] == product["name"]:
				found = true
				cart[i]["amount"] = cart[i]["amount"] + product["amount"]
				break
		if !found:
			cart.append(product)
	else:
		print("cart is full")
