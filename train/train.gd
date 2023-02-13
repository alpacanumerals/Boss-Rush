extends Node2D

signal check_cars
const car = preload("res://train/Car.tscn")
const car_size = 410

var current_car = 0
var started = false

var target_x = 430

func _ready():
    add_car(0)
    add_car(1)
    add_car(2)
    connect("check_cars", get_parent(), "_on_Car_check")
    
func _physics_process(delta):
    if !started:
        activate(current_car)
        started = true
    move_to_target(delta)

func move_to_target(delta):
    var velocity = Vector2()
    if position.x > target_x:
        velocity = Vector2(-100, 0)
    translate(velocity * delta)
    
func add_car(number):
    var c = car.instance()
    add_child(c)
    c.set_position(Vector2(number*car_size, 0))
    c.add_to_group("cars")
    
func _on_Car_killed():
    current_car += 1
    settings.cars += 1
    emit_signal("check_cars")
    activate(current_car)
    target_x -= car_size

func activate(carriage):
    var cars = get_tree().get_nodes_in_group("cars")
    if carriage < cars.size():
        cars[carriage].activate()
    
