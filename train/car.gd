extends KinematicBody2D

signal killed
var explosion = preload("res://projectiles/Explosion.tscn")
var fire = preload("res://projectiles/Fire.tscn")

var mortar_turret = preload("res://train/MortarTurret.tscn")

var live = false
var dead = false
var burnout = false

var explosion_interval = 0.1
var burnout_limit = 5

var explosion_timer = 0
var burnout_timer = 0

func _ready():
    $AnimatedSprite.play("default")
    connect("killed", get_parent(), "_on_Car_killed")
    add_turret(0)
    add_turret(1)

func _physics_process(delta):
    if dead:
        explosion_timer += delta
        burnout_timer += delta
        if explosion_timer > explosion_interval && burnout_timer < burnout_limit:
            explosion_timer = 0
            scatter_explosion()
        if burnout_timer > burnout_limit && !burnout:
            burnout = true
            scatter_fires()

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

func scatter_fires():
    for i in range(10):
        scatter_fire()
    
func scatter_fire():
    var x_loc = (randi() % 400) - 200
    var y_loc = (randi() % 100) - 50
    var f = fire.instance()
    add_child(f)
    f.set_position(Vector2(x_loc, y_loc))

func activate():
    live = true

func add_turret(number):
    var m_t = mortar_turret.instance()
    add_child(m_t)
    m_t.set_position(Vector2(-176 + 32*number, -38))
