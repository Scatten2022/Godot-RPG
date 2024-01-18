class_name Enemy
extends CharacterBody2D

@onready var graphics: Node2D = $Graphics
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var stats: Stats = $Stats
@onready var float_damage_position: Marker2D = $FloatDamagePosition
@onready var float_damage_player: Node = $FloatDamagePlayer
