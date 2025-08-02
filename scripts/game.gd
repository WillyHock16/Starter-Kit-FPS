extends Node
@onready var player_scene := preload("res://objects/player.tscn")

func _ready() -> void:
	if Network.is_server:
		spawn_player(multiplayer.get_unique_id(), Vector3(0,1,0))

func _on_peer_connected(id: int) -> void:
	if Network.is_server:
		spawn_player.rpc(id, Vector3(0,1,0))

@rpc("authority")
func spawn_player(id: int, pos: Vector3) -> void:
	var p := player_scene.instantiate()
	p.name = "player_%s" % id
	get_tree().current_scene.add_child(p)
	p.global_position = pos
