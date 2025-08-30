extends Control


@onready var _count_label  := $Label
var biscuits_count: int = 0

func _ready():
    biscuits_count = 0
    update_label(0)

func update_label(num:int):
    _count_label.text = "biscuits: " + str(num)

func count_up(num: int):
    var tween = create_tween()
    tween.tween_method(update_label, biscuits_count, num, 1.0)

    await tween.finished

    biscuits_count = num

func update_count(num: int):
    count_up(num)
