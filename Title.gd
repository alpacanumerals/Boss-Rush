extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    if not music.Orchestrion.is_playing():
        yield(get_tree().create_timer(0.5), "timeout")
        music.play_title()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


###Options button functionality.
func _on_Options_mouse_entered():
    sounds.ui_select()
    pass
    
func _on_Options_pressed():
    sounds.ui_confirm()
    switcher.switch_scene("res://Options.tscn")


###Full Screen button functionality.
func _on_FullScreen_mouse_entered():
    sounds.ui_select()
    pass
    
func _on_FullScreen_pressed():
    sounds.ui_confirm()
    yield(get_tree().create_timer(0.15), "timeout")
    if OS.window_fullscreen == false:
        OS.set_window_fullscreen(true)
    else:
        OS.set_window_fullscreen(false)


###New Game button functionality.
func _on_NewGame_mouse_entered():
    sounds.ui_select()
    pass

func _on_NewGame_pressed():
    sounds.ui_confirm()
    switcher.switch_scene("res://Main.tscn")
