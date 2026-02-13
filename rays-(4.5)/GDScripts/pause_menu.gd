extends CanvasLayer

func _ready() -> void:
	# Denne gjør at Pause Menuen altid kjører uansett om get_tree().paused = true.
	process_mode = Node.PROCESS_MODE_ALWAYS
	#Visible = false gjør at denne scene ikke vises, og get_tree().paused = false gjør at spillet ikke er satt på pause og skal fortsatt kjør som normalt. 
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	#Sjekker om "ui_cancel" er trykket altså Esc knappen.
	if event.is_action_pressed("ui_cancel"):
		#Sjekker om get_tree.paused er true, og hvis Esc knappen er trykket så skal Pause Menuen bli skult og spille skal ikke vøære på pause lengre.
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		#Hvis spille ikke er paused og Esc er trykke så skal Pause Mneuen vises og Spillet skal bli satt på pause.
		else:
			visible = true
			get_tree().paused = true
			
#Kobler Return to game knappen til Pause menue som gjøre at hvis Pause Menyen er åpen og denne knappen blir trykket så skal Pause menyen bli skult og spillet skal ikke være på pause lengre.
func _on_return_to_game_pressed() -> void:
	visible = false
	get_tree().paused = false
	#For å sjekke om Knappen funket
	print("Return")

#Kobler Restart knappen til Pause menyen som gjør at Scene skal starte på nytt fra starten av og pause menyen går vekk.
func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	#For å sjekke om Knappen funket
	print("Restart")
	
#Kobler QuitToMainMenu knappen til Pause menyen som gjør at Pause Menyen blir skult og at spillet går av pause. Så går den til Main Menu scenen.
func _on_quit_to_main_menu_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	#For å sjekke om Knappen funket
	print("Quit To Main Meny")
