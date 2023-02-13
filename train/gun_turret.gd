extends Turret

signal shoot_bullet(location, angle)

var shoot_rate = 3
var shoot_timer = 0
var shoot_offset = Vector2()

var target
var direction_to_target

func _ready():
    $AnimatedSprite.set_animation("gun")
    $AnimatedSprite.set_frame(7)

    var main_node = get_tree().get_nodes_in_group("main")[0]
    connect("shoot_bullet", main_node, "_on_Turret_shoot_bullet")
    
    shoot_timer = float(randi() % 20)/10

func _physics_process(delta):
    if live:
        direction_to_target = global_position.angle_to_point(target.global_position)
        
        aim()
        shoot_timer += delta
        if shoot_timer > shoot_rate:
            shoot_timer = 0
            shoot()

func aim():
    var ang = direction_to_target/PI
    if (ang > 1.0/8 && ang < 3.0/8):
        $AnimatedSprite.set_frame(0)
    if (ang > 3.0/8 && ang < 5.0/8):
        $AnimatedSprite.set_frame(6)
    if (ang > 5.0/8 && ang < 7.0/8):
        $AnimatedSprite.set_frame(3)
    if (ang > 7.0/8 || ang < -7.0/8):
        $AnimatedSprite.set_frame(4)
    if (ang < 1.0/8 && ang > -1.0/8):
        $AnimatedSprite.set_frame(1)
    if (ang < -1.0/8 && ang > -3.0/8):
        $AnimatedSprite.set_frame(2)
    if (ang < -3.0/8 && ang > -5.0/8):
        $AnimatedSprite.set_frame(8)
    if (ang < -5.0/8 && ang > -7.0/8):
        $AnimatedSprite.set_frame(5)

func shoot():
    var shot_origin = global_position + shoot_offset
    emit_signal("shoot_bullet", shoot_offset, direction_to_target)

func activate():
    target = get_tree().get_nodes_in_group("cursor")[0]
    #if you see this mal, this calls the 'activate' function in the base 'turret' class
    #which was overridden by the function of the same name here in the derived class
    .activate()
