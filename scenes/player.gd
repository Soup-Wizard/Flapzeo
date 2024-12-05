extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jumpTween
var active = false
var jumping = false
var score = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func gameOver():
	%gameOver.visible = true
	active = false
	Engine.time_scale = 0

func charTween():
	if position.y > 80:
		jumping = true
		velocity.y = 0
		$Sprite2D.rotation = 0
		if jumpTween:
			jumpTween.kill()
		jumpTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		jumpTween.set_parallel(true)
		jumpTween.tween_property(self, "position:y", position.y - 100, 0.2)
		jumpTween.tween_property($Sprite2D, "rotation", deg_to_rad(25), 0.2).as_relative()
		jumpTween.tween_property($Sprite2D, "rotation", deg_to_rad(0), 0.1).as_relative().set_delay(0.1)
		await get_tree().create_timer(0.2).timeout
		jumping = false

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and active:
		charTween()

func _physics_process(delta):
	if !jumping and active:
		velocity.y += gravity * delta
	move_and_slide()
