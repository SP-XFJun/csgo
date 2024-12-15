extends Node2D

@onready var join_button: Button = $"Control/VBoxContainer/VBoxContainer/VBoxContainer3/HBoxContainer/Join Button"
@onready var create_button: Button = $"Control/VBoxContainer/VBoxContainer/VBoxContainer3/HBoxContainer/Create Button"
@onready var back_button: Button = $"Control/Back Button"
@onready var warning: RichTextLabel = $Control/VBoxContainer/VBoxContainer/VBoxContainer3/Warning
@onready var group_name: LineEdit = $Control/VBoxContainer/VBoxContainer/VBoxContainer3/Group
@onready var group_code: LineEdit = $Control/VBoxContainer/VBoxContainer/VBoxContainer3/Code

func _ready() -> void:
	#group page setup
	join_button.pressed.connect(_join)
	create_button.pressed.connect(_create)
	back_button.pressed.connect(_back)
	warning.text = ""
	#group database setup
	var dir = DirAccess.open("user://")
	if dir != null:
		dir.make_dir_recursive("resources")
	var group_list = load("user://resources/group.tres")
	if !group_list:
		ResourceSaver.save(load("res://resources/group_database.tres"), "user://resources/group.tres")

func _join():
	#when join button is clicked
	if group_name.text == "" or group_code.text == "":
		warning.text = "[center]Group name and group code can't be blank."
		return
	var group_list = ResourceLoader.load("user://resources/group.tres", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	group_list.take_over_path("user://resources/group.tres")
	var group = {}
	group["name"] = group_name.text
	group["code"] = group_code.text
	if group_list.find_group(group):
		ScriptManager.group = group_list.group_list[group_list.find_group(group) - 1]
		ScriptManager.cart = ScriptManager.group["cart"]
		print("User " + ScriptManager.user["name"] + " joined the group: " + group["name"])
		get_tree().change_scene_to_file("res://scenes/shop_page.tscn")
	else:
		print("User " + ScriptManager.user["name"] + " failed to join the group: " + group["name"])
		warning.text = "[center]The group name or group code is incorrect."

func _create():
	#when create button is clicked
	if group_name.text == "" or group_code.text == "":
		warning.text = "[center]Group name and group code can't be blank."
		return
	var group_list = ResourceLoader.load("user://resources/group.tres", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	var new_group = {}
	new_group["name"] = group_name.text
	new_group["code"] = group_code.text
	new_group["cart"] = []
	new_group["ready"] = []
	if group_list.add_group(new_group):
		print("User " + ScriptManager.user["name"] + " created group: " + new_group["name"])
		group_name.text = ""
		group_code.text = ""
	else:
		print("User " + ScriptManager.user["name"] + " failed to created group with " + new_group["name"] + " as the name")
		warning.text = "[center]This group name has been taken."

func _back():
	print("User " + ScriptManager.user["name"] + " logged out")
	get_tree().change_scene_to_file("res://scenes/login_page.tscn")
