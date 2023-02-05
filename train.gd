extends KinematicBody2D

func _ready():
    $AnimatedSprite.play("default")

func _physics_process(delta):
    move_and_collide(Vector2(0.1,0))

func get_turret_position(index):
    pass
