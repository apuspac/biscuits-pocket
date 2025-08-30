extends Node2D


@onready var _normal := $NormalPocket
@onready var _normal_animation := $NormalPocket/AnimationPlayer
@onready var _normal_hand = $NormalPocket/Hand
@onready var _normal_behindhand = $NormalPocket/BehindHand

@onready var _burst := $BurstPocket
@onready var _burst_animation := $BurstPocket/AnimationPlayer

var biscuits_rigidbody = preload("res://biscuits/biscuit_rigidbody.tscn")


func _ready():
    _normal.visible = true
    _burst.visible = false

    _normal_hand.visible = false
    _normal_behindhand.visible = false





func pat_play() -> void:
    _normal_animation.play("pat")

    await _normal_animation.animation_finished


func pickup_play():
    # とりあえずhandの動きだけ。 biscuitsは後。
    _normal_animation.play("pickup")
    await _normal_animation.animation_finished

func burst_play(biscuits_array: Array[int]):
    # ゆれ
    var tween = create_tween()
    tween.tween_property(
        _normal,
        "position",
        Vector2(0.0, 30.0),
        0.1
    ).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT_IN)


    tween.tween_property(
        _normal,
        "position",
        Vector2(0.0, 0.0),
        0.1
    ).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT_IN)

    await tween.finished

    _normal.visible = false
    _burst.visible = true

    for biscuits_type in biscuits_array:
        var biscuits_rigid = biscuits_rigidbody.instantiate()
        _burst.position = Vector2(randf_range(-100.0, 100.0), randf_range(-30.0, 10.0))
        _burst.add_child(biscuits_rigid)

        biscuits_rigid.change_texture(biscuits_type)
