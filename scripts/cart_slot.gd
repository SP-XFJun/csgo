extends TextureRect

@export var slot_index:int

@onready var label: RichTextLabel = $Label
@onready var action: RichTextLabel = $Action

var product:Dictionary = {}

var wait_time:float = 0
var action_wait_time:float = 0

func _ready() -> void:
	#slot setup
	action.visible = false
	gui_input.connect(_on_input)
	action.gui_input.connect(_on_action_input)

func _process(delta: float) -> void:
	#continually updating the product icon
	if !product.is_empty():
		var img = Image.load_from_file(product["icon"])
		img.resize(img.get_width() * 0.5, img.get_height() * 0.5)
		var image := Texture2D.new()
		image = ImageTexture.create_from_image(img)
		image.update(img)
		texture = image
		
		label.text = "[wave amp=10 freq=2]Quantity:" + str(product["amount"])
	else:
		#adjusting the empty slot image
		var img = Image.load_from_file("res://sprites/product/empty_slot.png")
		img.resize(img.get_width() * 0.5, img.get_height() * 0.5)
		var image := Texture2D.new()
		image = ImageTexture.create_from_image(img)
		image.update(img)
		texture = image
		label.text = ""
	#manually decreasing mouse click interval
	if wait_time > 0:
		wait_time -= delta
	if action_wait_time > 0:
		action_wait_time -= delta

func _on_input(event: InputEvent):
	#when product icon is being clicked
	if event.is_action_pressed("mouse left click") and !product.is_empty():
		wait_time = 0.2 #only continue proccessing and display available actions
						#if mouse clicked and released within 0.2 seconds
	if event.is_action_released("mouse left click") and wait_time > 0:
		action.text = "[center][color=red][outline_size=8]Remove"
		if action.visible:
			action.visible = false
		else:
			action.visible = true

func _on_action_input(event: InputEvent):
	#when action label is being clicked
	if event.is_action_pressed("mouse left click"):
		action_wait_time = 0.2	#only continue proccessing the action
								#if mouse clicked and released within 0.2 seconds
	if event.is_action_released("mouse left click") and action_wait_time > 0:
		#clearing the slot and its relevant data from other nodes
		action.visible = false
		ScriptManager.cart.remove_at(slot_index)
		product.clear()
		get_tree().get_first_node_in_group("Cart Page").page_setup()
		print("script_cart: " + str(ScriptManager.cart))
