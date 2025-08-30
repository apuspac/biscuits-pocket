extends Control


@onready var _count_label  := $Label
@onready var _se_popopo := $SE_Popopo
@onready var _se_po := $SE_Po
var biscuits_count: int = 0

func _ready():
    biscuits_count = 0
    update_label(0)

func update_label(num:int):
    _count_label.text = "biscuits: " + str(num)

func count_up(num: int):
    if num > 2:
        var tween = create_tween()
        tween.tween_method(update_label, biscuits_count, num, 1.0)

        await get_tree().create_timer(0.3).timeout
        _se_popopo.play()

        await tween.finished
        _se_popopo.stop()
    else:
        var tween = create_tween()
        tween.tween_method(update_label, biscuits_count, num, 1.0)
        await tween.finished

        _se_po.play()


    biscuits_count = num

func update_count(num: int):
    count_up(num)
