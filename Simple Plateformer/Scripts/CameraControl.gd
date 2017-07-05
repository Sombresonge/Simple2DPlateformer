extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func setLimit(top, left, bottom, right):
	print("TL: ", top ,",",left," BL: ", bottom, ",",right)
	set_limit(MARGIN_TOP, top)
	set_limit(MARGIN_LEFT, left)
	set_limit(MARGIN_BOTTOM, bottom)
	set_limit(MARGIN_RIGHT, right)
