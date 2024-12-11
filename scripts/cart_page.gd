extends Node2D

@onready var product_list: VBoxContainer = $"Control/ScrollContainer/Product List"
@onready var background: Sprite2D = $Background
@onready var shop_page_button: TextureRect = $"Control/Shop Page Button"
@onready var cart_check_out_button: TextureRect = $"Control/Cart Check Out Button"

@export var product_name:String
@export var product_icon:String
@export var product_price:float

var total_cost:float = 0

func _ready() -> void:
	#run setup
	page_setup()

	#adjusting the background image
	var img3 = Image.load_from_file("res://sprites/white background.jpg")
	img3.resize(img3.get_width() * 1.5, img3.get_height() * 1.5)
	var image3 := Texture2D.new()
	image3 = ImageTexture.create_from_image(img3)
	image3.update(img3)
	background.texture = image3

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
