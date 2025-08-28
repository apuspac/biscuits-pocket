extends Node2D

var biscuits_num := 0

@onready var biscuits_label = $BiscuitsCount

func _ready():
    biscuits_num = PocketEvent.result_biscuits_num
    biscuits_label.update_count(biscuits_num)

