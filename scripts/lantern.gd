extends PointLight2D

const INITIAL_ENERGY = 1.2
const TARGET_ENERGY = 0.5
const TWEEN_DURATION = 2.0

func _ready():
	energy = INITIAL_ENERGY
	start_breathing_effect()

func start_breathing_effect():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(self, "energy", TARGET_ENERGY, TWEEN_DURATION).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "energy", INITIAL_ENERGY, TWEEN_DURATION).set_trans(Tween.TRANS_SINE)
	tween.play()
