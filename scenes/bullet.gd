extends Area3D

@export var speed =10


var direction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$life_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed * delta
	pass


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player"):
		queue_free()
	pass # Replace with function body.


func _on_life_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
