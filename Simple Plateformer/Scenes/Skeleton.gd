extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum direction { LEFT, RIGHT }

const gravity = 20
const MAX_H_SPEED = 50

var velocity = Vector2(0, 0)
var oldVelocity = Vector2(0, 0)
var originPos = Vector2(0,0)

enum characterStat {IDLE, MOVING, JUMPING}
var currentStat = IDLE
var previousStat = IDLE
var isWalkingSound = false
var walkingVoice = 0

const maxPositionOffest = 100

signal collisionDetected()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var Animation = get_node("AnimationPlayer")
	Animation.play("Walking")
	originPos = get_pos()
	direction = RIGHT
	set_process(true)

func _process(delta):
	velocity = oldVelocity
	var currentPos = get_pos()
	
	if (currentPos.x < originPos.x - maxPositionOffest ):
		direction = RIGHT
		get_node("Sprite").set_flip_h(false)
		velocity = Vector2(0,0)
	elif (currentPos.x > originPos.x + maxPositionOffest ):
		direction = LEFT
		get_node("Sprite").set_flip_h(true)
		velocity = Vector2(0,0)
		
	if(direction == RIGHT):
		velocity = Vector2( MAX_H_SPEED * delta, 0)
	else:
		velocity = Vector2( -MAX_H_SPEED * delta, 0)
	
	move(velocity)
	oldVelocity = velocity
	
	if(is_colliding()) :
		emit_signal("collisionDetected")
	