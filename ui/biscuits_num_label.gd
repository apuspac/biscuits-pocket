extends Control


@onready var _label  := $Label

func update_count(num: int):
    _label.text = str(num)
    # maybe anim??


func queue_free_effect():
    var tween = create_tween()
    tween.tween_property(self, "scale", Vector2(0.0, 0.0), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    await tween.finished
