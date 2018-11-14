extends Polygon2D

func _ready():
	set_percent(1)

func set_percent(percent):
	$health.set_scale(Vector2(percent, 1))

