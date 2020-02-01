extends Area

onready var controller: ARVRController = get_parent()

var _grabbable

func _ready():
	controller.connect("grabbing", self, "_grab_it")
	controller.connect("releasing", self, "_let_go")


func _grab_it():
	if _grabbable != null and _grabbable.has_method("_on_grabbed"):
		_grabbable.call("_on_grabbed", controller)


func _let_go(vel):
	if _grabbable != null and _grabbable.has_method("_on_released"):
		_grabbable.call("_on_released", vel)


func _on_GrabbingArea_body_entered(body: PhysicsBody):
	if body.has_method("_on_grabbed"):
		_grabbable = body
	else:
		_grabbable = null


func _on_GrabbingArea_body_exited(body):
	_grabbable = null
