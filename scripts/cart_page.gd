extends Node2D

@onready var product_list: VBoxContainer = $"Control/ScrollContainer/Product List"

@export var product_name:String
@export var product_icon:String
@export var product_price:float

func _ready() -> void:
	#cart page setup
	for i in range(ScriptManager.cart.size()):
		product_list.get_child(floor(i / 5)).get_child(i % 5).product = ScriptManager.cart[i]

func _process(delta: float) -> void:
	pass

func _on_input(event: InputEvent):
	#when product icon is being click, will be worked on
	pass
