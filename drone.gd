extends KinematicBody2D

var direction_to_mouse
var velocity = Vector2()
var accel = -10
var resistance = 0.00002

func _ready():
    $AnimatedSprite.play()

func _physics_process(delta):
    direction_to_mouse = global_position.angle_to_point(get_global_mouse_position())
    
    velocity = velocity + get_thrust_vector()
    velocity = velocity + get_drag_vector(velocity)
    velocity = velocity.limit_length(500) # this shouldn't normally matter much unless you turn off drag
    
    velocity = move_and_slide(velocity)

func get_thrust_vector():
    return Vector2(accel, 0).rotated(direction_to_mouse)
    
func get_drag_vector(velocity):
    var speed = velocity.length() - 200 # we don't apply drag below a certain speed
    if speed < 0:
        return Vector2(0, 0)
    var drag = speed * speed * resistance
    var drag_vector = -1 * velocity.normalized() * drag
    return drag_vector
