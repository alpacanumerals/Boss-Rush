extends KinematicBody2D

var live = true

func _ready():
    add_to_group("turrets")
    $AnimatedSprite.play("default")

func hit_by_bullet():
    if live:
        handle_kill()

func handle_kill():
    $AnimatedSprite.play("burn")
    $CollisionShape2D.disabled = true
    live = false
