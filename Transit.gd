extends CanvasLayer

signal ftb_done


func _ready():
    pass

func fade_black():
    $Anime.play("ftb")

func fade_normal():
    $Anime.play("ffb")

func _on_AnimationPlayer_animation_finished(anim_name):
    if anim_name == "ftb":
        emit_signal("ftb_done")
        $Anime.play("ffb")
