extends RayCast


func _physics_process(delta):
	$"Mesh".global_transform.origin = get_collision_point()
