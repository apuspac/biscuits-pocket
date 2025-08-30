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
var biscuits_num:
    get:
        return _biscuits_num
    set(value):
        _biscuits_num = value
        _biscuits_label.update_count(_biscuits_num)

var card_ability := []

#### NOTE: end phase_num
var _end_phase_num: int = 10


var end_scene_path := "res://game/end.tscn"

@onready var pockets_node = $Pockets
@onready var phase_label = $PhaseLabelDebug
@onready var _biscuits_label = $BiscuitsCount
@onready var _phase_label = $PhaseLabel
@onready var _main_camera = $MainCamera2D
@onready var _gameover_cover = $GameOverCover

var choice_card_scene := preload("res://card/choice_card.tscn")



func _ready():
    # data_
    phase_count = 0

    PocketEvent.pocket_action_ready.connect(_resolve_start)
    PocketEvent.send_biscuits.connect(add_biscuits)
    PocketEvent.card_selected.connect(_apply_card)

    await _main_camera.first_transition().finished

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

    # update pockets pos
    var last_tween = pockets_node.position_update()
    # 1個の場合はnullが帰ってくるので、弾く。
    if last_tween:
        await last_tween.finished

    # add pockets
    await pockets_node.pocket_instantiate()

    if phase_count == 5:
        AudioPlayer.add_drum(3.0)

    _set_state(States.CHOICE)


func _choice() -> void:
    # ポケット選択処理 たたくか あけるか 全部終わったか記録
    # globalで通知しちゃうか。
    PocketEvent.emit_pocket_choice_enabled()

## connect pocket choice ready
## すべての選択が終わって準備完了したら
func _resolve_start() -> void:
    _set_state(States.RESOLVE)

func _resolve_pockets() -> void:
    pockets_node.exe_pocket_action()
    # next tally()

func add_biscuits(num: int):
    biscuits_num += num


func biscuits_tally():
    # TODO: biscuits num update anim?
    await get_tree().create_timer(2.0).timeout

    _set_state(States.CARD)



func _choice_card():
    # is game end?
    if phase_count >= _end_phase_num:
        phase_label.text = "END"

        # scene_ change
        await _gameover_cover.game_over_transition(_main_camera.global_position).finished

        PocketEvent.result_biscuits_num = biscuits_num
        get_tree().change_scene_to_file(end_scene_path)

    else:
        var choice_cards = choice_card_scene.instantiate()
        choice_cards.global_position = _main_camera.global_position
        self.add_child(choice_cards)


func _apply_card(card_type: int):
    await get_tree().create_timer(1.0).timeout
    print_debug("card_type ", card_type)
    card_ability.append(card_type)
    _set_state(States.SETUP)


func _update_ui():
    _phase_label.update_count(phase_count)
    # _biscuits_label.update_count()
