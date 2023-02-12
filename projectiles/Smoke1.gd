extends AnimatedSprite


func _ready():
    sounds.sfx_shoot_mortar()
    play()


func _on_Smoke_animation_finished():
    queue_free()
