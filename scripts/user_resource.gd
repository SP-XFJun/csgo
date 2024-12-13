extends Resource
class_name UserDatabase

@export var user_list:Array

func add_user(user:Dictionary) -> bool:
	for i in range(user_list.size()):
		if user_list[i]["name"] == user["name"]:
			return false
	user_list.append(user)
	return true

func find_user(user:Dictionary) -> bool:
	#look for user in user_list
	for i in range(user_list.size()):
		if user_list[i]["name"] == user["name"]:
			if user_list[i]["password"] == user["password"]:
				return true
			else:
				return false
	return false
