extends CharacterBody3D


const SPEED = 10.0
@onready var camera = $"../Camera3D"
@onready var bullet_scn = preload("res://scenes/bullet.tscn")
var camera_posiY

func _ready() -> void:
	camera_posiY =camera.position.y
	pass
	
func CameraFollow():
	camera.position.x = lerp(camera.position.x,self.position.x,0.2)
	camera.position.z = lerp(camera.position.z,self.position.z,0.2)
	camera.position.y =camera_posiY
	
	pass

func mousrotation():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	# Create a horizontal plane at the player's Y level
	var drop_plane = Plane(Vector3.UP, global_position.y)
	var target_pos = drop_plane.intersects_ray(ray_origin, ray_direction)

	if target_pos:
		look_at(Vector3(target_pos.x, global_position.y, target_pos.z), Vector3.UP)

func bullet_direction(bullet):
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var drop_plane = Plane(Vector3.UP, bullet.global_position.y)
	var target_pos = drop_plane.intersects_ray(ray_origin, ray_direction)
	return Vector3(target_pos.x, target_pos.y, target_pos.z)
	pass
	
	
func fire():
	var g1 = bullet_scn.instantiate()
	var g2 = bullet_scn.instantiate()
	g1.position = $GUN1.global_position
	g2.position = $GUN2.global_position
	g1.direction = bullet_direction(g1)
	g2.direction = bullet_direction(g2)
	add_child(g1)
	add_child(g2)
	print("fire")
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("enterfire")
		fire()
	pass
func _physics_process(delta: float) -> void:
	mousrotation()
	CameraFollow()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
