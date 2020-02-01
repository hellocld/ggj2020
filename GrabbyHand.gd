extends ARVRController

var _mesh_basis: Basis
onready var _velocity_queue = []
export var _queue_size = 60
export var _throw_force = 30
onready var _last_pos = global_transform.origin
onready var _last_player_pos = get_parent().transform.origin

signal grabbing
signal releasing(velocity)


func _ready():
	connect("button_pressed", self, "_grab")
	connect("button_release", self, "_release")


func _physics_process(delta):
	_velocity_queue.push_back((global_transform.origin - _last_pos) - 
			(get_parent().transform.origin - _last_player_pos))
	_last_pos = global_transform.origin
	_last_player_pos = get_parent().transform.origin #use this to neutralize player movement while holding something
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
		vel += (_velocity_queue[i] * pow(float(i) / _velocity_queue.size(), 3))
	return vel * _throw_force
