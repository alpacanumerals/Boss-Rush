extends AnimatedSprite

func _ready():
    #sounds.sfx_explosion1()
    play()

func _on_Explosion_animation_finished():
    queue_free()
