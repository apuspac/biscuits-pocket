extends Node2D


signal pocket_choice_end

@onready var _pockets_area = $Area2D
@onready var _arrow_ui = $ArrowUI
@onready var _label = $BiscuitsNumLabel
@onready var _pocket_sprite = $PocketSprite
@onready var _biscuits = $Biscuits

@onready var _biscuit_particle = $BiscuitButterParticle1



var biscuits_array :Array[int]
var biscuits_limit: int = 10

enum ACT {PICKUP, PAT}
var next_operation: ACT = ACT.PAT

var is_choice_enable: bool = false

func _ready():
    # signals
    _pockets_area.area_left_clicked.connect(_choice_pat)
    _arrow_ui.arrow_left_clicked.connect(_choice_pickup)

    PocketEvent.pocket_choice_enabled.connect(_pocket_choice_start)

    switch_choice_ui(false)
    _label.visible = false
    # _pocket_sprite.

    # init_data
    ## 初期で1個
    _add_biscuit()
    _pocket_sprite.scale = Vector2(0.0,0.0)

func _pocket_choice_start() -> void:
    is_choice_enable = true
    switch_choice_ui(true)

func _pocket_choice_end() -> void:
    is_choice_enable = false
    switch_choice_ui(false)
    pocket_choice_end.emit()





func _choice_pat() -> void:
    if is_choice_enable:
        next_operation = ACT.PAT
        _pocket_choice_end()


func _choice_pickup() -> void:
    if is_choice_enable:
        next_operation = ACT.PICKUP
        _pocket_choice_end()

## call pocket.gd
func act() -> void:
    match next_operation:
        ACT.PAT:
            await _pocket_pat()
        ACT.PICKUP:
            await _pocket_pickup()



func _pocket_pat() -> void:
    for i in randi_range(3, 6):
        _add_biscuit()

    await _pocket_sprite.pat_play()

    if biscuits_array.size() > biscuits_limit:

        await _pocket_sprite.burst_play(biscuits_array)

        _label.update_count(biscuits_array.size())
        _label.visible = true

        await get_tree().create_timer(2.0).timeout

        _label.queue_free_effect()
        await queue_free_effect()
        queue_free()



func _pocket_pickup() -> void:
    _biscuits.init_biscuits(biscuits_array)
    await _pocket_sprite.pickup_play()

    await _biscuits.pickup_biscuits().finished

    _label.update_count(biscuits_array.size())
    _label.visible = true

    # ビスケットを集計 -> mainに
    ## NOTE:カード効果をつけるなら globalで一気に集計させる。

   #####
    PocketEvent.emit_send_biscuits(biscuits_array.size())
    await _biscuits.tally_move_biscuits().finished


    await get_tree().create_timer(1.0).timeout

    _label.queue_free_effect()
    await queue_free_effect()
    queue_free()

func switch_choice_ui(onoff: bool):
    _arrow_ui.visible = onoff


func init_effect():
    var tween = create_tween()
    tween.tween_property(_pocket_sprite, "scale", Vector2(0.5, 0.5), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    # 微妙
    # _biscuit_particle.emitting = true

func queue_free_effect():
    var tween = create_tween()
    tween.tween_property(_pocket_sprite, "scale", Vector2(0.0, 0.0), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    await tween.finished


func _add_biscuit() -> void:
    biscuits_array.append(randi_range(0,1))
