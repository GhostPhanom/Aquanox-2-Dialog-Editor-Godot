extends Control

var currentroom = null
@export var master_volume_moifier = -12.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func LoadDialogTree(stakeWAV):
	for i in stakeWAV.size():
		if FileAccess.file_exists(stakeWAV[i]):
			$DialogAudio.stream = AudioStreamOggVorbis.load_from_file(stakeWAV[i])
			$DialogAudio.volume_db = master_volume_moifier
			$DialogAudio.play()
		while($DialogAudio.playing):
			await get_tree().create_timer(0,03).timeout

func LoadDialogRoomTree(stakeWAV, roomWAV):
	#print(roomWAV)
	match roomWAV:
		"gui\\gui_station_atacama\\sound\\bridge.sam":
			currentroom = $atacama_bedlam
		"gui\\gui_station_atacama\\sound\\plazaelninho.sam":
			currentroom = $atacama_plazaelninho
		"gui\\gui_station_atacama\\sound\\salpetretavern.sam":
			currentroom = $atacama_salpetretavern
		"gui\\gui_station_eltopo\\sound\\eltopooffice.sam":
			currentroom = $eltopo_eltopooffice
		"gui\\gui_station_eltopo\\sound\\thalasso.sam":
			currentroom = $eltopo_thalasso
		"gui\\gui_station_harvester\\sound\\bridge.sam":
			currentroom = $harvester_bridge
		"gui\\gui_station_harvester\\sound\\crewsquarters.sam":
			currentroom = $harvester_crewsquarters
		"gui\\gui_station_harvester\\sound\\mess.sam":
			currentroom = $harvester_mess
		"gui\\gui_station_harvester\\sound\\trashsluice.sam":
			currentroom = $harvester_trashsluice
		"gui\\gui_station_neopolis\\sound\\concordia.sam":
			currentroom = $neopolis_concordia
		"gui\\gui_station_neopolis\\sound\\museumofmodern.sam":
			currentroom = $neopolis_museumofmodern
		"gui\\gui_station_neopolis\\sound\\neopolisarms.sam":
			currentroom = $neopolis_neopolisarms
	if currentroom != null:
		currentroom.volume_db = -12.0 + master_volume_moifier
		currentroom.play()
	for i in stakeWAV.size():
		if FileAccess.file_exists(stakeWAV[i]):
			$DialogAudio.stream = AudioStreamOggVorbis.load_from_file(stakeWAV[i])
			$DialogAudio.volume_db = master_volume_moifier
			$DialogAudio.play()
		while($DialogAudio.playing):
			await get_tree().create_timer(0,03).timeout
	if currentroom != null:
		currentroom.stop()
	

func StopSound():
	if currentroom != null:
		currentroom.stop()
	$DialogAudio.stop()
	$DialogRoomAudio.stop()
