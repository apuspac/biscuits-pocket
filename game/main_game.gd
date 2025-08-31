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

var card_effect_array := []
var tmp_biscuits :int = 0

#### NOTE: end phase_num
var _end_phase_num: int = 20 + PocketEvent.additional_phase


var end_scene_path := "res://game/end.tscn"

@onready var pockets_node = $Pockets
@onready var phase_label = $PhaseLabelDebug
@onready var _biscuits_label = $BiscuitsCount
@onready var _phase_label = $PhaseLabel
@onready var _main_camera = $MainCamera2D
@onready var _gameover_cover = $GameOverCover
@onready var _card_effect = $CardEffect

var choice_card_scene := preload("res://card/choice_card.tscn")



# effects var
var additional_pockets :int = 0
var _first_phase_for7 :int = 0

func _ready():
    PocketEvent.init_game()
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
            phase_label.text = ""
            _setup()
        States.CHOICE:
            phase_label.text = "select \n  arrow (pickup) \n pockets (pat)"
            _choice()
        States.RESOLVE:
            phase_label.text = ""
            _resolve_pockets()
        States.CARD:
            # additional
            phase_label.text = ""
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

    for _i in range(0, additional_pockets):
        await pockets_node.pocket_instantiate()

    if phase_count == 10:
        AudioPlayer.add_drum(3.0)

    _set_state(States.CHOICE)


func _choice() -> void:
    # ポケット選択処理 たたくか あけるか 全部終わったか記録
    # globalで通知しちゃうか。
    PocketEvent.emit_pocket_choice_enabled()

## connect pocket choice ready
## すべての選択が終わって準備完了したら
func _resolve_start() -> void:
    tmp_biscuits = biscuits_num
    _set_state(States.RESOLVE)

## pocketのpat pickupを実行
func _resolve_pockets() -> void:
    pockets_node.exe_pocket_action()

# pickupしたpocketから加算される
func add_biscuits(num: int, _biscuit_color: int):
    tmp_biscuits += num


# 全部のactが終わったら。
func biscuits_tally():
    # card_effect test
    # _apply_card(9)

    # card_effect
    apply_effect_temporary()

    pockets_node.exe_tally_act()

    if not (biscuits_num == tmp_biscuits):
        biscuits_num = tmp_biscuits


## 毎回追加されると ぶちこわれちゃうやつは permanentlyへ
func apply_effect_temporary():

    var zero_flag := false
    for card in card_effect_array:
        match card :
            1: # biscuits  # biscuitsの個数が +5とかに
                if biscuits_num < tmp_biscuits:
                    tmp_biscuits += 5
            3: # 50%で+30 50%で -30
                var rand = randi_range(0,100)
                if rand > 50:
                    tmp_biscuits += 30
                else:
                    if (tmp_biscuits - 30) < 0:
                        tmp_biscuits = 0
                    else:
                        tmp_biscuits -= 30
            6: # 毎phase + (1~20)
                var rand = randi_range(1, 20)
                tmp_biscuits += rand
            7:  # phase数ごとに +3
                if _first_phase_for7 == 0:
                    _first_phase_for7 = phase_count
                else:
                    tmp_biscuits += 3 * (phase_count - _first_phase_for7)
            9: # 成功すると*2 失敗するとそのphase 0
                var rand = randi_range(0,100)
                if rand > 50:
                    tmp_biscuits = tmp_biscuits * 2
                else:
                    zero_flag = true
            10: # 75%で+10 25%で -5
                var rand = randi_range(0,100)
                if rand < 75:
                    tmp_biscuits += 10
                else:
                    tmp_biscuits -= 5
            _:
                pass

    if zero_flag:
        tmp_biscuits = 0



func apply_effect_permanently(card_type: int):
    match card_type :
        0: # pocket  追加されるポケットが2倍
            additional_pockets += 1
        1: # biscuits  # biscuitsの個数が + 5とかに
            card_effect_array.append(1)
        2: # hand patで増える最大値が+10に
            PocketEvent.additional_pat += 10
        3: # 50%で+30 50%で -30
            card_effect_array.append(3)
        4: # pocketの容量が +20
            PocketEvent.additional_capacity += 20
        5: # phase数 + 10
            PocketEvent.additional_phase += 10
            _end_phase_num = 20 + PocketEvent.additional_phase
        6: # 毎回 1~20加算
            card_effect_array.append(6)
        7:  # phase数ごとに +3
            card_effect_array.append(7)
        8:  # 初期で入っている個数が+5
            PocketEvent.init_biscuits += 5
        9: # 成功すると*2 失敗するとそのphase 0
            card_effect_array.append(9)
        10: # 75%で+10 25%で -5
            card_effect_array.append(10)





func tally_to_card():
    _set_state(States.CARD)


func _choice_card():
    # is game end?
    if phase_count >= _end_phase_num:
        phase_label.text = "END"

        # scene_ change
        await _gameover_cover.game_over_transition(_main_camera.global_position.y).finished

        PocketEvent.result_biscuits_num = biscuits_num
        get_tree().change_scene_to_file(end_scene_path)

    else:
        # 4の倍数で 20で終わりにしてみるとか。
        if (phase_count % 3) == 0 :
            var choice_cards = choice_card_scene.instantiate()
            choice_cards.global_position = Vector2(640, _main_camera.global_position.y)
            self.add_child(choice_cards)
        else:
            await get_tree().create_timer(1.0).timeout
            _set_state(States.SETUP)



func _apply_card(card_type: int):
    # print_debug("card_type ", card_type)
    _card_effect.add_effect(card_type)
    # card_effect_array.append(card_type)

    apply_effect_permanently(card_type)


    await get_tree().create_timer(1.0).timeout
    _set_state(States.SETUP)


func _update_ui():
    _phase_label.update_count(phase_count)
    # _biscuits_label.update_count()
