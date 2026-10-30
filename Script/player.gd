extends Area2D
class_name Pemain

signal dapat_skor

@export var kecepatan: float = 200.0

@onready var animasi_karakter: AnimatedSprite2D = $AnimatedSprite2D
@onready var ambil_buah: AudioStreamPlayer2D = $AmbilBuah

var hadap_kanan: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animasi_karakter.play("idle")

func _physics_process(delta: float) -> void:
	var jalan = Input.get_axis("ui_left", "ui_right")
	
	if !is_zero_approx(jalan):
		animasi_karakter.flip_h = jalan < 0.0
		animasi_karakter.play("run")
	else:
		animasi_karakter.play("idle")
	
	position.x += delta * jalan * kecepatan
	position.x = clamp(position.x, get_viewport_rect().position.x, get_viewport_rect().end.x)

func flip() -> void:
	hadap_kanan = !hadap_kanan
	scale.x *= -1

func _on_area_entered(area: Area2D) -> void:
	if area is buah:
		ambil_buah.play()
		area.queue_free()
		dapat_skor.emit()
