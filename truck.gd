extends KinematicBody2D

var accel = 1
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play()


func _physics_process(delta):
    process_movement_input()
    velocity = move_and_slide(velocity)

func process_movement_input():
    if Input.is_action_pressed("ui_right"):
        velocity.x += accel
    if Input.is_action_pressed("ui_left"):
        velocity.x -= accel
    velocity.x = clamp(velocity.x, -120, 120)
