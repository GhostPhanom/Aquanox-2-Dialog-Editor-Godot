extends Control

var main_data_object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Initialize():
	UpdateDisplayedData(0)

func StakeNumberSelectionSanetize(input):
	await get_tree().create_timer(0,03).timeout#wait one frame so the textbox data gets updated after signalfireing
	var text_object = $HBoxContainer/VBoxContainer/SpinBox.get_line_edit()
	#var current_number = int(text_object.text)
	var current_number = input
	var stake_list = main_data_object.stakelist.table
	var stake_list_length = stake_list.size()
	if current_number >= 0 and current_number < stake_list_length:
		UpdateDisplayedData(current_number)
	else:
		text_object.text = "0"#Reset
		UpdateDisplayedData(0)

func UpdateDisplayedData(index):
	var index_name = "Take" + str(index)
	var stake_entry = main_data_object.stakelist.table[index_name]
	#print_debug(index_name)
	#stake_entry.Print()
	$HBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/Key.text = str(stake_entry.Key)
	$HBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/Dialog.text = str(stake_entry.Dialog)
	$HBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/Person.text = str(stake_entry.Person)
	$HBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/Wav.text = str(stake_entry.Wav)
	$HBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/WavPath.text = str(stake_entry.WavPath)
	$HBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/Mood.text = str(stake_entry.Mood)
	$HBoxContainer/VBoxContainer2/Comment_des.text = str(stake_entry.Comment_des)
	$HBoxContainer/VBoxContainer2/Comment_loc.text = str(stake_entry.Comment_loc)
	$HBoxContainer/VBoxContainer/TextEdit.text = str(stake_entry.Text)


func _on_spin_box_value_changed(value: float) -> void:
	StakeNumberSelectionSanetize(int(value))


func _on_play_audio_pressed() -> void:
	var text_object = $HBoxContainer/VBoxContainer/SpinBox.get_line_edit()
	var current_number = int(text_object.text)
	var stake_list = main_data_object.stakelist.table
	var index_name = "Take" + str(current_number)
	var stake_entry = main_data_object.stakelist.table[index_name]
	if $StakeSound.playing:
		$StakeSound.stop()
	if FileAccess.file_exists(stake_entry.WavPath):
		$StakeSound.stream = AudioStreamOggVorbis.load_from_file(stake_entry.WavPath)
		$StakeSound.play()

func _on_stop_audio_pressed() -> void:
	$StakeSound.stop()
