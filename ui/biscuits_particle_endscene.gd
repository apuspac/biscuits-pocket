extends Node2D


func change_amount(num: int):
    for _particle in get_children():
        _particle.amount = num


