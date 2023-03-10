extends KinematicBody2D

signal killed
const explosion = preload("res://projectiles/Explosion.tscn")
const fire = preload("res://projectiles/Fire.tscn")

const gun_turret = preload("res://train/GunTurret.tscn")
const mortar_turret = preload("res://train/MortarTurret.tscn")
const turrets = [gun_turret, mortar_turret]

var live = false
var dead = false
var burnout = false

var number:int = 0

var explosion_interval = 0.1
var burnout_limit = 5

var explosion_timer = 0
var burnout_timer = 0

func _ready():
    $AnimatedSprite.play("default")
    connect("killed", get_parent(), "_on_Car_killed")
    for i in range(12):
        add_turret(i)
    
func _physics_process(delta):
    if global_position.x < -500:
        queue_free()
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
    var turrets = get_tree().get_nodes_in_group("live_turrets")
    var turrets_alive = 0
    for turret in turrets:
        if turret.live:
            turrets_alive += 1
    if turrets_alive <= 0:
        emit_signal("killed")
        remove_turrets()
        car_explode()

func remove_turrets():
    var kids = get_children()
    for kid in kids:
        if kid.has_method("remove"):
            kid.remove()

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
    var y_loc = (randi() % 75) - 50
    var f = fire.instance()
    add_child(f)
    f.set_position(Vector2(x_loc, y_loc))

func activate():
    live = true
    var kids = get_children()
    for kid in kids:
        if kid.has_method("activate"):
            kid.activate()

func add_turret(tnum):
    var selector
    if number+1 > tnum:
        if number < 2:
            selector = 0
        else:    
            selector = randi() % 2
        var rounder = (number/10)
        var m_t = turrets[selector].instance()
        add_child(m_t)
        m_t.set_position(Vector2(-176 + 32*tnum, -38))
        m_t.shoot_rate = 4 - number/20
        m_t.hard = rounder
    else: 
        pass
