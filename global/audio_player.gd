extends Node

var SE =  {
    "burst":    "res://assets/se/ClapBurst2.wav", #burst
    "po":       "res://assets/se/cursor-po.wav", # 選択音
    "poco":     "res://assets/se/Perc372.wav", # 決定音
    "pe":       "res://assets/se/cursor-pe.wav",
    "pi":       "res://assets/se/cursor-pi.wav",
    "ren":      "res://assets/se/cursor-ren.wav",
    "kati":     "res://assets/se/cursor-kati.wav",
    "clap":     "res://assets/se/Clap052.wav", # ????
    "shake":     "res://assets/se/SHAKER.wav", # pickup
    "Cuckoo":   "res://assets/se/Cuckoo2.wav"  # game over
}

@onready var _lead = $Lead
@onready var _drum = $Drum



func _ready():
    _lead.play()
    _drum.play()

    _drum.volume_db = -80.0


func add_drum(fade_in_time: float = 1.0):
    if is_equal_approx(_drum.volume_db, -80.0):
        create_tween().tween_property(_drum, "volume_db", 0.0, fade_in_time)


func play_SE(sound_wav: String, db: float = 0.0):
    var se = AudioStreamPlayer.new()
    se.stream = load(SE[sound_wav])
    se.volume_db = db

    get_tree().root.add_child(se)
    se.play()

    await se.finished
    se.queue_free()

func play_SE_wait(sound_wav: String) -> AudioStreamPlayer:
    var se = AudioStreamPlayer.new()
    se.stream = load(SE[sound_wav])

    get_tree().root.add_child(se)
    se.play()

    return se




# @onready var _bgm1= $BGM
# @onready var _bgm2= $BGM2
# @onready var _bgm3= $BGM3


# びみょう
# func change_bgm_1_2():
#     _bgm2.volume_db = -30.0
#     _bgm2.play()

#     var tween = create_tween()

#     tween.parallel().tween_property(_bgm1, "volume_db", -30.0, 3.0)
#     tween.parallel().tween_property(_bgm2, "volume_db", 0.0, 3.0)
#     await tween.finished

# びみょう
# func change_bgm_2_3():
#     _bgm3.volume_db = -80.0
#     _bgm3.play()
#     var tween = create_tween()
#     tween.parallel().tween_property(_bgm2, "volume_db", -80.0, 3.0)
#     tween.parallel().tween_property(_bgm3, "volume_db", 0.0, 3.0)
#     tween.tween_callback(_bgm2.stop)