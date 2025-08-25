extends Area2D

signal area_left_clicked
signal area_right_clicked
signal area_mouse_overed(is_mouse_over: bool)

var _is_mouse_over: bool = false

func _ready():
    mouse_entered.connect(_mouse_over)
    mouse_exited.connect(_mouse_over)

func _input_event(_viewport, event, _shape_idx):
    ## Area範囲内をclickしたら
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
            area_left_clicked.emit()
        elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
            area_right_clicked.emit()


func _mouse_over():
    _is_mouse_over = not _is_mouse_over
    area_mouse_overed.emit(_is_mouse_over)