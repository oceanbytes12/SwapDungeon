extends Node
class_name State

signal Transitioned


func Enter(_target):
	pass


func Exit():
	pass


func Update(_delta: float, _target: CharacterBody2D):
	pass


func Physics_Update(_delta: float, _target: CharacterBody2D):
	pass
