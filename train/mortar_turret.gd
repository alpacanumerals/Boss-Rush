extends Turret

signal shoot_mortar(location)

var shoot_rate
var shoot_timer = 0
var hard = 0

func _ready():
    $AnimatedSprite.play("mortar")

    var main_node = get_tree().get_nodes_in_group("main")[0]
    connect("shoot_mortar", main_node, "_on_Turret_shoot_mortar")
    
    shoot_timer = float(randi() % 20)/10

func _physics_process(delta):
    if live:
        shoot_timer += delta
        if shoot_timer > shoot_rate:
            shoot_timer = 0
            shoot()

func shoot():
    var shoot_offset = global_position
    shoot_offset.y -= 7.75
    emit_signal("shoot_mortar", shoot_offset)
