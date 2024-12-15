extends Resource
class_name GroupDatabase

@export var group_list:Array

func add_group(group:Dictionary) -> bool:
	for i in range(group_list.size()):
		if group_list[i]["name"] == group["name"]:
			return false
	group_list.append(group)
	ResourceSaver.save(self, "user://resources/group.tres")
	return true

func find_group(group:Dictionary) -> int:
	for i in range(group_list.size()):
		if group_list[i]["name"] == group["name"]:
			if group_list[i]["code"] == group["code"]:
				return (i + 1)
			else:
				return 0
	return 0

func update_cart(group:Dictionary,cart:Array) -> void:
	for i in range(group_list.size()):
		if group_list[i]["name"] == group["name"]:
			group_list[i]["cart"] = cart
			ResourceSaver.save(self, "user://resources/group.tres")
			return

func update_member(group:Dictionary,member:Array) -> void:
	for i in range(group_list.size()):
		if group_list[i]["name"] == group["name"]:
			group_list[i]["ready"] = member
			ResourceSaver.save(self, "user://resources/group.tres")
			return
