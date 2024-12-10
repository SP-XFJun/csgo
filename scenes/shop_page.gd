extends Node2D

func _ready() -> void:
	#adjusting the cart button image
	var img = Image.load_from_file("res://sprites/cart button.jpg")
	img.resize(img.get_width() * 0.1, img.get_height() * 0.1)
	var image := Texture2D.new()
	image = ImageTexture.create_from_image(img)
	image.update(img)
	$"Control/Cart Page Button".texture = image
	
	#adjusting the background image
	var img2 = Image.load_from_file("res://sprites/white background.jpg")
	img2.resize(img2.get_width() * 1.5, img2.get_height() * 1.5)
	var image2 := Texture2D.new()
	image2 = ImageTexture.create_from_image(img2)
	image2.update(img2)
	$Sprite2D.texture = image2
