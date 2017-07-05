extends ParallaxLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var scrollSpeed = 80
var offset = 0

func _ready():
	set_process(true)
	
func _process(delta):
	offset -= scrollSpeed * delta
	if (offset < -1920) :
		offset = 0
	set_motion_offset(Vector2(offset, 0))