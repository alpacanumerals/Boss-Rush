extends KinematicBody2D

signal drop_bomb(direction)
signal restock_drone

var direction_to_target
var velocity = Vector2()
var accel = -50
var resistance = 0.00005
var speed_limit = 500

var target = null
var bombing_run_active = false
var bombing_run_complete = false

var live = true

const bodies = ["body1", "body2", "body3", "body4"]
const drives = ["drive1", "drive2", "drive3", "drive4"]
const batteries = ["batt1", "batt2", "batt3", "batt4"]
const weapons = ["bomb", "gun", "warhead", "none"]

func _ready():
    add_to_group("drones")
    $BodySprite.play(bodies[randi() % 4])
    $DriveSprite.play(drives[randi() % 4])
    $BatterySprite.play(batteries[randi() % 4])
    $WeaponSprite.play(weapons[0])
    connect("drop_bomb", get_node("/root/Main"), "_on_Drone_drop_bomb")
    connect("restock_drone", get_node("/root/Main"), "_on_Drone_restock_drone")

func _physics_process(delta):
    if bombing_run_complete:
        if position.x < -100:
            emit_signal("restock_drone")
            queue_free()
    # it would be better to only need to initialise this once
    var target_loc = get_tree().get_nodes_in_group("cursor")[0].global_position
    if target != null:
        target_loc = target
    direction_to_target = global_position.angle_to_point(target_loc)
    
    velocity = velocity + get_thrust_vector()
    velocity = velocity + get_drag_vector(velocity)
    velocity = velocity.limit_length(speed_limit)
    
    var collision = move_and_collide(velocity * delta)
    #if collision:
    #    handle_collision()
        
    if bombing_run_active:
        check_targeting()
    
func assign_target(new_target):
    #accel = -20
    #speed_limit = 1000
    target = new_target
    #assign_collide(true)
    
func check_targeting():
    if target != null && abs(position.x - target.x) < 16 && position.y < target.y:
        drop_bomb()

func bombing_run(new_target):
    var above_target = Vector2(new_target.x, 64)
    assign_target(above_target)
    bombing_run_active = true
    pass

func drop_bomb():
    emit_signal("drop_bomb", position)
    $WeaponSprite.play(weapons[3])
    bombing_run_active = false
    bombing_run_complete = true
    assign_target(Vector2(-160, 160))
    
func assign_collide(collide):
    # this is janky and maybe better handled by toggling collision shape or whatever
    # NOTE: layer in UI is layer in code +1. the below code modifies layer #3
    set_collision_mask_bit(2, collide)

func handle_collision():
    if live:
        live = false
        explode()

func get_thrust_vector():
    return Vector2(accel, 0).rotated(direction_to_target)
    
func get_drag_vector(velocity):
    var speed = velocity.length() - 300 # we don't apply drag below a certain speed
    if speed < 0:
        return Vector2(0, 0)
    var drag = speed * speed * resistance
    var drag_vector = -1 * velocity.normalized() * drag
    return drag_vector

func hit_by_enemy():
    if live:
        live = false
        explode()

func explode():
    $BodySprite.play("explode")
    $DriveSprite.play("explode")
    $BatterySprite.play("explode")
    $WeaponSprite.play("explode")
    $CollisionShape2D.disabled = true

func _on_BodySprite_animation_finished():
    if !live:
        queue_free()
