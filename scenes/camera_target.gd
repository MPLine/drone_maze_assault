class_name  CameraShake
extends Node3D

func cameraShake(duration:float, strength: float)-> void:
	print("shake camera")
	var original_rotation = 0.0
	var shake_start_time = Time.get_ticks_msec() / 1000.0
	
	while (Time.get_ticks_msec() / 1000.0) - shake_start_time<duration:
		print("shaking")
		rotation.z = randf_range(-strength,strength)
		await get_tree().process_frame
	rotation.z =0.0
