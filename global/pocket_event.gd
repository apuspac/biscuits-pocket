extends Node


signal pocket_choice_enabled
signal pocket_choice_end

func emit_pocket_choice_enabled():
    pocket_choice_enabled.emit()


func emit_pocket_choice_end():
    pocket_choice_end.emit()