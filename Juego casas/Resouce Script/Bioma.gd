extends Resource
class_name Bioma
export var nombre: String
export var precio: int
export var estilo_baja: String
export var estilo_media: String
export var estilo_alta: String

func get_estilos(pal:String):
	if (pal=="Baja"):
		return estilo_baja
	if (pal=="Media"):
		return estilo_media
	if (pal=="Alta"):
		return estilo_alta
