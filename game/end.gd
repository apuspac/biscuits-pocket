extends Node2D

var _biscuits_num := 0

@onready var _result_label = $PanelContainer/VBoxContainer/Result
@onready var _biscuits_label = $PanelContainer/VBoxContainer/BiscuitsCount
@onready var _title_button = $TitleButton
@onready var _title_scene_path = "res://game/title.tscn"
@onready var _clap = $Clap
@onready var _particle = $BiscuitParticle


func _ready():
    _biscuits_num = PocketEvent.result_biscuits_num
    _show_result()

    _title_button.pressed.connect(_push_title_button)
    _title_button.mouse_entered.connect(_play_enterd_se)

    var particle_amount

    if _biscuits_num > 75:
        particle_amount = 75
    if _biscuits_num <= 0:
        particle_amount = 1
    else:
        particle_amount = _biscuits_num

    _particle.change_amount(particle_amount)


func _show_result():
    _result_label.modulate.a = 0.0
    _biscuits_label.modulate.a = 0.0
    _particle.visible = false

    var tween = create_tween()
    tween.tween_property(_result_label, "modulate:a", 1.0, 0.1)
    _clap.play()

    await tween.finished

    await get_tree().create_timer(0.5).timeout

    _biscuits_label.text = "biscuits : " + str(_biscuits_num)

    var tween2 = create_tween()
    tween2.tween_property(_biscuits_label, "modulate:a", 1.0, 0.1)
    _clap.play()

    await tween2.finished

    await get_tree().create_timer(0.5).timeout
    _particle.visible = true
    AudioPlayer.play_SE("Cuckoo", -10.0)



func _push_title_button():
    await AudioPlayer.play_SE_wait("poco").finished
    # AudioPlayer.add_drum(4.0)
    get_tree().change_scene_to_file(_title_scene_path)


func _play_enterd_se():
    AudioPlayer.play_SE("po")
