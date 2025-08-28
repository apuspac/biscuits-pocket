extends Node


signal pocket_choice_enabled
signal pocket_action_ready
signal send_biscuits(num:int)

var result_biscuits_num :int :
    get:
        return result_biscuits_num
    set(value):
        result_biscuits_num = value


func emit_pocket_choice_enabled():
    pocket_choice_enabled.emit()

func emit_pocket_action_ready():
    pocket_action_ready.emit()

func emit_send_biscuits(_num:int):
    send_biscuits.emit(_num)
