extends Node


func _ready():
    var music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
    var music_slider = get_node("%MusicSlider")
    music_slider.set_value(music_volume)
    var sound_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound"))
    AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), true)
    var sound_slider = get_node("%SoundSlider")
    sound_slider.set_value(sound_volume)
    AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), false)
    var tutorial_toggle = settings.tutorial
    if tutorial_toggle:
        get_node("%TutorialButton").set_pressed_no_signal(true)
    else:
        get_node("%TutorialButton").set_pressed_no_signal(false)

func update_music(value):
    value = clamp(value, -50, 15) #make sure the value is sensible
    settings.musiclevel = value
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
    if value == -50:
        AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
    else:
        AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)    
    
func update_sound(value):
    value = clamp(value, -50, 15) #make sure the value is sensible
    settings.soundlevel = value 
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), value)
    if value == -50:
        AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), true)
    else:
        AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), false)
    if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
        sounds.ui_confirm()


###Back button functionality.
func _on_BackButton_pressed():
    sounds.ui_confirm()
    switcher.switch_scene("res://Title.tscn")

func _on_BackButton_mouse_entered():
    sounds.ui_select()


###Tutorial switch functionality.
func _on_TutorialButton_mouse_entered():
    get_node("%TutorialWord").set_pressed(true)

func _on_TutorialButton_mouse_exited():
    get_node("%TutorialWord").set_pressed(false)
    
func _on_TutorialButton_toggled(button_pressed):
    if button_pressed:
        sounds.ui_confirm()
        settings.tutorial = true
    else:
        sounds.ui_cancel()
        settings.tutorial = false


###Music slider functionality.
func _on_MusicSlider_value_changed(value):
    update_music(value)

func _on_MusicSlider_focus_entered():
    get_node("%MusicWord").set_pressed_no_signal(true)

func _on_MusicSlider_focus_exited():
    get_node("%MusicWord").set_pressed_no_signal(false)


###Sound slider functionality.
func _on_SoundSlider_drag_ended(value_changed):
    sounds.ui_confirm()

func _on_SoundSlider_value_changed(value):
    update_sound(value)

func _on_SoundSlider_focus_entered():
    get_node("%SoundWord").set_pressed_no_signal(true)

func _on_SoundSlider_focus_exited():
    get_node("%SoundWord").set_pressed_no_signal(false)
