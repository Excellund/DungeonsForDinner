extends TextureRect

class_name Nourishment

@export var info_box: InfoBox

var character: Character
var nourishment_name: String
var is_permanent: bool
var amount: int

func _init(nourishment_name: String, is_permanent: bool, amount: int = 1):
	self.nourishment_name = nourishment_name
	self.is_permanent = is_permanent
	self.amount = amount
	
func _ready():
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	update_info_box()
	
func update_info_box():
	info_box.header.text = nourishment_name

func act():
	pass

func _on_mouse_entered():
	info_box.show()
	
func _on_mouse_exited():
	info_box.hide()
