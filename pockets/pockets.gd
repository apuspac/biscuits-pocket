extends Node2D



var _pockets_scene_path := "res://pockets/pocket.tscn"

var _pockets_num : int = 0

# space new
var _spacing :Vector2 = Vector2(300, 300)
var _init_pos: Vector2 = Vector2(200, 600)
var _pockets_cols = 4

var _choice_end_pockets: int = 0


func _ready():
    PocketEvent.pocket_choice_enabled.connect(_prepare_tally)


func position_update():
    # var pockets_col = 4 if get_child_count() > 4 else get_child_count()


    # print_debug(pockets_cols)

    for i in range(self.get_child_count()):
        var pocket = get_child(i)

        var row = i / _pockets_cols
        var col = i % _pockets_cols
        var target_pos = Vector2(_init_pos.x + (col * _spacing.x), _init_pos.y + (row * _spacing.y))

        var tween = create_tween()
        tween.tween_property(pocket, "position", target_pos, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)




func pocket_instantiate():

    var pocket = load(_pockets_scene_path).instantiate()
    pocket.position = _calc_pockets_pos()

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
    var i = get_child_count()

    var row = i / _pockets_cols
    var col = i % _pockets_cols
    var target_pos = Vector2(_init_pos.x + (col * _spacing.x), _init_pos.y + (row * _spacing.y))

    return target_pos
