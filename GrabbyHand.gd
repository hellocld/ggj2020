extends ARVRController

var _mesh_basis: Basis
onready var _velocity_queue = []
var _queue_size = 60
onready var _last_pos = transform.origin

signal grabbing
signal releasing(velocity)


func _ready():
	connect("button_pressed", self, "_grab")
	connect("button_release", self, "_release")


func _physics_process(delta):
	_velocity_queue.push_back(transform.origin - _last_pos)
	_last_pos = transform.origin
	if _velocity_queue.size() > _queue_size:
		_velocity_queue.pop_front()


func _grab(var btn):
	if btn == JOY_VR_GRIP:
		print("Grabbing")
		_velocity_queue.clear()
		emit_signal("grabbing")


func _release(var btn):
	if btn == JOY_VR_GRIP:
		print("Releasing")
		print(_get_velocity())
		emit_signal("releasing", _get_velocity())


func is_grabbing() -> bool:
	return true if is_button_pressed(JOY_VR_GRIP) else false


func _get_velocity() -> Vector3:
	var vel = Vector3.ZERO
	for i in range(_velocity_queue.size()):
		vel += (_velocity_queue[i] * i)
	return vel
