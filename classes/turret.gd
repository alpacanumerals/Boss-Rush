class_name Turret extends KinematicBody2D

signal killed

var live = false

func _ready():
    connect("killed", get_parent(), "_on_Turret_killed")

func activate():
    add_to_group("live_turrets")
    live = true

func hit_by_bullet():
    if live:
        handle_kill()

func handle_kill():
    live = false
    remove_from_group("live_turrets")
    $AnimatedSprite.play("burn")
    $CollisionShape2D.disabled = true
    emit_signal("killed")

func remove():
    queue_free()
