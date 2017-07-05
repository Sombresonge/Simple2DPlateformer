extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum direction { LEFT, RIGHT }

const gravity = 20
const MAX_H_SPEED = 200
const MAX_J_SPEED = 30

var velocity = Vector2(0, 0)
var oldVelocity = Vector2(0, 0)

enum playerStat {IDLE, MOVING, JUMPING}
var currentStat = IDLE
var previousStat = IDLE
var isWalkingSound = false
var walkingVoice = 0
var life = 100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var Animation = get_node("AnimationPlayer")
	Animation.play("Player_idle")
	set_process(true)
	direction = LEFT

signal coinPicked()
signal lifeAdjusted(life)

func _process(delta):	
	var velocity = Vector2(0,oldVelocity.y)
	
	if Input.is_action_pressed("MoveLeft") :
		velocity += Vector2( - MAX_H_SPEED * delta, 0)
		if direction == RIGHT :
			direction = LEFT
			get_node("Sprite").set_flip_h(true)
			if (currentStat != MOVING):
				previousStat = currentStat
				currentStat = MOVING
	elif Input.is_action_pressed("MoveRight") :
		velocity += Vector2(MAX_H_SPEED * delta, 0)
		if direction == LEFT :
			direction = RIGHT
			get_node("Sprite").set_flip_h(false)
			if (currentStat != MOVING):
				previousStat = currentStat
				currentStat = MOVING
	
	if Input.is_action_pressed("Jump") :
		velocity += Vector2(0, -MAX_J_SPEED * delta)
		if (currentStat != JUMPING):
				previousStat = currentStat
				currentStat = JUMPING
	
	if (currentStat == MOVING) :
		if (isWalkingSound == false) :
			isWalkingSound = true
			#walkingVoice = get_node("SamplePlayer2D").play("step", 0)
	else :
		isWalkingSound = false
		get_node("SamplePlayer2D").stop_voice(walkingVoice)
	
	velocity.y += gravity * delta
	var remainder = move(velocity)
	
	if is_colliding() :
		var collider = get_collider()
		if ("coins" in collider.get_groups()):
			print(collider)
			var coin = collider.get_parent()
			print(coin)
			collider.remove_and_skip()
			coin.remove_and_skip()
			collider.queue_free()
			coin.queue_free()
			move(remainder)
			emit_signal("coinPicked")
			get_node("SamplePlayer2D").play("coin", 1)
			
		elif ("ennemies" in collider.get_groups()) :
			manageCollisionWithEnnenies()
			
		else :
			var normal = get_collision_normal()
			move(normal.slide(remainder))
			velocity.y = 0
	oldVelocity = velocity
	
func _on_Skeleton_collisionDetected():
	manageCollisionWithEnnenies()

func manageCollisionWithEnnenies():
	life -= 1
	if (life == 0) :
		life = 100
	emit_signal("lifeAdjusted", life)