extends Node2D


@onready var pockets_area = $Area2D
@onready var arrow_ui = $ArrowUI

var biscuits_num: int

func _ready():
    pockets_area.area_left_clicked.connect(pocket_pat)
    arrow_ui.arrow_left_clicked.connect(pocket_open)
    biscuits_num = 0



func _process(delta):
    pass


func pocket_pat():
    print_debug("clicked")
    biscuits_num += 1

func pocket_open():
    print_debug(biscuits_num)

