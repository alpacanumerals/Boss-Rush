extends KinematicBody2D

var accel_f= 2
var accel_r= 8
var decel = 4
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    $FWheel.play()
    $RWheel.play()


func _physics_process(delta):
    process_movement_input()
    velocity = move_and_slide(velocity)*0.98

func process_movement_input():
    if Input.is_action_pressed("ui_right"):
        velocity.x += accel_f
    if Input.is_action_pressed("ui_left"):
        velocity.x -= accel_r
    #else: 
    #    velocity.x = velocity.x * 0.97
    velocity.x = clamp(velocity.x, -160, 90)
    #if self.position.x <= 63 or self.position.x >=585:
    #    velocity.x = 0
