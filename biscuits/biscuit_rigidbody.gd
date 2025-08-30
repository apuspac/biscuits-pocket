extends Node2D


@onready var C1 := $RigidBody2D/Choco/C1
@onready var C2 := $RigidBody2D/Choco/C2
@onready var C3 := $RigidBody2D/Choco/C3
@onready var B1 := $RigidBody2D/Butter/B1
@onready var B2 := $RigidBody2D/Butter/B2
@onready var B3 := $RigidBody2D/Butter/B3


var biscuits_sprite_c := []
var biscuits_sprite_b := []

var pick_sprite: Sprite2D

func _ready():
    randomize()
    biscuits_sprite_c = [C1, C2, C3]
    biscuits_sprite_b = [B1, B2, B3]

    for biscuit_sp in biscuits_sprite_c:
        biscuit_sp.visible = false

    for biscuit_sp in biscuits_sprite_b:
        biscuit_sp.visible = false

    get_tree().create_timer(1.75).timeout.connect(timer_out)

func timer_out():
    self.visible = false



func change_texture(biscuit_num: int ):
    match biscuit_num:
        0:
            pick_sprite = biscuits_sprite_c.pick_random()
            pick_sprite.visible = true

            add_to_group("Choco")

        1:
            pick_sprite = biscuits_sprite_b.pick_random()
            pick_sprite.visible = true
            add_to_group("Butter")
        _:
            print_debug("not_found_id")

    pick_sprite.rotation = randf_range(-180.0, 180.0)
