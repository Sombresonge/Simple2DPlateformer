extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Set the camera Limit
	# First we get the tilemap size
	var map = get_node("TestLevel/Forground")
	var mapArray = map.get_used_cells()	
	var lastTile = mapArray[mapArray.size()-1] + Vector2(1,1)
	var mapSize = map.map_to_world(lastTile,false)
	print("Map Size: " , mapSize)
	
	# With the tilemap size we can set the boundaries of the camera
	get_node("Player/Camera2D").setLimit(0 , 0, mapSize.y, mapSize.x)
	
	get_node("StreamPlayer").play()
	pass
