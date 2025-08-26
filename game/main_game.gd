extends Node2D


enum States {SETUP, CHOICE, RESOLVE, CARD}
var state: States = States.SETUP

var _phase_count: int = 1
var _end_phase_num: int = 10



@onready var pockets_node = $Pockets

func _ready():
    # data_
    _phase_count = 1

    PocketEvent.pocket_choice_end.connect(_resolve_start)

    _set_state(States.SETUP)

func _set_state(next_state: States) -> void:
    print_debug(state, " -> ", next_state)
    state = next_state


    match state:
        States.SETUP:
            _setup()
        States.CHOICE:
            _choice()
        States.RESOLVE:
            _resolve_pockets()
        States.CARD:
            # additional
            _choice_card()


func _setup() -> void:
    # ポケット追加処理
    pockets_node.pocket_instantiate()
    pockets_node.pocket_instantiate()
    pockets_node.pocket_instantiate()
    _set_state(States.CHOICE)


func _choice() -> void:
    # ポケット選択処理 たたくか あけるか 全部終わったか記録
    # globalで通知しちゃうか。
    PocketEvent.emit_pocket_choice_enabled()

func _resolve_start() -> void:
    _set_state(States.RESOLVE)

func _resolve_pockets() -> void:
    pass

    # 各ポケットを 選択した処理発火

    # _set_state(States.CARD)

func _choice_card():
    # is game end?
    if _phase_count > _end_phase_num:
        print_debug("owari~~")
    else:
        _set_state(States.SETUP)

