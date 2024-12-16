extends Node2D

@onready var total_price: RichTextLabel = $"Control/VBoxContainer/HBoxContainer/VBoxContainer/Total Price"
@onready var delivery_fee: RichTextLabel = $"Control/VBoxContainer/Delivery Fee"

@onready var background: Sprite2D = $Background
@onready var check_out_button: Button = $"Control/VBoxContainer/HBoxContainer2/VBoxContainer/Check Out Button"
@onready var ready_count: RichTextLabel = $"Control/VBoxContainer/HBoxContainer2/VBoxContainer/Ready Count"
@onready var total_cost: RichTextLabel = $"Control/VBoxContainer/HBoxContainer2/Total Cost"
@onready var return_button: Button = $"Control/VBoxContainer/HBoxContainer2/Return Button"

var popup_scene = preload("res://scenes/popup.tscn")

var able_check_out = true

func _ready() -> void:
	#check out page setup
	check_out_button.pressed.connect(_check_out)
	return_button.pressed.connect(_returned)
	total_price.text = "$" + str(ScriptManager.total_cost)
	ScriptManager.update_cart()
	#user will not pay for delivery fees if they did not buy anything
	if ScriptManager.total_cost == 0:
		total_cost.text = "[wave amp=20 freq=2][outline_size=10] $0"
		able_check_out = false
		_stylebox(Color(0.4,0.4,0.4,1))
	if ScriptManager.group["ready"].has(ScriptManager.user["name"]):
		_stylebox(Color(0.4,0.4,0.4,1))
		

func _process(delta: float) -> void:
	ready_count.text = "[center][outline_size=8]" + str(ScriptManager.group["ready"].size()) + " / " + str(ScriptManager.total_member.size())
	if able_check_out:
		total_cost.text = "[wave amp=20 freq=2][outline_size=10] $" + str(ScriptManager.total_cost + ScriptManager.delivery_fees)
		delivery_fee.text = "Delivery fees: $" + str(ScriptManager.delivery_fees)

func _check_out():
	#when user is ready to check out
	if able_check_out:
		var group_list = ResourceLoader.load("user://resources/group.tres", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP)
		ScriptManager.update_cart()
		if !ScriptManager.group["ready"].has(ScriptManager.user["name"]):
			ScriptManager.group["ready"].append(ScriptManager.user["name"])
			_stylebox(Color(0.4,0.4,0.4,1))
			print("User " + ScriptManager.user["name"] + " is ready to checkout")
		else:
			ScriptManager.group["ready"].remove_at(ScriptManager.group["ready"].find(ScriptManager.user["name"]))
			_stylebox(Color(0.3,0.6,0.3,1))
			print("User " + ScriptManager.user["name"] + " is not ready to checkout")
		group_list.update_member(ScriptManager.group,ScriptManager.group["ready"])
		if ScriptManager.group["ready"].size() == ScriptManager.total_member.size():
			ScriptManager.group["ready"].clear()
			for i in range(group_list.group_list.size()):
				if group_list.group_list[i]["name"] == ScriptManager.group["name"]:
					group_list.group_list[i]["cart"] = []
					group_list.group_list[i]["ready"] = []
					able_check_out = false
					total_cost.text = "[wave amp=20 freq=2][outline_size=10] $0"
					delivery_fee.text = "Delivery fees: $0"
					ResourceSaver.save(group_list, "user://resources/group.tres")
					get_tree().current_scene.cart_reset()
					var popup = popup_scene.instantiate()
					popup.message = "The cart has checked out!\nAll payments received"
					get_tree().current_scene.add_child(popup)
					print("Check out is complete!")
					return
			print("Check out failed")

func _returned():
	#when return button is clicked
	queue_free()

func _stylebox(color: Color):
	#stylebox for the check out button
	var new_stylebox = StyleBoxTexture.new()
	new_stylebox.texture = CanvasTexture.new()
	new_stylebox.texture_margin_bottom = 5
	new_stylebox.texture_margin_left = 5
	new_stylebox.texture_margin_right = 5
	new_stylebox.texture_margin_top = 5
	new_stylebox.set_modulate(color)
	check_out_button.add_theme_stylebox_override("normal", new_stylebox)
	check_out_button.add_theme_stylebox_override("focus", new_stylebox)
	check_out_button.add_theme_stylebox_override("hover_pressed", new_stylebox)
	check_out_button.add_theme_stylebox_override("hover", new_stylebox)
	check_out_button.add_theme_stylebox_override("pressed", new_stylebox)
