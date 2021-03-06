extends KinematicBody2D

var motion = Vector2()

var Health = 100
var PlayerInfected = false

var DarkerHeart = preload("res://Art/Darker Heart.png")
onready var menu = get_parent().get_node("CanvasLayer3/ParentSprite/Control")

var bullet = preload("res://Art/Bullet.png")
var explosion = load("res://Particles.tscn").instance()
onready var Player = get_parent().get_node("Player")
onready var InfectText = get_parent().get_node("CanvasLayer/MarginContainer/Control/NeedTreatment")
var bulletSpeed = 1000

func _process(delta):

	
	if Health <= 0:
		queue_free()


func _physics_process(delta):
	var world = get_parent()
	var Player = world.get_node("Player")


	if visible == true and Player.PlayerIsDead == false and menu.ClickedPlay == true:
		
		position += (Player.position - position)/20
		
	move_and_collide(motion)
	


func _on_Area2D_body_entered(body):
	var world = get_parent()
	var infectedScreen = world.get_node("CanvasLayer2/InfectedScreen")
	if body.name == "Player" or body.name == "PlayerCollider" or body.name == "PlayerArena":	
		world.Heart1.texture = DarkerHeart
		world.Heart2.texture = DarkerHeart
		world.Heart3.texture = DarkerHeart
		world.PlayerInfected = true
		infectedScreen.visible = true
		InfectText.visible = true
		$Timer.autostart = true


			
	if body != self:
		Health -= 20
	

	


func _on_InfectTextTimer_timeout():
	InfectText.visible = false
