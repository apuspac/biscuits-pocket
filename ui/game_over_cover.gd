extends Control


func _ready():
    self.visible = false





func game_over_transition(target_pos_y:  float) -> Tween:
    self.visible = true
    var target_pos = Vector2(640, target_pos_y)
    self.global_position = target_pos + Vector2(0.0, -720.0)

    var tween := create_tween()
    tween.tween_property(
        self,
        "global_position",
        target_pos,
        3.0
    ).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

    AudioPlayer.play_SE("Cuckoo", -10.0)

    return tween
