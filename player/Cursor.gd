extends KinematicBody2D

var velocity = Vector2()
const speed = 250

func _ready():
    add_to_group("cursor")

func _process(delta):
    process_movement_input()
    velocity = move_and_slide(velocity)
    
func process_movement_input():
    velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    velocity = velocity.normalized() * speed
