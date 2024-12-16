extends TextureRect

#code for accessing product on the shop page

@export var product_name:String
@export var product_icon:String
@export var product_price:float

var wait_time:float = 0

func _ready() -> void:
	#run setup
	gui_input.connect(_on_input)
	texture = load(product_icon)
	
func product_setup():
	#product setup
	#texture = load(product_icon)
	pass

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
		var dir = DirAccess.open("user://")
		if dir != null:
			dir.make_dir_recursive("user://resources")
		ResourceSaver.save(load_product, "user://resources/current_product.tres")
		print("User " + ScriptManager.user["name"] + " is looking at product: " + load_product.product_name)
		get_tree().change_scene_to_file("res://scenes/product_page.tscn")
