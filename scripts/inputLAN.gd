extends Node

func _input(event):
	if event.is_action_pressed("ui_host"):
		Network.start_host()          # crea servidor
	elif event.is_action_pressed("ui_join"):
		# Cambia IP si pruebas en otra máquina
		Network.join_host("127.0.0.1")  # une al cliente local
