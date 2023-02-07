extends Node2D

var car = preload("res://Car.tscn")


func _ready():
    add_car(0)
    add_car(1)
    add_car(2)
    
func _physics_process(delta):
    pass

func add_car(number):
    var c = car.instance()
    add_child(c)
    c.set_position(Vector2(number*410, 0))
    
