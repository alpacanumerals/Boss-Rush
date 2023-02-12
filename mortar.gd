extends KinematicBody2D

const max_suspend_time = 3
var suspend_time = 0

var ascending = true
var descending = false

var target = Vector2()

func _ready():
    add_to_group("mortars")

func _physics_process(delta):
    var velocity = Vector2()
    if ascending:
        if position.y < -10:
            ascending = false
        velocity.y = -5
    if descending:
        velocity.y = 5
        if position.y > 360:
            queue_free()
    if !ascending && !descending:
        suspend_time += delta
        if suspend_time > max_suspend_time:
            position.x = target.x
            descending = true
    
    var collision = move_and_collide(velocity)
    if collision:
        handle_collision(collision.collider)
    
func handle_collision(collider):
    pass

func set_target(new_target):
    target = new_target
