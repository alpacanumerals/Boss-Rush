extends KinematicBody2D

var accel_f= 2
var accel_r= 8
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    $FWheel.play()
    $RWheel.play()


func _physics_process(delta):
    process_movement_input()
    velocity = move_and_slide(velocity)

func process_movement_input():
    if Input.is_action_pressed("ui_right"):
        velocity.x += accel_f
    if Input.is_action_pressed("ui_left"):
        velocity.x -= accel_r
    velocity.x = clamp(velocity.x, -160, 80)
    #if self.position.x <= 63 or self.position.x >=585:
    #    velocity.x = 0
