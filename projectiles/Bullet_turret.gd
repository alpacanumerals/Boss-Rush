extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var timer

func _ready():
    add_to_group("bullets")
    timer = 0.0
    
func _process(delta):
    #Safety despawns
    if abs(position.x) > 1440:
        queue_free()
    if abs(position.y) > 1440:
        queue_free()
    timer += delta
    if timer > 12.0:
        queue_free()
    velocity = Vector2(-speed*delta, 0).rotated(rotation)
    var collision = move_and_collide(velocity)
    if collision:
        handle_collision(collision.collider)
    
func handle_collision(collider):
    if collider.has_method("hit_by_enemy"):
        collider.hit_by_enemy()
    queue_free()
