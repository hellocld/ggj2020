extends RigidBody

onready var _parent = get_parent()
onready var _grabbed = false


func is_grabbed():
	return _grabbed


func _on_grabbed(var hand:ARVRController):
	if _grabbed:
		return
	mode = RigidBody.MODE_STATIC
	get_parent().remove_child(self)
	hand.add_child(self)
	transform = Transform()
	_grabbed = true
	print("%s Grabbed" % name)


func _on_released(var vel):
	if !_grabbed:
		return
	var t = global_transform
	get_parent().remove_child(self)
	_parent.add_child(self)
	global_transform = t
	mode = RigidBody.MODE_RIGID
	apply_impulse(Vector3.ZERO, vel)
	print("Impulse %s applied" % vel)
	_grabbed = false
	print("%s Released" % name)
