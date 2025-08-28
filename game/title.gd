extends Node2D


var main_game_scene_path := "res://game/main_game.tscn"

@onready var start_button = $Start

func _ready():
    start_button.pressed.connect(_push_start_button)


func _push_start_button():
    get_tree().change_scene_to_file(main_game_scene_path)