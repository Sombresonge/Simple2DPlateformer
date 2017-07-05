extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var actualScore = 0;
var score
var lifeProgress

func _ready():
	score = get_node("Score Label/Score")
	score.set_text("%s" %actualScore)
	lifeProgress = get_node("Life/ProgressBar")
	lifeProgress.set_value(100)
	pass


func onCoinPicked():
	actualScore += 1
	score.set_text("%s" %actualScore)
	pass # replace with function body


func onPlayerLifeAdjusted( life ):
	lifeProgress.set_value(life)
	pass # replace with function body
