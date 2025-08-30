extends Node2D


var main_game_scene_path := "res://game/main_game.tscn"


@onready var start_button = $Start

func _ready():
    start_button.pressed.connect(_push_start_button)
    start_button.mouse_entered.connect(_play_enterd_se)




func _push_start_button():
    await AudioPlayer.play_SE_wait("poco").finished
    # AudioPlayer.add_drum(4.0)
    get_tree().change_scene_to_file(main_game_scene_path)

func _play_enterd_se():
    AudioPlayer.play_SE("po")
