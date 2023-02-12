extends KinematicBody2D

signal killed
var explosion = preload("res://projectiles/Explosion.tscn")

var live = false
var dead = false

var explosion_timer = 0

func _ready():
    $AnimatedSprite.play("default")
    connect("killed", get_parent(), "_on_Car_killed")

func _physics_process(delta):
    if dead:
        explosion_timer += 1
        if explosion_timer > 10:
            explosion_timer = 0
            scatter_explosion()

func _on_Turret_killed():
    var turrets = get_tree().get_nodes_in_group("turrets")
    var turrets_alive = 0
    for turret in turrets:
        if turret.live:
            turrets_alive += 1
    if turrets_alive <= 0:
        emit_signal("killed")
        car_explode()

func car_explode():
    $AnimatedSprite.play("broken")
    live = false
    dead = true

func scatter_explosion():
    var x_loc = (randi() % 400) - 200
    var y_loc = (randi() % 100) - 50
    var e = explosion.instance()
    add_child(e)
    e.set_position(Vector2(x_loc, y_loc))

func activate():
    live = true
    $Turret1.activate()
