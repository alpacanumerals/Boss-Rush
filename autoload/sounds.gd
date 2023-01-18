extends Node

var current_scene

var select_sound = preload("res://sounds/ui/ui_select.tscn")
var confirm_sound = preload("res://sounds/ui/ui_confirm.tscn")
var cancel_sound = preload("res://sounds/ui/ui_cancel.tscn")

var sfx_select
var sfx_confirm
var sfx_cancel

func _ready():
    pause_mode = Node.PAUSE_MODE_PROCESS
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"),-10.0)
    #An autoloaded node is the elder sibling of whatever scene is active, so they share a root.
    var root = get_tree().get_root()
    #A count of the children is always 1 more than the 0-indexed id of the active scene.
    #(The one with everything in it)
    current_scene = root.get_child(root.get_child_count() - 1)
    sfx_select = select_sound.instance()
    sfx_confirm = confirm_sound.instance()
    sfx_cancel = cancel_sound.instance()
    add_child(sfx_select)
    add_child(sfx_confirm)
    add_child(sfx_cancel)

func ui_select():
    sfx_select.play()
    
func ui_confirm():
    sfx_confirm.play()
    
func ui_cancel():
    sfx_cancel.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
