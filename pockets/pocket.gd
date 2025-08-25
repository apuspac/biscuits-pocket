extends Node2D

@onready var _pockets_area = $Area2D
@onready var _arrow_ui = $ArrowUI
@onready var _label = $Label

var biscuits_num: int

func _ready():
    # signals
    _pockets_area.area_left_clicked.connect(pocket_pat)
    _arrow_ui.arrow_left_clicked.connect(pocket_pickup)

    # init_data
    biscuits_num = 0
    _label.visible = false

func pocket_pat():
    print_debug("clicked")
    biscuits_num += 1

func pocket_pickup():
    print_debug(biscuits_num)
    _label.text = str(biscuits_num)
    _label.visible = true
