extends Node

const drone = preload("res://player/Drone.tscn")
const bomb = preload("res://projectiles/Bomb.tscn")
const turret_bullet = preload("res://projectiles/Bullet_turret.tscn")
const mortar = preload("res://projectiles/Mortar.tscn")
const mortar_poof = preload("res://projectiles/Smoke1.tscn")
const game_over_scene = preload("res://GameOver.tscn")

var d_stock = 100
const d_regen = 6
var d_timer = 0
signal count_drones(d_stock)
signal count_cars

# Called when the node enters the scene tree for the first time.

func _enter_tree():
    add_to_group("main")

func _ready():
    music.play_a_music()
    emit_signal("count_cars")
    for i in range(4):
        add_drone()
    #Hooking up game_over from Truck.tscn
    var truck = $FrontLayer/Truck
    truck.connect("game_over", self, "_on_GameOver")

func _process(delta):
    d_timer += delta
    if d_timer > d_regen:
        d_timer = 0
        if d_stock < 500:
            d_stock += 1
            emit_signal("count_drones",d_stock)
            
func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_SPACE:
            shoot_drone_at_target()
        if event.scancode == KEY_SHIFT:
            add_drone()

func shoot_drone_at_target(): # this will be refactored into something more sensible later <- bold claim
    var turrets = get_tree().get_nodes_in_group("live_turrets")
    if turrets.size() > 0:
        #var train_pos = turrets[0].get_global_position()
        var drones = get_tree().get_nodes_in_group("drones")
        var drone_dispatched = false
        var i = 0
        while !drone_dispatched && drones.size() > i:
            var drone = drones[i]
            if drone.target == null:
                drone_dispatched = true
                var target_pos = $Cursor.position
                drone.bombing_run(target_pos)
            i += 1

func add_drone():
    if d_stock <= 0:
        return
    var d = drone.instance()
    $FrontLayer.add_child(d)
    var y_offset = randi() % 256
    d.set_position(Vector2(-64, -64 + y_offset))
    d_stock -= 1
    emit_signal("count_drones",d_stock)

func _on_Drone_drop_bomb(position):
    drop_bomb(position)
    
func _on_Drone_restock_drone():
    d_stock += 1
    emit_signal("count_drones",d_stock)

func _on_Car_check():
    emit_signal("count_cars")
    
func drop_bomb(position):
    var b = bomb.instance()
    add_child(b)
    b.set_position(position)
    
func _on_Turret_shoot_bullet(position, angle):
    var b = turret_bullet.instance()
    shoot_bullet(position, angle, b)
    
func shoot_bullet(position, angle, b):
    add_child(b)
    b.position = position
    b.rotation = angle

func _on_Turret_shoot_mortar(position):
    var truck_loc = $FrontLayer/Truck.position
    shoot_mortar(position, truck_loc)

func shoot_mortar(position, target):
    var l = mortar_poof.instance()
    var m = mortar.instance()
    var s = 1 
    $FrontLayer.add_child(l)
    l.set_position(position)
    $FrontLayer.add_child(m)
    m.set_position(position)
    m.set_target(target)

func _on_GameOver():
    switcher.switch_scene("res://GameOver.tscn")
    
