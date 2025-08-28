extends Camera2D

# NOTE できたらもっと スマホのフリック操作を実装
func _unhandled_input(event):
    if event is InputEventMouseMotion:
        if event.button_mask == MOUSE_BUTTON_LEFT:
            position -= event.relative
