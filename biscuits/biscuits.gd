extends Node2D


var biscuit_scene := preload("res://biscuits/biscuit.tscn")

func _ready():
    pass


func _process(delta):
    pass


func init_biscuits(biscuits_array: Array[int]):
    # instantiate
    for biscuit_type in biscuits_array:
        var biscuit = biscuit_scene.instantiate()
        add_child(biscuit)
        biscuit.change_texture(biscuit_type)
        biscuit.position += Vector2(randi_range(-50, 50), randi_range(-25, 25))

func pickup_biscuits() -> Tween:
    var last_tween: Tween
    for biscuit in self.get_children():
        # biscuit.position += Vector2(0.0, -100.0)

        var tween = create_tween()
        tween.tween_property(
            biscuit,
            "position",
            biscuit.position + Vector2(0.0, -200.0),
            0.5
        ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        last_tween = tween

    return last_tween




func _tally():
    pass
    # choco限定で呼び出すときとか。
    # get_tree().call_group("Choco", "func", "arg")
