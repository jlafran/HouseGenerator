class_name House_Genetator extends Node

var estilos: Array
var materiales_primarios: Array
var materiales_secundarios: Array
var estados:Array
var clases:Array
var ciudades:Array
var biomas:Array
var ambientes:Array
var poblacion:Array

func _ready():
	load_folder("res://Recursos casa/Estilo/",estilos)
	load_folder("res://Recursos casa/Material Primario/", materiales_primarios)
	load_folder("res://Recursos casa/Material Secundario/", materiales_secundarios)
	load_folder("res://Recursos casa/Estado/",estados)
	load_folder("res://Recursos casa/Clase/",clases)
	load_folder("res://Recursos casa/Ciudad/",ciudades)
	load_folder("res://Recursos casa/Biomas/",biomas)
	load_folder("res://Recursos casa/Ambientes/",ambientes)
	load_folder("res://Recursos casa/Poblacion/",poblacion)

func load_folder (folder_path: String, array:Array)-> void:
	var dir=Directory.new()
	dir.open(folder_path)
	dir.list_dir_begin()
	
	filename=dir.get_next()
	while filename:
		if !dir.current_is_dir():
			array.append(load(folder_path+"/%s" % filename))
		filename=dir.get_next()

func acumulado(array:Array):
	var total=0.0
	var arr:Array
	var i =0
	var acumular:Dictionary
	while i!=array.size():
		arr.append(array[i].weight)
		i+=1
	arr.sort()
	i=i-1
	while i!=-1:
		total+=arr[i]
		acumular[arr[i]]=total
		i-=1
	acumular["total"]=total
	acumular["array"]=arr
	return acumular

func get_random_estado():
	var acumular:Dictionary
	acumular=HouseGenerator.acumulado(estados)
	randomize()
	var roll:float = rand_range(0.0, acumular["total"])
	var arr= acumular["array"]
	var largo=estados.size()-1
	var i=0
	while largo!=-1:
		if (acumular[arr[largo]] > roll):
			while estados:
				if arr[largo]==estados[i].weight:
					return estados[i]
				else:
					i+=1
		else:
			largo-=1

func get_random_barrio(nivel:int)->Dictionary:
	var ciudad
	var nombres
	var i=0
	var flag=0
	while ciudades:
		if (ciudades[i].nivel==nivel):
			ciudad=ciudades[i].ciudad
			nombres=ciudades[i].nombre_barrio
			break
		else: i+=1
	var dic: Dictionary
	i=0
	while flag==0:
		flag=0
		randomize()
		var roll: int = rand_range(0, ciudad.size()-1)
		dic ["barrio"] = ciudad[roll]
		dic["nombre"]= nombres[roll]
		if dic["barrio"]!=null:
			flag=1
	return dic

func get_bioma(nombre:String):
	var i=0
	while biomas:
		if biomas[i].nombre== nombre:
			return biomas[i]
		i+=1

func get_clase(nombre:String):
	var i=0
	while clases:
		if clases[i].nombre==nombre:
			return clases[i]
		i+=1

func get_estilo_from_random_barrio(barrio:Dictionary):
	var o=0
	var est:String
	var clase:String
	var bioma:String
	clase= barrio["barrio"].clase
	bioma= barrio["barrio"].bioma
	while biomas:
		if (bioma==biomas[o].nombre):
			est= biomas[o].get_estilos(clase)
			break
		else:
			o+=1
	return est

func get_ambiente_from_random_barrio(barrio:Dictionary):
	var o=0
	var ambiente:int
	ambiente= barrio["barrio"].ambiente
	while ambientes:
		if (ambiente==ambientes[o].ambiente):
			ambiente= ambientes[o].ambiente
			break
		o+=1
	return ambiente

func get_random_estilo(estilo:String,prob:float)->Estilo:
	var acumular:Dictionary
	acumular=HouseGenerator.acumulado(estilos)
	var arr= acumular["array"]
	var largo=estilos.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var est:Estilo
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumular["total"])
		while largo!=-1 && flag3!=0:
			if (acumular[arr[largo]] > roll):
				while estilos:
					flag2=0
					if arr[largo]==estilos[i].weight&& estilo!=estilos[i].nombre:
						est= estilos[i]
						print (est.nombre)
						return est
					if arr[largo]==estilos[i].weight&& estilo==estilos[i].nombre:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							est= estilos[i]
							print (est.nombre)
							return est
						else:
							flag=1
							flag2=1
							flag3=0
							largo=materiales_primarios.size()-1
							break
					i+=1
			largo-=1
	print (est.nombre)
	return est

func get_random_material_primario(estilo:Estilo,prob:float)->MaterialPrimario:
	var acumular:Dictionary
	acumular=HouseGenerator.acumulado(materiales_primarios)
	var arr= acumular["array"]
	var largo=materiales_primarios.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var material_p:MaterialPrimario
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumular["total"])
		while largo!=-1 && flag3!=0:
			if (acumular[arr[largo]] > roll):
				while materiales_primarios:
					flag2=0
					if arr[largo]==materiales_primarios[i].weight&& estilo.material_primario!=materiales_primarios[i].nombre:
						material_p= materiales_primarios[i]
						return material_p
					if arr[largo]==materiales_primarios[i].weight&& estilo.material_primario==materiales_primarios[i].nombre:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							material_p= materiales_primarios[i]
							return material_p
						else:
							flag=1
							flag2=1
							flag3=0
							largo=materiales_primarios.size()-1
							break
					i+=1
			largo-=1
	return material_p

func get_random_material_secundario(estilo:Estilo,prob:float)->MaterialSecundario:
	var acumular:Dictionary
	acumular=HouseGenerator.acumulado(materiales_secundarios)
	var arr= acumular["array"]
	var largo=materiales_secundarios.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var material_s:MaterialSecundario
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumular["total"])
		while largo!=-1 && flag3!=0:
			if (acumular[arr[largo]] > roll):
				while materiales_secundarios:
					flag2=0
					if arr[largo]==materiales_secundarios[i].weight&& estilo.material_secundario!=materiales_secundarios[i].nombre:
						material_s= materiales_secundarios[i]
						return material_s
					if arr[largo]==materiales_secundarios[i].weight&& estilo.material_secundario==materiales_secundarios[i].nombre:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							material_s= materiales_secundarios[i]
							return material_s
						else:
							flag=1
							flag2=1
							flag3=0
							largo=materiales_primarios.size()-1
							break
					i+=1
			largo-=1
	return material_s

func get_random_ambiente(ambiente:int,prob:float)->Ambiente:
	var acumular:Dictionary
	acumular=HouseGenerator.acumulado(ambientes)
	var arr= acumular["array"]
	var largo=ambientes.size()-1
	var i=0
	var flag=1
	var flag2=1
	var flag3=1
	var ambi:Ambiente
	while flag!=0 &&flag2!=0:
		i=0
		flag=0
		flag3=1
		randomize()
		var roll:float = rand_range(0.0, acumular["total"])
		while largo!=-1 && flag3!=0:
			if (acumular[arr[largo]] > roll):
				while ambientes:
					flag2=0
					if arr[largo]==ambientes[i].weight&& ambiente!=ambientes[i].ambiente:
						ambi= ambientes[i]
						return ambi
					if arr[largo]==ambientes[i].weight&& ambiente==ambientes[i].ambiente:
						randomize()
						var roll2:float = rand_range(0.0, 1.0)
						if prob > roll2:
							ambi= ambientes[i]
							return ambi
						else:
							flag=1
							flag2=1
							flag3=0
							largo=ambientes.size()-1
							break
					i+=1
			largo-=1
	return ambi
