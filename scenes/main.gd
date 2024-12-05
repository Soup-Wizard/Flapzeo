extends Node2D

var wall = preload("res://scenes/walls.tscn")

var labelText = "Score: {0}"

func createWall():
	var newWall = wall.instantiate()
	$wallZone.add_child(newWall)
	newWall.global_position.x = get_viewport().size.x
	newWall.global_position.y = randi_range(150, get_viewport().size.y - 300)

func startGame():
	for i in $wallZone.get_children():
		i.queue_free()
	%gameOver.visible = false
	%player.velocity.y = 0
	%player.global_position = $spawn.global_position
	%player.active = true
	%player.visible = true
	%player.score = 0
	%startLabel.visible = false
	%scoreLabel.text = labelText.format([%player.score])
	%scoreLabel.visible = true
	createWall()
	$Timer.start()
	Engine.time_scale = 1

func _input(event):
	if Input.is_action_just_pressed("jump") and !%player.active:
		startGame()

func _ready():
	Engine.time_scale = 0

func _process(delta):
	%scoreLabel.text = labelText.format([%player.score])

func _on_timer_timeout():
	createWall()

func _on_drop_dead_body_entered(body):
	if body.name == "player":
		%gameOver.visible = true
		body.gameOver()
