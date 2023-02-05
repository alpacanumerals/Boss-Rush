extends KinematicBody2D

signal killed
var live = true

func _ready():
    add_to_group("turrets")
    $AnimatedSprite.play("default")
    connect("killed", get_parent(), "_on_Turret_killed")

func hit_by_bullet():
    if live:
        handle_kill()

func handle_kill():
    live = false
    $AnimatedSprite.play("burn")
    $CollisionShape2D.disabled = true
    emit_signal("killed")
