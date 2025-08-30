extends Node2D


var card_scene := preload("res://card/card.tscn")

@onready var cards_node := $Cards


func _ready():
    _in_transition()
    _init_card()

    PocketEvent.card_selected.connect(_off_transition)


func _init_card():
    for i in range(1, 4):
        var card = card_scene.instantiate()
        cards_node.add_child(card)
        card.position = Vector2(320 * i, 328) + Vector2(-640, -328.0)
        card.change_sprite(randi_range(0, 5))

func _in_transition():
    var target_pos = self.position
    self.position += Vector2(1280, 0.0)

    var tween = create_tween()
    tween.tween_property(
        self,
        "position",
        target_pos,
        1.5
    ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _off_transition(_cart_type: int ):
    var target_pos = self.position + Vector2(-1280, 0.0)

    var tween = create_tween()
    tween.tween_property(
        self,
        "position",
        target_pos,
        1.5
    ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
