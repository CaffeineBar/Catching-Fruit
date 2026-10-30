extends Node2D

const BUAH = preload("res://Scenes/buah.tscn")
const MARGIN = 110.0

@onready var spawn_timer: Timer = $Pausable/SpawnTimer
@onready var label: Label = $Label
@onready var pausable: Node = $Pausable

var skor

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skor = 0
	label.text = "SKOR: 0"
	
	spawn_buah_acak()

func spawn_buah_acak() -> void:
	var buah_baru: buah = BUAH.instantiate()	
	var ukuran_screen = get_viewport_rect()
	var range_x = randf_range(ukuran_screen.position.x + MARGIN, ukuran_screen.end.x - MARGIN)
	buah_baru.position = Vector2(range_x, -MARGIN)
	buah_baru.game_selesai.connect(_on_area_2d_game_selesai)
	pausable.add_child(buah_baru)

func kalah() -> void:
	spawn_timer.stop()
	var freeze = get_tree().get_nodes_in_group("berhenti")
	for item in freeze:
		item.set_physics_process(false)

func _on_area_2d_game_selesai() -> void:
	print("Kamu Kalah")
	kalah()

func _on_spawn_timer_timeout() -> void:
	spawn_buah_acak()

func _on_player_dapat_skor() -> void:
	print("dapat point")
	skor += 1
	label.text = "SKOR: " + str(skor)
