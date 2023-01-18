extends Node

#var current_scene


func _ready():
    pause_mode = Node.PAUSE_MODE_PROCESS
    
func switch_scene(path):
    yield(get_tree().create_timer(0.15), "timeout")
    get_tree().change_scene(path)
    get_tree().paused = false
    
func switch_scene_long(path):
    yield(get_tree().create_timer(0.5), "timeout")
    get_tree().change_scene(path)
    get_tree().paused = false
    
func switch_quit():
    yield(get_tree().create_timer(0.20), "timeout")
    get_tree().quit()

