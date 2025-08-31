extends Node2D

@onready var base = $Base
@onready var _batch_0 = $Batch0
@onready var _batch_1 = $Batch1
@onready var _batch_2 = $Batch2
@onready var _batch_3 = $Batch3
@onready var _batch_4 = $Batch4
@onready var _batch_5 = $Batch5
@onready var _batch_6 = $Batch6
@onready var _batch_7 = $Batch7
@onready var _batch_8 = $Batch8
@onready var _batch_9 = $Batch9
@onready var _batch_10 = $Batch10

@onready var area2d = $Area2D

@onready var _label = $Label

var batch_type = []
var card_type_id: int


var card_label := [
        "Pocket +2x",
        "+5 Biscuits \n when collected",
        "Pat Bonus \n Max +10",
        "50%: +30 \n 50%: -30",
        "Pocket Size \n 10 → 30",
        "+10 Phases",
        "Random +1~20 \n Each Time",
        "+3 per phase",
        "Init biscuits \n +5",
        "Success: ×2 \n Fail: 0 This phase",
        "75%: +10 \n 25%: -5",
    ]


func _ready():
    batch_type = [
        _batch_0,
        _batch_1,
        _batch_2,
        _batch_3,
        _batch_4,
        _batch_5,
        _batch_6,
        _batch_7,
        _batch_8,
        _batch_9,
        _batch_10,
    ]
    area2d.area_mouse_overed.connect(_explain)
    _label.visible = false

func _explain(over: bool):
    if over:
        _label.visible = true
    else:
        _label.visible = false




func change_sprite(type_id: int):
    card_type_id = type_id
    batch_type[type_id].visible = true
    base.visible = true
    _label.text = card_label[card_type_id]
