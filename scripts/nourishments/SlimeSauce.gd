extends Nourishment

class_name SlimeSauce

func _init(nourishment_name: String = "Slime Sauce", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)
	SignalBus.update_info_box_description.emit(self.info_box, "Description")

func act():
	pass
