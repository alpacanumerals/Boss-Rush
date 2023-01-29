extends KinematicBody2D

var direction_to_target
var velocity = Vector2()
var accel = -10
var resistance = 0.00002
var speed_limit = 500

var target = null

func _ready():
    add_to_group("drones")
    $DriveSprite.play()

func _physics_process(delta):
    var target_loc = get_global_mouse_position()
    if target != null:
        target_loc = target
    direction_to_target = global_position.angle_to_point(target_loc)
    
    velocity = velocity + get_thrust_vector()
    velocity = velocity + get_drag_vector(velocity)
    velocity = velocity.limit_length(speed_limit)
    
    var collision = move_and_collide(velocity * delta)
    if collision:
        handle_collision()

func assign_target(new_target):
    accel = -20
    speed_limit = 1000
    target = new_target
    # this next is janky and maybe better handled by toggling collision shape or whatever
    # NOTE: layer in UI is layer in code +1. the below code modifies layer #3
    set_collision_mask_bit(2, true)

func handle_collision():
        print("Wham!")
        queue_free()

func get_thrust_vector():
    return Vector2(accel, 0).rotated(direction_to_target)
    
func get_drag_vector(velocity):
    var speed = velocity.length() - 200 # we don't apply drag below a certain speed
    if speed < 0:
        return Vector2(0, 0)
    var drag = speed * speed * resistance
    var drag_vector = -1 * velocity.normalized() * drag
    return drag_vector
