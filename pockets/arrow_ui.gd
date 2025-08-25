extends Node2D

signal arrow_left_clicked
@onready var _arrow_area = $Area2D

func _ready():
    _arrow_area.area_left_clicked.connect(arrow_clicked)

func arrow_clicked():
    arrow_left_clicked.emit()