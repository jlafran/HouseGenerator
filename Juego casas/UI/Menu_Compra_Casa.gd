class_name MenuCompra extends Control
onready var tabs= get_node("TabContainer") 

#onready var casa1=get_node("TabContainer/Compra/ItemList/GridContainer/Compra")

var casa_selec
var nombre_casa
signal menu_destruccion
var estilo_selected
func _ready():
	for i in get_tree().get_nodes_in_group("Casas"):
		i.connect("boton_comprar",self,"pasar_menu")
	for i in get_tree().get_nodes_in_group("Estilos"):
		i.connect("estilo_pressed",self,"get_estilo_selected")
	tabs.set_current_tab(0)

func pasar_menu(casa,nombre):
	nombre_casa=nombre
	casa_selec=casa
	tabs.set_current_tab(1)
	emit_signal("menu_destruccion",casa_selec,nombre_casa)
func get_estilo_selected(estilo):
	estilo_selected=estilo
