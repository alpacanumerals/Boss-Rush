extends Node2D

const drone = preload("res://Drone.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_F:
            shoot_drone_at_train()
        if event.scancode == KEY_A:
            add_drone()

func shoot_drone_at_train(): # this will be refactored into something more sensible later. it's exploratory
    var train_pos = $Train.get_global_position()
    var drones = get_tree().get_nodes_in_group("drones")
    var drone_dispatched = false
    var i = 0
    while !drone_dispatched && drones.size() > i:
        var drone = drones[i]
        if drone.target == null:
            drone_dispatched = true
            drone.bombing_run(train_pos)
        i += 1

func add_drone():
    var d = drone.instance()
    add_child(d)
    d.set_position(Vector2(0, 0))
