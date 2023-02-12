extends KinematicBody2D

signal killed
signal shoot_rocket(location)

var live = false

func _ready():
    $AnimatedSprite.play("default")
    connect("killed", get_parent(), "_on_Turret_killed")

    var main_node = get_tree().get_nodes_in_group("main")[0]
    connect("killed", main_node, "_on_Turret_shoot_rocket")

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

func shoot_rocket():
    emit_signal("shoot_rocket", position)
