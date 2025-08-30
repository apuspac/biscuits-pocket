extends Node2D

@onready var _area2d = $Area2D

@onready var _pic_pocket = $Pict/Pocket
@onready var _pic_biscuits = $Pict/Biscuits
@onready var _pic_hand = $Pict/Hand
@onready var _pic_card4 = $Pict/CardPict4


var card_type := []

var card_type_id: int = 0
var _is_selected: bool = false


func _ready():
    _area2d.area_left_clicked.connect(choice_card)
    # _area2d.area_mouse_overed.connect()
    PocketEvent.card_selected.connect(other_selected)

    card_type = [
        _pic_pocket,
        _pic_biscuits,
        _pic_hand,
        _pic_card4,
        _pic_card4,
        _pic_card4
    ]



func change_sprite(type_id: int):
    card_type_id = type_id
    card_type[type_id].visible = true

func other_selected(_card_type):
    if not _is_selected:
        var tween = create_tween()
        tween.tween_property(
            self,
            "scale",
            Vector2(0.0, 0.0),
            1.0
        ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func choice_card():
    _is_selected = true
    PocketEvent.emit_card_selected(card_type_id)
    AudioPlayer.play_SE("pi")

    var tween = create_tween()
    tween.tween_property(
        self,
        "scale",
        Vector2(1.2, 1.2),
       0.3
    ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

    tween.tween_property(
        self,
        "scale",
        Vector2(1.0, 1.0),
       0.3
    ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
