extends SubViewport


@export var textureA: Texture
@export var textureB: Texture
@export var sprite: Sprite2D
@export var card_name: Label
@export var card_text: RichTextLabel
@export var cost: Label

var view_texture: ViewportTexture


func _ready():
	view_texture = self.get_texture()
	
func get_flattened_sprite(data:CardData, is_attack_side):
	card_name.text = data.card_name
	if is_attack_side:
		sprite.texture = textureA
		card_text.text = data.attack_text
		cost.text = str(data.cost)
	else:
		sprite.texture = textureB
		card_text.text = data.eat_text
		cost.text = str(data.healing_on_eat)
	self.render_target_update_mode = SubViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw
	var return_img = view_texture.get_image()
	return return_img
	
