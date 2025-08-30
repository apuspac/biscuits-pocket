extends Node2D


@onready var _normal := $NormalPocket
@onready var _normal_animation := $NormalPocket/AnimationPlayer
@onready var _normal_hand = $NormalPocket/Hand
@onready var _normal_behindhand = $NormalPocket/BehindHand

@onready var _burst := $BurstPocket
@onready var _burst_animation := $BurstPocket/AnimationPlayer


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

func burst_play():
    get_tree().create_timer(1.0).timeout
    # print_debug("burst はよ つくろ！！")
    # _normal_animation.play("pickup")
