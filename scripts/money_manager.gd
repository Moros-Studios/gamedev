extends Node
class_name MoneyManager

@export var starting_money: int = 800
var current_money: int

signal money_changed(amount: int)

func _ready():
	current_money = starting_money

func can_afford(amount: int) -> bool:
	return current_money >= amount

func spend_money(amount: int) -> bool:
	if can_afford(amount):
		current_money -= amount
		money_changed.emit(current_money)
		return true
	return false

func add_money(amount: int):
	current_money += amount
	money_changed.emit(current_money)
