extends Node2D

@onready var _badges_node = $CardEffectBadges

var _badge := preload("res://card/card_effect_badge.tscn")
var _badge_num :int = 0

func _ready():
    pass

func add_effect(effect_id: int):
    var badge = _badge.instantiate()
    _badges_node.add_child(badge)
    badge.position = Vector2(100.0 * _badge_num, 0.0)

    badge.change_sprite(effect_id)
    _badge_num += 1