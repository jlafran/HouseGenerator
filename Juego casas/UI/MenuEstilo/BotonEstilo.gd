extends Button
signal estilo_pressed
onready var texto= get_text()

func _on_Estilo_pressed():
	var estilo=LoadAssets.get_estilo(texto)
	emit_signal("estilo_pressed",estilo)
