extends KinematicBody2D

var ascending = true
var descending = true

var target = Vector2()

func _ready():
    add_to_group("mortars")

func _physics_process(delta):
    var velocity = Vector2()
    if ascending:
        velocity.y = -5
    if descending:
        velocity.y = 5
    var collision = move_and_collide(velocity)
    if collision:
        handle_collision(collision.collider)
            
func handle_collision(collider):
    pass
