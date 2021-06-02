class_name Load_Assets extends Node

var estilos: Array
var materiales_primarios: Array
var materiales_secundarios: Array
var estados:Array
var clases:Array
var ciudades:Array
var biomas:Array
var ambientes:Array
var poblaciones:Array

func _ready():
	load_folder("res://Recursos casa/Estilo/",estilos)
	load_folder("res://Recursos casa/Material Primario/", materiales_primarios)
	load_folder("res://Recursos casa/Material Secundario/", materiales_secundarios)
	load_folder("res://Recursos casa/Estado/",estados)
	load_folder("res://Recursos casa/Clase/",clases)
	load_folder("res://Recursos casa/Ciudad/",ciudades)
	load_folder("res://Recursos casa/Biomas/",biomas)
	load_folder("res://Recursos casa/Ambientes/",ambientes)
	load_folder("res://Recursos casa/Poblacion/",poblaciones)

func load_folder (folder_path: String, array:Array)-> void:
	var dir=Directory.new()
	dir.open(folder_path)
	dir.list_dir_begin()
	
	filename=dir.get_next()
	while filename:
		if !dir.current_is_dir():
			array.append(load(folder_path+"/%s" % filename))
		filename=dir.get_next()

func get_estilos():
	return estilos
func get_materiales_primarios():
	return materiales_primarios
func get_materiales_secundarios():
	return materiales_secundarios
func get_estados():
	return estados
func get_clases():
	return clases
func get_ciudades():
	return ciudades
func get_biomas():
	return biomas
func get_ambientes():
	return ambientes
func get_poblaciones():
	return poblaciones

func get_estilo(valor):
	for i in estilos:
		if valor==i.nombre:
			return i
func get_materiale_primario(valor):
	for i in materiales_primarios:
		if valor==i.nombre:
			return i
func get_materiale_secundario(valor):
	for i in materiales_secundarios:
		if valor==i.nombre:
			return i
func get_estado(valor):
	for i in estados:
		if valor==i.nombre:
			return i
func get_clase(valor):
	for i in clases:
		if valor==i.nombre:
			return i
func get_ciudad(valor):
	for i in ciudades:
		if valor==i.nivel:
			return i
func get_bioma(valor):
	for i in biomas:
		if valor==i.nombre:
			return i
func get_ambiente(valor):
	for i in ambientes:
		if valor==i.nombre:
			return i
func get_poblacion(valor):
	for i in poblaciones:
		if valor==i.nombre:
			return i
