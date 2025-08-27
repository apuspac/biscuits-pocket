extends Control


@onready var _count_label  := $Label
var biscuits_count: int = 0

func _ready():
    biscuits_count = 0
    update_label()

func update_label():
    _count_label.text = "biscuits: " + str(biscuits_count)


func update_count(num: int):
    # TODO:update anim?
    biscuits_count = num
    update_label()
