extends KinematicBody2D

signal killed
signal shoot_mortar(location)

var live = false

var shoot_rate = 3
var shoot_timer = 0

func _ready():
    $AnimatedSprite.play("mortar")
    connect("killed", get_parent(), "_on_Turret_killed")

    var main_node = get_tree().get_nodes_in_group("main")[0]
    connect("shoot_mortar", main_node, "_on_Turret_shoot_mortar")

func _physics_process(delta):
    if live:
        shoot_timer += delta
        if shoot_timer > shoot_rate:
            shoot_timer = 0
            shoot_mortar()

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

func shoot_gun():
    pass

func shoot_mortar():
    emit_signal("shoot_mortar", global_position)
