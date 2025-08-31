extends Node


signal pocket_choice_enabled
signal pocket_action_ready
signal send_biscuits(num: int, _color_type: int)
signal card_selected(card_type: int)

var additional_pat:int = 0
var additional_capacity:int = 0
var additional_phase :int = 0
var init_biscuits :int = 0

var result_biscuits_num :int :
    get:
        return result_biscuits_num
    set(value):
        result_biscuits_num = value


func emit_pocket_choice_enabled():
    pocket_choice_enabled.emit()

func emit_pocket_action_ready():
    pocket_action_ready.emit()

func emit_send_biscuits(_num:int, _color_type: int):
    send_biscuits.emit(_num, _color_type)

func emit_card_selected(_card_type: int):
    card_selected.emit(_card_type)
