extends TextureRect

#code for accessing product on the shop page

@export var product_name:String
@export var product_icon:String
@export var product_price:float

var wait_time:float = 0

func _ready() -> void:
	#product setup
	gui_input.connect(_on_input)
	#adjusting the product image
	var img = Image.load_from_file(product_icon)
	img.resize(img.get_width() * 0.5, img.get_height() * 0.5)
	var image := Texture2D.new()
	image = ImageTexture.create_from_image(img)
	image.update(img)
	texture = image

func _process(delta: float) -> void:
	#manually decreasing mouse click interval
	if wait_time > 0:
		wait_time -= delta

func _on_input(event: InputEvent):
	#when product icon is being click
	if event.is_action_pressed("mouse left click"):
		wait_time = 0.2 #only continue proccessing and loading the product page 
						#if mouse clicked and released within 0.2 seconds
	if event.is_action_released("mouse left click") and wait_time > 0:
		var load_product = load("res://resources/product.tres")
		load_product.product_name = product_name
		load_product.product_icon = product_icon
		load_product.product_price = product_price
		ResourceSaver.save(load_product, "res://resources/current_product.tres")
		get_tree().change_scene_to_file("res://scenes/product_page.tscn")
