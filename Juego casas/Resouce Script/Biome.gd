extends Resource
class_name Biome
export var name: String
export var price: int
export var style_low: String
export var style_mid: String
export var style_high: String

func get_styles(pal:String):
	if (pal=="Low"):
		return style_low
	if (pal=="Medium"):
		return style_mid
	if (pal=="High"):
		return style_high
