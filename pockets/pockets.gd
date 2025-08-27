extends Node2D



var _pockets_scene_path := "res://pockets/pocket.tscn"

var _pockets_num : int = 0



## spaceing
var _spacing_x := 300
var _spacing_y := 300
var _start_x := 200
var _start_y := 440
var _pockets_row := 4

var _choice_end_pockets: int = 0

func _ready():
    PocketEvent.pocket_choice_enabled.connect(_prepare_tally)


func pocket_instantiate():



    var pocket = load(_pockets_scene_path).instantiate()
    pocket.position = _calc_pockets_pos()

    # TODO: ポケットの並び替えの処理ほしい
    # TODO: instantiate anim
    await get_tree().create_timer(2.0).timeout

    self.add_child(pocket)

    pocket.pocket_choice_end.connect(_tally_choices)
    _pockets_num += 1


func _prepare_tally():
    _choice_end_pockets = 0

func _tally_choices():
    _choice_end_pockets += 1

    # 全部のpokectsの選択が終わったら
    if _choice_end_pockets == get_child_count():
        # anim
        PocketEvent.emit_pocket_action_ready()

# pat pickupの処理実行
func exe_pocket_action():
    for pocket in get_children():
        await pocket.act()

    get_parent().biscuits_tally()


# ほんとはいい感じに spaceを変えたいね～
func _calc_pockets_pos() -> Vector2:
    var index := _pockets_num

    # match index:
    #     0:
    #         _start_x = 1280 / 2
    #         _spacing_x = 0
    #     1:
    #         _start_x = (1280 - 300) / 2
    #         _spacing_x = 300
    #     2:
    #         _start_x = (1280 - (2 * 250)) /2
    #         _spacing_x = 250
    #     _:
    #         _spacing_x = 300
    #         _start_x = 200



    var col = index %  _pockets_row
    var row = index / _pockets_row

    return Vector2(_start_x + _spacing_x * col, _start_y  + _spacing_y * row)
