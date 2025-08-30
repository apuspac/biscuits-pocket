extends Control

@onready var _count_label  := $Label
@onready var _kati = $Kati
var phase_count: int = 0

func _ready():
    phase_count = 0
    update_label(phase_count)

func update_label(num :int):
    _count_label.text = "phase: " + str(num)



func count_up(num: int):
    var tween = create_tween()

    tween.parallel().tween_method(update_label, phase_count, num, 1.0)
    await get_tree().create_timer(0.5).timeout
    _kati.play()


    await tween.finished


    phase_count = num


func update_count(num: int):
    count_up(num)


