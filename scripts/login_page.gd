extends Node2D

@onready var login_button: Button = $"Control/VBoxContainer/VBoxContainer/VBoxContainer3/HBoxContainer/Login Button"
@onready var register_button: Button = $"Control/VBoxContainer/VBoxContainer/VBoxContainer3/HBoxContainer/Register Button"
@onready var username: LineEdit = $Control/VBoxContainer/VBoxContainer/VBoxContainer3/Username
@onready var password: LineEdit = $Control/VBoxContainer/VBoxContainer/VBoxContainer3/Password

func _ready() -> void:
	#login page setup
	login_button.pressed.connect(_login)
	register_button.pressed.connect(_register)
	#user database setup
	var dir = DirAccess.open("user://")
	if dir != null:
		dir.make_dir_recursive("resources")
	var user_list = load("user://resources/user.tres")
	if !user_list:
		ResourceSaver.save(load("res://resources/user_database.tres"), "user://resources/user.tres")

func _login():
	#when login button is clicked
	if username.text == "" or password.text == "":
		return
	var user_list = load("user://resources/user.tres")
	var user = {}
	user["name"] = username.text
	user["password"] = password.text
	if user_list.find_user(user):
		ScriptManager.user = user
		get_tree().change_scene_to_file("res://scenes/shop_page.tscn")

func _register():
	#when register button is clicked
	if username.text == "" or password.text == "":
		return
	var user_list = load("user://resources/user.tres")
	var new_user = {}
	new_user["name"] = username.text
	new_user["password"] = password.text
	if user_list.add_user(new_user):
		ResourceSaver.save(user_list, "user://resources/user.tres")
		#remove username and password from text
		username.text = ""
		password.text = ""
