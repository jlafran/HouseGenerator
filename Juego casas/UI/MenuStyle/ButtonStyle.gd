extends Button
signal style_pressed
onready var texto= get_text()

func _on_Style_pressed():
	var style=LoadAssets.get_style(texto)
	emit_signal("style_pressed",style)
