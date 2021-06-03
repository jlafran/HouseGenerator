class_name MenuBuy extends Control
onready var tabs= get_node("TabContainer") 

#onready var casa1=get_node("TabContainer/Compra/ItemList/GridContainer/Compra")

var house_selected
var name_house
signal menu_destruction
var style_selected
func _ready():
	for i in get_tree().get_nodes_in_group("Houses"):
		i.connect("button_buy",self,"pass_menu")
	for i in get_tree().get_nodes_in_group("Styles"):
		i.connect("style_pressed",self,"get_style_selected")
	tabs.set_current_tab(0)

func pass_menu(house,nam):
	name_house=nam
	house_selected=house
	tabs.set_current_tab(1)
	emit_signal("menu_destruction",house_selected,name_house)
func get_style_selected(style):
	style_selected=style
