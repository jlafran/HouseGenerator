extends Control
class_name GenerarCasas

signal boton_comprar

onready var label=$MarginContainer2/MarginContainer/Casas/Label
var material_primario: MaterialPrimario
var material_secundario: MaterialSecundario
var estado:Estado
var total_estado=0.0
var nivel=0
var barrio:Dictionary
var estilo:Estilo
var est_from_barrio:String
var bioma:Bioma
var precio=0
var clase: Clase
var ambi:int
var ambiente:Ambiente
var casa= CasaCompra.new()

func _ready(): 
	generate_estado()
	generate_barrio(nivel)
	if estado.nombre!="Valdio":
		generate_estilo()
		generate_material_primario()
		generate_material_secundario()
		generate_ambiente()
		generate_precio_completo()
		label.text= "Estado: " + estado.nombre + estado.precio as String + "\n" + "Barrio: " + barrio["nombre"] + "\n" + "Clase: " + clase.nombre + clase.aumento as String + "\n" + "Bioma: " + bioma.nombre + bioma.precio as String + "\n"+ "Poblacion: "+ barrio["barrio"].poblacion + "\n" + "Estilo: " + estilo.nombre + estilo.precio as String + "\n" + "Material Primario: " + material_primario.nombre + material_primario.precio as String + "\n" + "Material Secundario: " + material_secundario.nombre + material_secundario.precio as String + "\n" + "Ambientes: " + ambiente.ambiente as String + ambiente.precio as String + "\n" + "Precio: " + precio as String
	else:
		generate_precio()
		label.text= "Estado: " + estado.nombre + estado.precio as String + "\n" + "Barrio: " + barrio["nombre"] + "\n" + "Clase: " + clase.nombre + clase.aumento as String + "\n" + "Bioma: " + bioma.nombre + bioma.precio as String + "\n"+ "Poblacion: "+ barrio["barrio"].poblacion +"\n" + "Precio: " + precio as String

func generate_estado():
	estado=HouseGenerator.get_random_estado()
func generate_barrio(nivel):
	barrio=HouseGenerator.get_random_barrio(nivel)
	bioma=HouseGenerator.get_bioma(barrio["barrio"].bioma)
	clase=HouseGenerator.get_clase(barrio["barrio"].clase)
func generate_estilo():
	est_from_barrio=HouseGenerator.get_estilo_from_random_barrio(barrio)
	estilo=HouseGenerator.get_random_estilo(est_from_barrio,0.02)
func generate_material_primario():
	material_primario=HouseGenerator.get_random_material_primario(estilo,0.3)
func generate_material_secundario():
	material_secundario=HouseGenerator.get_random_material_secundario(estilo,0.3)
func generate_ambiente():
	ambi=HouseGenerator.get_ambiente_from_random_barrio(barrio)
	ambiente=HouseGenerator.get_random_ambiente(ambi,0.2)
func generate_precio_completo():

	if bioma.get_estilos(barrio["barrio"].clase)==estilo.nombre:
		precio= (bioma.precio+estilo.precio) * clase.aumento * 1.1

	else:
		precio= (bioma.precio+estilo.precio) * clase.aumento

	if estilo.material_primario==material_primario.nombre:
		precio += estilo.cantidad_primario * material_primario.precio* 1.3

	if estilo.material_secundario == material_secundario.nombre:
		precio += estilo.cantidad_secundario * material_secundario.precio* 1.5
	if estilo.material_primario!=material_primario.nombre:
		precio += estilo.cantidad_primario * material_primario.precio

	if estilo.material_secundario != material_secundario.nombre:
		precio += estilo.cantidad_secundario * material_secundario.precio
	
	if ambiente.ambiente == ambi:
		precio+=ambiente.precio * 1.3

	if ambiente.ambiente != ambi:
		precio+=ambiente.precio 
func generate_precio():
	precio= (bioma.precio+estado.precio) * clase.aumento


func _on_Comprar_pressed():
	set_new_casa()
	var casa=get_casa()
	var nombre=get_name()
	emit_signal("boton_comprar",casa,nombre)

func set_new_casa():
	casa.set_barrio(barrio["nombre"])
	casa.set_bioma(bioma)
	casa.set_clase(clase)
	casa.set_estado(estado)
	casa.set_estilo(estilo)
	casa.set_material_primario(material_primario)
	casa.set_material_secundario(material_secundario)
	casa.set_precio(precio)

func get_casa():
	return casa
