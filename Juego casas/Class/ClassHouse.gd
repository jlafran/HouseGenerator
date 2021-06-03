class_name House_Genetator extends Node

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
	load_folder("res://Resources House/Rooms/",rooms)

func load_folder (folder_path: String, array:Array)-> void:
	var dir=Directory.new()
	dir.open(folder_path)
	dir.list_dir_begin()
	
	filename=dir.get_next()
	while filename:
		if !dir.current_is_dir():
			array.append(load(folder_path+"/%s" % filename))
		filename=dir.get_next()

func acumulate(array:Array):
	var total=0.0
	var arr:Array
	var i =0
	var acumula:Dictionary
	while i!=array.size():
		arr.append(array[i].weight)
		i+=1
	arr.sort()
	i=i-1
	while i!=-1:
		total+=arr[i]
		acumula[arr[i]]=total
		i-=1
	acumula["total"]=total
	acumula["array"]=arr
	return acumula

func get_random_status():
	var acumula:Dictionary
	acumula=HouseGenerator.acumulate(statuses)
	randomize()
	var roll:float = rand_range(0.0, acumula["total"])
	var arr= acumula["array"]
	var largo=statuses.size()-1
	var i=0
	while largo!=-1:
		if (acumula[arr[largo]] > roll):
			while statuses:
				if arr[largo]==statuses[i].weight:
					return statuses[i]
				else:
					i+=1
		else:
			largo-=1

func get_random_neighborhood(level:int)->Dictionary:
	var city
	var names
	var i=0
	var flag=0
	while cities:
		if (cities[i].level==level):
			city=cities[i].city
			names=cities[i].neighborhood_name
			break
		else: i+=1
	var dic: Dictionary
	i=0
	while flag==0:
		flag=0
		randomize()
		var roll: int = rand_range(0, city.size()-1)
		dic ["neighborhood"] = city[roll]
		dic["name"]= names[roll]
		if dic["neighborhood"]!=null:
			flag=1
	return dic

func get_biome(name:String):
	var i=0
	while biomes:
		if biomes[i].name== name:
			return biomes[i]
		i+=1

func get_clas(name:String):
	var i=0
	while clases:
		if clases[i].name==name:
			return clases[i]
		i+=1

func get_style_from_random_neighborhood(neighborhood:Dictionary):
	var o=0
	var est:String
	var clas:String
	var biome:String
	clas= neighborhood["neighborhood"].clas
	biome= neighborhood["neighborhood"].biome
	while biomes:
		if (biome==biomes[o].name):
			est= biomes[o].get_styles(clas)
			break
		else:
			o+=1
	return est

func get_room_from_random_neighborhood(neighborhood:Dictionary):
	var o=0
	var room:int
	room= neighborhood["neighborhood"].room
	while rooms:
		if (room==rooms[o].room):
			room= rooms[o].room
			break
		o+=1
	return room

func get_random_style(style:String,prob:float)->Style:
	var acumula:Dictionary
	acumula=HouseGenerator.acumulate(styles)
	var arr= acumula["array"]
	var largo=styles.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var est:Style
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumula["total"])
		while largo!=-1 && flag3!=0:
			if (acumula[arr[largo]] > roll):
				while styles:
					flag2=0
					if arr[largo]==styles[i].weight&& style!=styles[i].name:
						est= styles[i]
						print (est.name)
						return est
					if arr[largo]==styles[i].weight&& style==styles[i].name:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							est= styles[i]
							print (est.name)
							return est
						else:
							flag=1
							flag2=1
							flag3=0
							largo=primary_materials.size()-1
							break
					i+=1
			largo-=1
	print (est.name)
	return est

func get_random_primary_material(style:Style,prob:float)->PrimaryMaterial:
	var acumula:Dictionary
	acumula=HouseGenerator.acumulate(primary_materials)
	var arr= acumula["array"]
	var largo=primary_materials.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var material_p:PrimaryMaterial
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumula["total"])
		while largo!=-1 && flag3!=0:
			if (acumula[arr[largo]] > roll):
				while primary_materials:
					flag2=0
					if arr[largo]==primary_materials[i].weight&& style.primary_material!=primary_materials[i].name:
						material_p= primary_materials[i]
						return material_p
					if arr[largo]==primary_materials[i].weight&& style.primary_material==primary_materials[i].name:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							material_p= primary_materials[i]
							return material_p
						else:
							flag=1
							flag2=1
							flag3=0
							largo=primary_materials.size()-1
							break
					i+=1
			largo-=1
	return material_p

func get_random_secondary_material(style:Style,prob:float)->SecondaryMaterial:
	var acumula:Dictionary
	acumula=HouseGenerator.acumulate(secondary_materials)
	var arr= acumula["array"]
	var largo=secondary_materials.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var material_s:SecondaryMaterial
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumula["total"])
		while largo!=-1 && flag3!=0:
			if (acumula[arr[largo]] > roll):
				while secondary_materials:
					flag2=0
					if arr[largo]==secondary_materials[i].weight&& style.secondary_material!=secondary_materials[i].name:
						material_s= secondary_materials[i]
						return material_s
					if arr[largo]==secondary_materials[i].weight&& style.secondary_material==secondary_materials[i].name:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							material_s= secondary_materials[i]
							return material_s
						else:
							flag=1
							flag2=1
							flag3=0
							largo=primary_materials.size()-1
							break
					i+=1
			largo-=1
	return material_s

func get_random_room(room:int,prob:float)->Room:
	var acumula:Dictionary
	acumula=HouseGenerator.acumulate(rooms)
	var arr= acumula["array"]
	var largo=rooms.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var ambi:Room
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumula["total"])
		while largo!=-1 && flag3!=0:
			if (acumula[arr[largo]] > roll):
				while rooms:
					flag2=0
					if arr[largo]==rooms[i].weight&& room!=rooms[i].room:
						ambi= rooms[i]
						return ambi
					if arr[largo]==rooms[i].weight&& room==rooms[i].room:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							ambi= rooms[i]
							return ambi
						else:
							flag=1
							flag2=1
							flag3=0
							largo=rooms.size()-1
							break
					i+=1
			largo-=1
	return ambi
