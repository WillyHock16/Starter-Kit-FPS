extends Node

const PORT := 24565

var is_server := false

func _ready() -> void:
	pass  # se ejecuta al iniciar

# ---------- Servidor ----------
func start_host() -> void:
	var peer := ENetMultiplayerPeer.new()
	var error := peer.create_server(PORT, 8)  # hasta 8 jugadores
	if error == OK:
		multiplayer.multiplayer_peer = peer
		is_server = true
		print("Servidor LAN iniciado en el puerto %s" % PORT)
	else:
		push_error("No se pudo crear el servidor: %s" % error)

# ---------- Cliente ----------
func join_host(ip: String) -> void:
	var peer := ENetMultiplayerPeer.new()
	var error := peer.create_client(ip, PORT)
	if error == OK:
		multiplayer.multiplayer_peer = peer
		is_server = false
		print("Conectando a %s:%s…" % [ip, PORT])
	else:
		push_error("No se pudo conectar: %s" % error)

# ---------- Señales de conexión ----------
func _on_peer_connected(id: int) -> void:
	if is_server:
		print("Cliente %s conectado" % id)

func _on_peer_disconnected(id: int) -> void:
	if is_server:
		print("Cliente %s desconectado" % id)
