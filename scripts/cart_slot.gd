extends TextureRect

@onready var label: RichTextLabel = $Label

var product:Dictionary = {}

func _ready() -> void:
	pass

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
