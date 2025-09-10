extends Control

@onready var _progress_bar  := $TextureProgressBar
@onready var _se_popopo := $SE_Popopo
@onready var _se_po := $SE_Po
var biscuits_count: int = 0
var biscuits_scale: int = 0
var init_scale :int = 0.25
var stage_goal: int = 1000

func _ready():
    biscuits_count = 0
    update_bar(0)
    self.scale = Vector2(0.0, 0.0)
    await get_tree().create_timer(3.0).timeout
    _init_effect()

func _init_effect():
    var tween = create_tween()
    tween.tween_property(self, "scale", Vector2(init_scale, init_scale), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _update_scale() -> Tween:
    var tween = create_tween()
    tween.tween_property(
        self,
        "scale",
        Vector2(
            init_scale + 0.025 * biscuits_scale,
            init_scale + 0.025 * biscuits_scale
        ),
        0.1
    ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

    print_debug(init_scale + 0.025 * biscuits_scale)
    return tween




func update_bar(num:int):
    _progress_bar.value = num

# TODO: 逆の処理どうする？
    if _progress_bar.value == 100:
        biscuits_scale += 1
        await _update_scale().finished
        _progress_bar.value = 0


func count_up(num: int):
    if num > 2:
        var tween = create_tween()
        tween.tween_method(update_bar, biscuits_count, num, 1.0)

        await get_tree().create_timer(0.3).timeout
        # _se_popopo.play()

        await tween.finished
        # _se_popopo.stop()
    else:
        var tween = create_tween()
        tween.tween_method(update_bar, biscuits_count, num, 1.0)
        await tween.finished

        # _se_po.play()


    biscuits_count = num

func update_progress_bar(num: int):
    count_up(num)
