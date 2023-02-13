extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var timer

var live = true

func _ready():
    add_to_group("bullets")
    $AnimatedSprite.play("default")
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
    if live:
        velocity = Vector2(-speed*delta, 0).rotated(rotation)
        var collision = move_and_collide(velocity)
        if collision:
            handle_collision(collision.collider)
    
func handle_collision(collider):
    if collider.has_method("hit_by_enemy"):
        collider.hit_by_enemy()
    explode()
    
func explode():
    live = false
    $CollisionShape2D.disabled = true
    $AnimatedSprite.play("explode")

func hit_by_bullet():
    $AnimatedSprite.play("explode")
    $CollisionShape2D.disabled = true

func _on_AnimatedSprite_animation_finished():
    if !live:
        queue_free()
