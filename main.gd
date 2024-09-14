extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$MainHUD.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_hud_start_processing() -> void:
	$FileOperation.LoadFiles()
	$MainHUD.show()
	#PlayDialog(173)
	print_debug($MainHUD/Tabs/stake_hud.main_data_object)
	$MainHUD/Tabs/stake_hud.main_data_object = $FileOperation
	print_debug($MainHUD/Tabs/stake_hud.main_data_object)
	$MainHUD/Tabs/stake_hud.Initialize()
	$MainHUD/Tabs/dialog_hud.main_data_object = $FileOperation
	$MainHUD/Tabs/dialog_hud.Initialize()
	$MainHUD/Tabs/mtake_hud.main_data_object = $FileOperation
	$MainHUD/Tabs/mtake_hud.Initialize()
	$MainHUD/Tabs/person_hud.main_data_object = $FileOperation
	$MainHUD/Tabs/person_hud.Initialize()

func PlayDialog(dialogid):
	var stake_list = $FileOperation.stakelist.GetDialogeStakeEntrys(dialogid)
	var room = $FileOperation.roomlist.GetObjectwithKey($FileOperation.sdialoglist.GetObjectwithKey(dialogid).Room)
	
	for stake in stake_list:
		$DialogSound.stream = AudioStreamOggVorbis.load_from_file(stake.WavPath)
		$DialogSound.play()
		while($DialogSound.playing):
			await get_tree().create_timer(0.33).timeout
