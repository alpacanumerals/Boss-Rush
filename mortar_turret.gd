extends Turret

signal shoot_mortar(location)

var shoot_rate = 3
var shoot_timer = 0

func _ready():
    $AnimatedSprite.play("mortar")

    var main_node = get_tree().get_nodes_in_group("main")[0]
    connect("shoot_mortar", main_node, "_on_Turret_shoot_mortar")

func _physics_process(delta):
    if live:
        shoot_timer += delta
        if shoot_timer > shoot_rate:
            shoot_timer = 0
            shoot()

func shoot():
    emit_signal("shoot_mortar", global_position)
