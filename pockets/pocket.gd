extends Node2D


signal pocket_choice_end()

@onready var _pockets_area = $Area2D
@onready var _arrow_ui = $ArrowUI
@onready var _label = $BiscuitsLabel

var biscuits_num: int


enum ACT {PICKUP, PAT}
var next_operation: ACT = ACT.PAT

var is_choice_enable: bool = false

func _ready():
    # signals
    _pockets_area.area_left_clicked.connect(_pocket_pat)
    _arrow_ui.arrow_left_clicked.connect(_pocket_pickup)

    PocketEvent.pocket_choice_enabled.connect(_pocket_choice_start)

    switch_choice_ui(false)

    # init_data
    biscuits_num = 0

func _pocket_choice_start():
    is_choice_enable = true
    switch_choice_ui(true)

func _pocket_choice_end():
    is_choice_enable = true
    switch_choice_ui(false)
    pocket_choice_end.emit()


func switch_choice_ui(onoff: bool):
    _arrow_ui.visible = onoff


func pockets_open():
    print_debug(biscuits_num)
    _label.text = str(biscuits_num)
    _label.visible = true



func _pocket_pat():
    if is_choice_enable:
        print_debug("clicked")
        biscuits_num *= 2
        _pocket_choice_end()

    else:
        pass

func _pocket_pickup():
    if is_choice_enable:
        _pocket_choice_end()
    else:
        pass
