extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var coins = get_children()
	for coin in coins:
		var collider = StaticBody2D.new()
		collider.set_pickable(false)
		var shape = CircleShape2D.new()
		collider.add_shape(shape)
		collider.add_to_group("coins")
		coin.add_child(collider, true)
