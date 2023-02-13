extends KinematicBody2D

const gravity = 0.1
var velocity = Vector2()

var live = true

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("default")

func _physics_process(delta):
    if live:
        velocity.y += gravity
        var collision = move_and_collide(velocity)
        if collision:
            handle_collision(collision.collider)

func handle_collision(collider):
    collider.hit_by_bullet() 
    $AnimatedSprite.play("explode")
    $CollisionShape2D.disabled = true
    live = false

func hit_by_enemy():
    $AnimatedSprite.play("explode")
    $CollisionShape2D.disabled = true
    live = false

func _on_AnimatedSprite_animation_finished():
    if !live:
        queue_free()
