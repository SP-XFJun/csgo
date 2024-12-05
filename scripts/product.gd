extends TextureRect

@export var product_name:String
@export var product_icon:String
@export var product_price:float


func _ready() -> void:
	gui_input.connect(_on_input)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_input(event: InputEvent):
	if event.is_action_released("mouse left click"):
		var load_product = load("res://resources/product.tres")
		load_product.product_name = product_name
		load_product.product_icon = product_icon
		load_product.product_price = product_price
		ResourceSaver.save(load_product, "res://resources/current_product.tres")
		get_tree().change_scene_to_file("res://scenes/product_page.tscn")
