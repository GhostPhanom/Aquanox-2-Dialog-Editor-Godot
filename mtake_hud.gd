extends Control

var main_data_object
var current_mtake_list = []
var current_mtake_dict = {}

var current_mtake_object

var dialog_preview_scene
var current_dialog_preview_instance = null

var preview_sound_generated = false
var preview_sound_volume = ""

var person_filter = 0

var missionlist = [
	"mtake_1h1",
	"mtake_1h2",
	"mtake_1h3",
	"mtake_1h4",
	"mtake_1h5",
	"mtake_1n1",
	"mtake_1n2",
	"mtake_2b1",
	"mtake_2h1",
	"mtake_2h2",
	"mtake_2h3",
	"mtake_3b1",
	"mtake_3h1",
	"mtake_3h2",
	"mtake_3h3",
	"mtake_3h4",
	"mtake_3h5",
	"mtake_3n1",
	"mtake_3n2",
	"mtake_3n3",
	"mtake_4h1",
	"mtake_4h2",
	"mtake_4h3",
	"mtake_4h4",
	"mtake_4h5",
	"mtake_5b1",
	"mtake_5h1",
	"mtake_5h2",
	"mtake_5h3",
	"mtake_5n1",
	"mtake_6h1",
	"mtake_6h2",
	"mtake_6h3",
	"mtake_gen",
	]
	
var missionnamelist = [
	"Erste Mission",
	"Lima 2",
	"Dr Finch retten",
	"Stoney vor Cingan retten",
	"Schiffe sammeln",
	"Intrepido",
	"Brainfire Transport",
	"Stoney Rennen",
	"Dr Finch eskortieren",
	"Chow Lung Angriff",
	"Swedenborg",
	"Redbeard Eldorado",
	"Erster Fremder Angriff",
	"Eskorte zu El Topo",
	"El Topo Patroilie",
	"Höllenbad",
	"Lt. Hamlet Angriff",
	"El Topo Piratenangriff",
	"Stoney Buggy Mission",
	"Freeman",
	"Angelina Kidnapping",
	"Schatzsuche",
	"Lopez Versteck",
	"Amitabs Ende",
	"Angelinas Opfer",
	"Neopolis Redbeard Kampf",
	"Lunats Werft",
	"Museeum Besuch",
	"2ter Museeum Besuch",
	"Greigh Konkurrenz üferfall",
	"Nats Ende",
	"Rache",
	"Grabsuche",
	"generische_sounds",
	]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_preview_scene = preload("res://dialog_preview.tscn")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Initialize():
	SetupMissionList()
	UpdateStakeList(0)

func SetupMissionList():
	var roomlist = main_data_object.roomlist.table
	for i in missionlist.size():
		$HBoxContainer/VBoxContainer/MissionButton.add_item(missionlist[i], i)

func UpdateStakeList(index):
	$HBoxContainer/VBoxContainer2/MtakeList.clear()
	$HBoxContainer/VBoxContainer2/TextEdit.text = ""
	current_mtake_list = []
	current_mtake_dict = {}
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/MtakeKey.text = "-1"
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonKey.text = "-1"
	$HBoxContainer/VBoxContainer/NewPersonKey.text = "-1"
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonName.text = ""
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Dialog_Comment_des.text = ""
	var mtakelist = main_data_object.mtakedict[missionlist[index]].table
	var counter = 0
	for key in mtakelist.keys():
		print(key)
		print(mtakelist[key].Person)
		if person_filter > 0:
			$HBoxContainer/VBoxContainer/Label.text = "Missionlist !!! Filter in Field enabled for Person:" + str(person_filter)
		
		if person_filter == 0:
			$HBoxContainer/VBoxContainer/Label.text = "Missionlist"
			var tempstring = str(counter) + " "
			tempstring += main_data_object.charlist.GetObjectwithKey(mtakelist[key].Person).Name + ": "
			var shorttext = mtakelist[key].Text.left(50)
			tempstring += shorttext
			current_mtake_dict[tempstring] = mtakelist[key]
			current_mtake_list.append(mtakelist[key])
			$HBoxContainer/VBoxContainer2/MtakeList.add_item(tempstring)
			counter += 1
		elif mtakelist[key].Person == person_filter:
			var tempstring = str(counter) + " "
			tempstring += main_data_object.charlist.GetObjectwithKey(mtakelist[key].Person).Name + ": "
			var shorttext = mtakelist[key].Text.left(50)
			tempstring += shorttext
			current_mtake_dict[tempstring] = mtakelist[key]
			current_mtake_list.append(mtakelist[key])
			$HBoxContainer/VBoxContainer2/MtakeList.add_item(tempstring)
			counter += 1
	
func _on_room_button_item_selected(index: int) -> void:
	UpdateStakeList(index)

func _on_text_edit_text_changed() -> void:
	UpdateMtakeEntryData()


func _on_stake_list_item_selected(index: int) -> void:
	current_mtake_object = current_mtake_list[index]
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/MtakeKey.text = str(current_mtake_object.Key)
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonKey.text = str(current_mtake_object.Person)
	$HBoxContainer/VBoxContainer/NewPersonKey.text = str(current_mtake_object.Person)
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonName.text = main_data_object.charlist.GetObjectwithKey(current_mtake_object.Person).Name
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Dialog_Comment_des.text = current_mtake_object.Comment_des
	$HBoxContainer/VBoxContainer2/TextEdit.text = current_mtake_object.Text
	$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_color", Color("ffffff"))
	$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_focus_color", Color("ffffff"))
	$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_hover_color", Color("ffffff"))
	$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_color", Color("ffffff"))
	$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_focus_color", Color("ffffff"))
	$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_hover_color", Color("ffffff"))
	preview_sound_generated = false
	

func UpdateMtakeEntryData():
	if current_mtake_object != null:
		current_mtake_object.Text = $HBoxContainer/VBoxContainer2/TextEdit.text

func _on_dialog_comment_des_text_changed(new_text: String) -> void:
	current_mtake_object.Comment_des = new_text
		
func _on_play_audio_pressed() -> void:
	if is_instance_valid(current_dialog_preview_instance):
		current_dialog_preview_instance.StopSound()
		current_dialog_preview_instance.queue_free()
	if current_mtake_object != null:
		current_dialog_preview_instance = dialog_preview_scene.instantiate()
		add_child(current_dialog_preview_instance)
		current_dialog_preview_instance.LoadSingleSound(current_mtake_object.WavPath)


func _on_stop_audio_pressed() -> void:
	if is_instance_valid(current_dialog_preview_instance):
		current_dialog_preview_instance.StopSound()
		current_dialog_preview_instance.queue_free()

func _on_export_all_files_pressed() -> void:
	main_data_object.ExportFiles()

func _on_update_person_key_pressed() -> void:
	var new_person = int($HBoxContainer/VBoxContainer/NewPersonKey.text)
	var person_entry = main_data_object.charlist.GetObjectwithKey(new_person)
	if person_entry != null:
		current_mtake_object.Person = new_person
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonKey.text = str(current_mtake_object.Person)
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonName.text = main_data_object.charlist.GetObjectwithKey(current_mtake_object.Person).Name
	else:
		$HBoxContainer/VBoxContainer/NewPersonKey.text = str(current_mtake_object.Person)
		


func _on_print_all_mtake_to_console_pressed() -> void:
	print("###########Export Mtake############")
	for entry in current_mtake_list:
		var infostring = "Person: " + main_data_object.charlist.GetObjectwithKey(entry.Person).Name + " Key: " + str(entry.Key)
		if entry.Comment_des != "NO .DES COMMENT":
			infostring = infostring + " Comment: " + entry.Comment_des
		print(infostring)
		print(entry.Text)
		


func _on_generate_preview_sound_pressed() -> void:
	GeneratePreviewSound()



func GeneratePreviewSound():
	var text_object = $HBoxContainer/VBoxContainer/HBoxContainer2/SoundVolume.get_line_edit()
	var soundvolume = float(text_object.text)
	if current_mtake_object != null:
		var successful = main_data_object.ConvertAudioFile(current_mtake_object.WavPath, soundvolume, false)
		if successful == false:
			$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_color", Color("ff0000"))
			$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_focus_color", Color("ff0000"))
			$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_hover_color", Color("ff0000"))
		elif successful == true:
			$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_color", Color("00ff21"))
			$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_focus_color", Color("00ff21"))
			$HBoxContainer/VBoxContainer/GeneratePreviewSound.add_theme_color_override("font_hover_color", Color("00ff21"))
			preview_sound_generated = true
			preview_sound_volume = text_object.text


func _on_play_preview_sound_pressed() -> void:
	var text_object = $HBoxContainer/VBoxContainer/HBoxContainer2/SoundVolume.get_line_edit()
	if is_instance_valid(current_dialog_preview_instance):
		current_dialog_preview_instance.StopSound()
		current_dialog_preview_instance.queue_free()
	if preview_sound_generated == false:
		GeneratePreviewSound()
		if preview_sound_generated == false:
			return
		PlayPreviewSound()
	else:
		if text_object.text == preview_sound_volume:
			PlayPreviewSound()
		else:
			GeneratePreviewSound()
			PlayPreviewSound()

func PlayPreviewSound():
	if FileAccess.file_exists(main_data_object.audio_preview_path):
		if is_instance_valid(current_dialog_preview_instance):
			current_dialog_preview_instance.StopSound()
			current_dialog_preview_instance.queue_free()
		if current_mtake_object != null:
			current_dialog_preview_instance = dialog_preview_scene.instantiate()
			add_child(current_dialog_preview_instance)
			current_dialog_preview_instance.LoadSingleSound(main_data_object.audio_preview_path)


func _on_override_main_sound_pressed() -> void:
	var text_object = $HBoxContainer/VBoxContainer/HBoxContainer2/SoundVolume.get_line_edit()
	var soundvolume = float(text_object.text)
	if current_mtake_object != null:
		var successful = main_data_object.ConvertAudioFile(current_mtake_object.WavPath, soundvolume, true)
		if successful == false:
			$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_color", Color("ff0000"))
			$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_focus_color", Color("ff0000"))
			$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_hover_color", Color("ff0000"))
		elif successful == true:
			$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_color", Color("00ff21"))
			$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_focus_color", Color("00ff21"))
			$HBoxContainer/VBoxContainer/OverrideMainSound.add_theme_color_override("font_hover_color", Color("00ff21"))
			preview_sound_generated = true
			preview_sound_volume = text_object.text


func _on_play_refernce_sound_pressed() -> void:
	if FileAccess.file_exists(main_data_object.audio_reference_mtake_path):
		if is_instance_valid(current_dialog_preview_instance):
			current_dialog_preview_instance.StopSound()
			current_dialog_preview_instance.queue_free()
		if current_mtake_object != null:
			current_dialog_preview_instance = dialog_preview_scene.instantiate()
			add_child(current_dialog_preview_instance)
			current_dialog_preview_instance.LoadSingleSound(main_data_object.audio_reference_mtake_path)


func _on_person_filter_value_changed(value: float) -> void:
	person_filter = int(value)
	pass # Replace with function body.
