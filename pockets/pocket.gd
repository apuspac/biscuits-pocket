extends Node2D


signal pocket_choice_end

@onready var _pockets_area = $Area2D
@onready var _arrow_ui = $ArrowUI
@onready var _label = $BiscuitsLabel

var biscuits_num: int
var biscuits_limit: int = 10

enum ACT {PICKUP, PAT}
var next_operation: ACT = ACT.PAT

var is_choice_enable: bool = false




func _ready():
    # signals
    _pockets_area.area_left_clicked.connect(_choice_pat)
    _arrow_ui.arrow_left_clicked.connect(_choice_pickup)

    PocketEvent.pocket_choice_enabled.connect(_pocket_choice_start)

    switch_choice_ui(false)
    _label.visible = false

    # init_data
    biscuits_num = 0

func _pocket_choice_start() -> void:
    is_choice_enable = true
    switch_choice_ui(true)

func _pocket_choice_end() -> void:
    is_choice_enable = true
    switch_choice_ui(false)
    pocket_choice_end.emit()




func _choice_pat() -> void:
    if is_choice_enable:
        next_operation = ACT.PAT
        _pocket_choice_end()


func _choice_pickup() -> void:
    if is_choice_enable:
        next_operation = ACT.PICKUP
        _pocket_choice_end()


func act() -> void:
    match next_operation:
        ACT.PAT:
            await _pocket_pat()
        ACT.PICKUP:
            await _pocket_pickup()



func _pocket_pat() -> void:
    # act
    print_debug("clicked")
    biscuits_num += randi_range(1, 4)
    # TODO pat anim
    await get_tree().create_timer(1.0).timeout

    if biscuits_num > biscuits_limit:
        # TODO pockets break anim
        _label.text = str(biscuits_num)
        _label.visible = true
        queue_free()



func _pocket_pickup() -> void:
    #TODO: pickup anim
    _label.text = str(biscuits_num)
    _label.visible = true


    # ビスケットを集計 -> mainに
    PocketEvent.emit_send_biscuits(biscuits_num)

    await get_tree().create_timer(1.0).timeout


    #TODO: queue_free anim
    queue_free()

func switch_choice_ui(onoff: bool):
    _arrow_ui.visible = onoff
