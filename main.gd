extends Node

const drone = preload("res://Drone.tscn")
const bomb = preload("res://Bomb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    for i in range(4):
        add_drone()

func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_F:
            shoot_drone_at_target()
        if event.scancode == KEY_A:
            add_drone()

func shoot_drone_at_target(): # this will be refactored into something more sensible later <- bold claim
    var turrets = get_tree().get_nodes_in_group("turrets")
    if turrets.size() > 0:
        var train_pos = turrets[0].get_global_position()
        var drones = get_tree().get_nodes_in_group("drones")
        var drone_dispatched = false
        var i = 0
        while !drone_dispatched && drones.size() > i:
            var drone = drones[i]
            if drone.target == null:
                drone_dispatched = true
                drone.bombing_run(train_pos)
            i += 1

func drop_bomb(position):
    var b = bomb.instance()
    add_child(b)
    b.set_position(position)

func add_drone():
    var d = drone.instance()
    $FrontLayer.add_child(d)
    var y_offset = randi() % 256
    d.set_position(Vector2(-64, -64 + y_offset))

func _on_Drone_drop_bomb(position):
    drop_bomb(position)
