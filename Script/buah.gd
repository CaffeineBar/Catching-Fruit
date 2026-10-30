extends Area2D
class_name buah

signal game_selesai

@export var kecepatan: float = 80.0
@export var kecepatan_putar: float = 2.0

@onready var buah_animatedsprite2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 1. Hubungkan sinyal animation_finished ke fungsi kustom kita
	buah_animatedsprite2d.animation_finished.connect(animasi_selesai)
	# 2. Mainkan animasi idle cukup SEKALI di awal game
	buah_animatedsprite2d.play("idle fruit")

func _physics_process(delta: float) -> void:
	position.y += kecepatan * delta
	buah_animatedsprite2d.rotate(kecepatan_putar * delta)
	hapus_objek_offscreen()

func hapus_objek_offscreen() -> void:
	if position.y >= get_viewport_rect().end.y:
		print("Buah Jatuh")
		set_physics_process(false)
		buah_animatedsprite2d.play("hilang")
		game_selesai.emit()

func animasi_selesai() -> void:
	if buah_animatedsprite2d.animation == "hilang":
		queue_free()
