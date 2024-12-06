extends Node

var cart:Array = []

func add_product(product:Dictionary):
	#add product to cart
	var found = false
	for i in range(cart.size()):
		if cart[i]["name"] == product["name"]:
			found = true
			cart[i]["amount"] = cart[i]["amount"] + product["amount"]
			break
	if !found:
		cart.append(product)

func remove_product(product:Resource):
	#remove product from cart
	if cart.find(product) != -1:
		cart.remove_at(cart.find(product))
