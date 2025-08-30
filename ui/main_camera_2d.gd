extends Camera2D

# できたらもっと スマホのフリック操作を実装
# むり！
func _unhandled_input(event):
    if event is InputEventMouseMotion:
        if event.button_mask == MOUSE_BUTTON_LEFT:
            position -= event.relative

func first_transition() -> Tween:
    self.global_position = Vector2(640, -392)

    var tween = create_tween()
    tween.tween_property(
        self,
        "global_position",
        Vector2(640, 360),
        3.0
    ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

    return tween
