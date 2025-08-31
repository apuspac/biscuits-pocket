extends Node2D


var main_game_scene_path := "res://game/main_game.tscn"
var how_to_play_scene_path := "res://ui/howtoplay.tscn"


@onready var start_button = $Start
@onready var how_to_play_button = $HowToPlay
@onready var how_to_play_scene = $HowToPlayScreen
@onready var how_to_play_exit_button = $HowToPlayScreen/Close

func _ready():
    how_to_play_scene.visible = false
    start_button.pressed.connect(_push_start_button)
    start_button.mouse_entered.connect(_play_enterd_se)
    how_to_play_button.pressed.connect(_push_howtoplay)
    how_to_play_button.mouse_entered.connect(_play_enterd_se)

    how_to_play_exit_button.pressed.connect(close_howtoplay)




func _push_start_button():
    await AudioPlayer.play_SE_wait("poco").finished
    # AudioPlayer.add_drum(4.0)
    get_tree().change_scene_to_file(main_game_scene_path)

func _push_howtoplay():
    await AudioPlayer.play_SE_wait("poco").finished
    how_to_play_scene.visible = true

func close_howtoplay():
    how_to_play_scene.visible = false



func _play_enterd_se():
    AudioPlayer.play_SE("po")
