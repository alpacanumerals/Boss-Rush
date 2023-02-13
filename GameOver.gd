extends Node


func _ready():
    pause_mode = Node.PAUSE_MODE_PROCESS
    get_tree().paused = true
    music.Orchestrion.stop()  

func _on_TextureButton_mouse_entered():
    sounds.ui_select()

func _on_TextureButton_pressed():
    sounds.ui_confirm()
    switcher.switch_scene("res://Title.tscn")
