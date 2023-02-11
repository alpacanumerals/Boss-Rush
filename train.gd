extends Node2D

var car = preload("res://Car.tscn")
var current_car = 0

func _ready():
    add_car(0)
    add_car(1)
    add_car(2)
    activate(current_car)
    
func _physics_process(delta):
    pass

func add_car(number):
    var c = car.instance()
    add_child(c)
    c.set_position(Vector2(number*410, 0))
    c.add_to_group("cars")
    
func _on_Car_killed():
    current_car += 1
    activate(current_car)

func activate(carriage):
    var cars = get_tree().get_nodes_in_group("cars")
    if carriage < cars.size():
        cars[carriage].activate()
    
