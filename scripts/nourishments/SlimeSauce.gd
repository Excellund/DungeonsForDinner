extends Nourishment

class_name SlimeSauce

func _init(nourishment_name: String = "Slime Sauce", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)
	
func update_info_box():
	super.update_info_box()
	info_box.description.text = "Description"

func act():
	pass
