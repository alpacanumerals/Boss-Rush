extends Turret

signal shoot_bullet(location, angle)

var shoot_rate:float
var shoot_timer = 0
var shoot_offset = Vector2()
var hard = 0
var burst

var target
var direction_to_target

func _ready():
    $AnimatedSprite.set_animation("gun")
    $AnimatedSprite.set_frame(7)

    var main_node = get_tree().get_nodes_in_group("main")[0]
    connect("shoot_bullet", main_node, "_on_Turret_shoot_bullet")
    
    shoot_timer = float(randi() % 20)/10
    burst = hard

func _physics_process(delta):
    if live:
        target = get_tree().get_nodes_in_group("cursor")[0]
        var drone_count = get_tree().get_nodes_in_group("drones").size()
        if drone_count == 0:
            target = get_tree().get_nodes_in_group("truck")[0]
        
        direction_to_target = global_position.angle_to_point(target.global_position)
        
        aim()
        shoot_timer += delta
        if shoot_timer > shoot_rate:
            if burst > 0:
                shoot_timer = shoot_rate - 0.1
                burst -= 1
            else:
                shoot_timer = 0
                burst = hard
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
    emit_signal("shoot_bullet", shot_origin, direction_to_target)

func activate():
    target = get_tree().get_nodes_in_group("cursor")[0]
    #if you see this mal, this calls the 'activate' function in the base 'turret' class
    #which was overridden by the function of the same name here in the derived class
    .activate()
