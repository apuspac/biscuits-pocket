extends Control

@onready var _count_label  := $Label
var phase_count: int = 0

func _ready():
    phase_count = 0
    update_label()

func update_label():
    _count_label.text = "phase: " + str(phase_count)


func update_count(num: int):
    # TODO:update anim?
    phase_count = num
    update_label()
