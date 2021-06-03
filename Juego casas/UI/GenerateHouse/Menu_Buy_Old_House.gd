extends Control
class_name GenerateHouse

signal button_buy

onready var label=$MarginContainer2/MarginContainer/Houses/Label
var primary_material: PrimaryMaterial
var secondary_material: SecondaryMaterial
var status:Status
var total_status=0.0
var level=0
var neighborhood:Dictionary
var style:Style
var est_from_neighborhood:String
var biome:Biome
var price=0
var clas: Clas
var ambi:int
var room:Room
var house= HouseBuy.new()

func _ready(): 
	generate_status()
	generate_neighborhood(level)
	if status.name!="Empty":
		generate_style()
		generate_primary_material()
		generate_secondary_material()
		generate_room()
		generate_price_completo()
		label.text= "status: " + status.name + status.price as String + "\n" + "neighborhood: " + neighborhood["name"] + "\n" + "Clas: " + clas.name + clas.growth as String + "\n" + "Biome: " + biome.name + biome.price as String + "\n"+ "Poblacion: "+ neighborhood["neighborhood"].population + "\n" + "Style: " + style.name + style.price as String + "\n" + "Material Primario: " + primary_material.name + primary_material.price as String + "\n" + "Material Secundario: " + secondary_material.name + secondary_material.price as String + "\n" + "Rooms: " + room.room as String + room.price as String + "\n" + "Precio: " + price as String
	else:
		generate_price()
		label.text= "status: " + status.name + status.price as String + "\n" + "neighborhood: " + neighborhood["name"] + "\n" + "Clas: " + clas.name + clas.growth as String + "\n" + "Biome: " + biome.name + biome.price as String + "\n"+ "Poblacion: "+ neighborhood["neighborhood"].population +"\n" + "Precio: " + price as String

func generate_status():
	status=HouseGenerator.get_random_status()
func generate_neighborhood(level):
	neighborhood=HouseGenerator.get_random_neighborhood(level)
	biome=HouseGenerator.get_biome(neighborhood["neighborhood"].biome)
	clas=HouseGenerator.get_clas(neighborhood["neighborhood"].clas)
func generate_style():
	est_from_neighborhood=HouseGenerator.get_style_from_random_neighborhood(neighborhood)
	style=HouseGenerator.get_random_style(est_from_neighborhood,0.02)
func generate_primary_material():
	primary_material=HouseGenerator.get_random_primary_material(style,0.3)
func generate_secondary_material():
	secondary_material=HouseGenerator.get_random_secondary_material(style,0.3)
func generate_room():
	ambi=HouseGenerator.get_room_from_random_neighborhood(neighborhood)
	room=HouseGenerator.get_random_room(ambi,0.2)
func generate_price_completo():

	if biome.get_styles(neighborhood["neighborhood"].clas)==style.name:
		price= (biome.price+style.price) * clas.growth * 1.1

	else:
		price= (biome.price+style.price) * clas.growth

	if style.primary_material==primary_material.name:
		price += style.quantity_primary * primary_material.price* 1.3

	if style.secondary_material == secondary_material.name:
		price += style.quantity_secondary * secondary_material.price* 1.5
	if style.primary_material!=primary_material.name:
		price += style.quantity_primary * primary_material.price

	if style.secondary_material != secondary_material.name:
		price += style.quantity_secondary * secondary_material.price
	
	if room.room == ambi:
		price+=room.price * 1.3

	if room.room != ambi:
		price+=room.price 
func generate_price():
	price= (biome.price+status.price) * clas.growth


func _on_Buy_pressed():
	set_new_house()
	var house=get_house()
	var nam=get_name()
	emit_signal("button_buy",house,nam)

func set_new_house():
	house.set_neighborhood(neighborhood["name"])
	house.set_biome(biome)
	house.set_clas(clas)
	house.set_status(status)
	house.set_style(style)
	house.set_primary_material(primary_material)
	house.set_secondary_material(secondary_material)
	house.set_price(price)

func get_house():
	return house
