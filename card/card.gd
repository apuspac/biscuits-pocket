extends Node2D

@onready var _area2d = $Area2D

@onready var _card0 = $Pict/Card0
@onready var _card1 = $Pict/Card1
@onready var _card2 = $Pict/Card2
@onready var _card3 = $Pict/Card3
@onready var _card4 = $Pict/Card4
@onready var _card5 = $Pict/Card5
@onready var _card6 = $Pict/Card6
@onready var _card7 = $Pict/Card7
@onready var _card8 = $Pict/Card8
@onready var _card9 = $Pict/Card9
@onready var _card10 = $Pict/Card10

@onready var _label = $CardLabel


var card_type := []

var card_type_id: int = 0
var _is_selected: bool = false

var card_label := [
        "Pocket +2",
        "+5 Biscuits \n when collected",
        "Pat Bonus \n Max +10",
        "50% +30 \n 50%: -30",
        "Pocket Size \n +20",
        "+10 Phases",
        "Random +1~20 \n Each Time",
        "+3 per phase",
        "Init biscuits \n +5",
        "Success: x2 \n Fail: 0 This phase",
        "75%: +10 \n 25%: -5",
    ]

func _ready():
    _area2d.area_left_clicked.connect(choice_card)
    # _area2d.area_mouse_overed.connect()
    PocketEvent.card_selected.connect(other_selected)

    card_type = [
        _card0,
        _card1,
        _card2,
        _card3,
        _card4,
        _card5,
        _card6,
        _card7,
        _card8,
        _card9,
        _card10,
    ]

    _label.text = ""


func change_sprite(type_id: int):
    card_type_id = type_id
    card_type[type_id].visible = true
    _label.text =  card_label[type_id]


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
