extends Node2D

@onready var pockets_area = $Area2D
@onready var arrow_ui = $ArrowUI
@onready var label = $Label

var biscuits_num: int

func _ready():
    # signals
    pockets_area.area_left_clicked.connect(pocket_pat)
    arrow_ui.arrow_left_clicked.connect(pocket_pickup)

    # init_data
    biscuits_num = 0
    label.visible = false

func pocket_pat():
    print_debug("clicked")
    biscuits_num += 1

func pocket_pickup():
    print_debug(biscuits_num)
    label.text = str(biscuits_num)
    label.visible = true
