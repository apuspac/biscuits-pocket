extends Node2D


@onready var C1 := $Choco/C1
@onready var C2 := $Choco/C2
@onready var C3 := $Choco/C3
@onready var B1 := $Butter/B1
@onready var B2 := $Butter/B2
@onready var B3 := $Butter/B3


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


func change_texture(biscuit_num: int ):
    var rnd: int
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
            rnd = 0

    pick_sprite.rotation = randf_range(-180.0, 180.0)
