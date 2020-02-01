extends RigidBody

onready var _parent = get_parent()
onready var _grabbed = false


func is_grabbed():
	return _grabbed


func _on_grabbed(var hand:ARVRController):
	if _grabbed:
		return
	set_mode(RigidBody.MODE_STATIC)
	get_parent().remove_child(self)
	hand.add_child(self)
	transform = Transform()
	_grabbed = true
	print("%s Grabbed" % name)


func _on_released():
	if !_grabbed:
		return
	var t = global_transform
	set_mode(RigidBody.MODE_RIGID)
	get_parent().remove_child(self)
	_parent.add_child(self)
	global_transform = t
	
	_grabbed = false
	print("%s Released" % name)
