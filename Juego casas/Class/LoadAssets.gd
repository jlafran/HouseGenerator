class_name Load_Assets extends Node

var styles: Array
var primary_materials: Array
var secondary_materials: Array
var statuses:Array
var clases:Array
var cities:Array
var biomes:Array
var rooms:Array

func _ready():
	load_folder("res://Resources House/Style/",styles)
	load_folder("res://Resources House/Primary Material/", primary_materials)
	load_folder("res://Resources House/Secondary Material/", secondary_materials)
	load_folder("res://Resources House/Status/",statuses)
	load_folder("res://Resources House/Clas/",clases)
	load_folder("res://Resources House/City/",cities)
	load_folder("res://Resources House/Biomes/",biomes)
	load_folder("res://Recursos casa/rooms/",rooms)


func load_folder (folder_path: String, array:Array)-> void:
	var dir=Directory.new()
	dir.open(folder_path)
	dir.list_dir_begin()
	
	filename=dir.get_next()
	while filename:
		if !dir.current_is_dir():
			array.append(load(folder_path+"/%s" % filename))
		filename=dir.get_next()

func get_styles():
	return styles
func get_primary_materials():
	return primary_materials
func get_secondary_materials():
	return secondary_materials
func get_statuseses():
	return statuses
func get_clasesses():
	return clases
func get_cities():
	return cities
func get_biomes():
	return biomes
func get_rooms():
	return rooms

func get_style(val):
	for i in styles:
		if val==i.name:
			return i
func get_primary_material(val):
	for i in primary_materials:
		if val==i.name:
			return i
func get_secondary_material(val):
	for i in secondary_materials:
		if val==i.name:
			return i
func get_status(val):
	for i in statuses:
		if val==i.name:
			return i
func get_clas(val):
	for i in clases:
		if val==i.name:
			return i
func get_city(val):
	for i in cities:
		if val==i.nivel:
			return i
func get_biome(val):
	for i in biomes:
		if val==i.name:
			return i
func get_room(val):
	for i in rooms:
		if val==i.name:
			return i
