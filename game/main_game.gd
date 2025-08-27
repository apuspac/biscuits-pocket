extends Node2D


enum States {SETUP, CHOICE, RESOLVE, CARD}
var state: States = States.SETUP

var _phase_count: int
var phase_count:
    get:
        return _phase_count
    set(value):
        _phase_count = value
        _phase_label.update_count(phase_count)


var _biscuits_num: int
var biscuites_num:
    get:
        return _biscuits_num
    set(value):
        _biscuits_num = value
        _biscuits_label.update_count(_biscuits_num)

var _end_phase_num: int = 10




@onready var pockets_node = $Pockets
@onready var phase_label = $PhaseLabelDebug
@onready var _biscuits_label = $BiscuitsCount
@onready var _phase_label = $PhaseLabel

func _ready():
    # data_
    phase_count = 0

    PocketEvent.pocket_action_ready.connect(_resolve_start)
    PocketEvent.send_biscuits.connect(add_biscuits)

    _set_state(States.SETUP)

func _set_state(next_state: States) -> void:
    # print_debug(state, " -> ", next_state)
    state = next_state

    match state:
        States.SETUP:
            phase_label.text = "SETUP"
            _setup()
        States.CHOICE:
            phase_label.text = "CHOICE"
            _choice()
        States.RESOLVE:
            phase_label.text = "RESOLVE"
            _resolve_pockets()
        States.CARD:
            # additional
            phase_label.text = "CARD"
            _choice_card()


func _setup() -> void:
    phase_count += 1

    # ポケット追加処理
    await pockets_node.pocket_instantiate()

    _set_state(States.CHOICE)


func _choice() -> void:
    # ポケット選択処理 たたくか あけるか 全部終わったか記録
    # globalで通知しちゃうか。
    PocketEvent.emit_pocket_choice_enabled()

func _resolve_start() -> void:
    _set_state(States.RESOLVE)


func add_biscuits(num: int):
    biscuites_num += num


func biscuits_tally():
    # TODO: biscuits num update anim?
    await get_tree().create_timer(2.0).timeout



    _set_state(States.CARD)


func _resolve_pockets() -> void:
    pockets_node.exe_pocket_action()
    # next tally()



func _choice_card():
    # is game end?
    if phase_count >= _end_phase_num:
        phase_label.text = "CARD"
        print_debug("owari~~")
        # scene_ change
        return
    else:
        await get_tree().create_timer(2.0).timeout
        _set_state(States.SETUP)


func _update_ui():
    _phase_label.update_count(phase_count)
    # _biscuits_label.update_count()
