extends Node

var rng  = RandomNumberGenerator.new()

func _ready():
    pause_mode = Node.PAUSE_MODE_PROCESS
    rng.randomize()
