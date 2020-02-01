extends ARVROrigin
export var _speed: int = 10

var _can_turn = true
var _rotation: float
var _rot_increment: int = 30

func _physics_process(delta):
	var r_stick = Vector2($"RightController".get_joystick_axis(0), 
			$"RightController".get_joystick_axis(1))
	
	var cam_basis = ARVRServer.get_hmd_transform().basis
	var turn = $"LeftController".get_joystick_axis(0)
	
	if abs(turn) > 0.5 && _can_turn:
		_can_turn = false
		if turn > 0:
			_rotation = -_rot_increment
		else:
			 _rotation = _rot_increment
		rotate(Vector3.UP, deg2rad(_rotation))
		cam_basis = cam_basis.rotated(Vector3.UP, _rotation)
	if !_can_turn && abs(turn) < 0.5:
		_can_turn = true
	
	
	cam_basis.x.y = 0
	cam_basis.z.y = 0
	
	translate(r_stick.x * cam_basis.x.normalized() * delta * _speed)
	translate(-r_stick.y * cam_basis.z.normalized() * delta * _speed)
