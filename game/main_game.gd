extends Node2D


enum States {SETUP, CHOICE, RESULT, CARD}
var state: States = States.SETUP

var _phase_count: int = 1



func _ready():
    _phase_count = 1

func set_state(next_state: States):
    state = next_state

    match state:
        States.SETUP:
            setup()
        States.CHOICE:
            pass
        States.RESULT:
            pass
        States.CARD:
            # additional
            pass

func setup():
    pass
    # ポケット追加処理
    # instantiateうんぬん

