extends Node


var Orchestrion : AudioStreamPlayer


func _ready():
    pause_mode = Node.PAUSE_MODE_PROCESS
    Orchestrion = AudioStreamPlayer.new()
    add_child(Orchestrion) 

func play_title():
    var music = load("res://sounds/music/dmusic.mp3")
    Orchestrion.set_bus("Music")
    Orchestrion.set_stream(music)
    Orchestrion.play()
    
func play_a_music():
    var music = load("res://sounds/music/train_boss.ogg")
    Orchestrion.set_bus("Music")
    Orchestrion.set_stream(music)
    Orchestrion.play()
        
func pause():
    Orchestrion.set_stream_paused(true)
    
func unpause():
    Orchestrion.set_stream_paused(false)
