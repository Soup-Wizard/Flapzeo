extends Node2D

var moveTween
var scored = false

# Called when the node enters the scene tree for the first time.
func _ready():
	moveTween = get_tree().create_tween()
	moveTween.set_parallel(true)
	for i in get_children():
		moveTween.tween_property(i, "global_position:x", -100, 7)
	await get_tree().create_timer(10).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if position.x <= -10:
		#print("WALL REMOVED")
		#queue_free()

# NOTE Score Area
func _on_area_2d_body_entered(body):
	if body.name == "player" and !scored:
		body.score += 1
		scored = true

func _on_top_body_entered(body):
	if body.name == "player":
		body.gameOver()

func _on_bottom_body_entered(body):
	if body.name == "player":
		body.gameOver()
