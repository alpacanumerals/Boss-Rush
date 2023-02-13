extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()
var timer

func _ready():
    add_to_group("bullets")
    timer = 0.0
    connect("body_entered", self, "HitResolution") 
    
func _process(delta):
    #Safety despawns
    if abs(position.x) > 1440:
        queue_free()
    if abs(position.y) > 1440:
        queue_free()
    timer += delta
    if timer > 12.0:
        queue_free()
    velocity = Vector2(-speed*delta, 0).rotated(rotation)
    position = position + velocity
    

func HitResolution(body):
    if body.has_method("hit_by_enemy"):
        body.hit_by_enemy()
    timer += 12.0
