extends Control

var main_data_object
var current_dialog_list = []
var current_stake_list = []

var current_dialog_object = null
var current_stake_object = null

var stake_dict = {}

var base_person1
var base_person2
var current_person1
var current_person2

var dialog_preview_scene
var current_dialog_preview_instance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_preview_scene = preload("res://dialog_preview.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Initialize():
	SetupRoomList()
	UpdateDialogList(0)
	
func SetupRoomList():
	var roomlist = main_data_object.roomlist.table
	for i in roomlist.size():
		var room = roomlist["Room" + str(i)]
		$HBoxContainer/VBoxContainer/RoomButton.add_item(str(i) + "" + room.Comment_des, i)

func UpdateDialogList(index):
	var roomlist = main_data_object.roomlist.table
	var room = roomlist["Room" + str(index)]
	var sdialoglist = main_data_object.sdialoglist.table
	
	$HBoxContainer/VBoxContainer/DialogButton.clear()
	current_dialog_list = []
	for i in sdialoglist.size():
		if sdialoglist["Dialog" + str(i)].Room == room.Key:
			current_dialog_list.append(sdialoglist["Dialog" + str(i)])
			#print(current_dialog_list)
	for i in current_dialog_list.size():
		$HBoxContainer/VBoxContainer/DialogButton.add_item(current_dialog_list[i].Comment_des, i)
	if current_dialog_list.size() > 0:
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Dialog_Comment_des.text = current_dialog_list[0].Comment_des
		current_dialog_object = current_dialog_list[0]
		FetchDialogData(current_dialog_list[0].Key, 0)
	
func FetchDialogData(Key, index):
	var stakelist = main_data_object.stakelist.table
	current_stake_list = []
	current_person1 = -1
	current_person2 = -1
	base_person1 = -1
	base_person2 = -1
	for i in stakelist.size():
		if stakelist["Take" + str(i)].Dialog == Key:
			current_stake_list.append(stakelist["Take" + str(i)])
	if current_stake_list.size() != 0:
		current_person1 = current_stake_list[0].Person
		for i in current_stake_list.size():
			if current_person1 != current_stake_list[i].Person and current_person2 == -1:
				current_person2 = current_stake_list[i].Person
			elif current_person1 != current_stake_list[i].Person and current_person2 != current_stake_list[i].Person:
				assert(false, "Dialog has more than 2 Persons used!!! Dialog Key:" + str(Key))
	base_person1 = current_person1
	base_person2 = current_person2
	var person1 = main_data_object.charlist.GetObjectwithKey(current_person1)
	var person2 = main_data_object.charlist.GetObjectwithKey(current_person2)
	var second_person_found = false
	if current_person2 != -1:
		second_person_found = true
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Dialog_Comment_des.text = current_dialog_list[index].Comment_des
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Person1Key.text = str(person1.Key)
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Person1Name.text = str(person1.Name)
	if second_person_found == true:
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Person2Key.text = str(person2.Key)
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Person2Name.text = str(person2.Name)
	else:
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Person2Key.text = str(-1)
		$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Person2Name.text = "No 2nd Person found"
	current_dialog_object = current_dialog_list[index]
	ResetStakeList()
	
func ResetStakeList():
	current_stake_object = null
	stake_dict = {}
	var counter = 0
	$HBoxContainer/VBoxContainer2/TextEdit.text = ""
	$HBoxContainer/VBoxContainer2/StakeList.clear()
	for i in current_stake_list.size():
		var tempstring = str(counter) + ": " + main_data_object.charlist.GetObjectwithKey(current_stake_list[i].Person).Name + ": "
		var shorttext = current_stake_list[i].Text.left(50)
		tempstring = tempstring + shorttext
		stake_dict[tempstring] = current_stake_list[i]
		$HBoxContainer/VBoxContainer2/StakeList.add_item(tempstring)
		counter += 1

func SelectStakeEntry(entry):
	current_stake_object = stake_dict[entry]
	$HBoxContainer/VBoxContainer2/TextEdit.Text

func UpdateStakeEntryData():
	if current_stake_object != null:
		current_stake_object.Text = $HBoxContainer/VBoxContainer2/TextEdit.text
	


func _on_room_button_item_selected(index: int) -> void:
	UpdateDialogList(index)


func _on_dialog_button_item_selected(index: int) -> void:
	#print(index)
	#print(current_dialog_list[index].Key)
	FetchDialogData(current_dialog_list[index].Key, index)


func _on_text_edit_text_changed() -> void:
	UpdateStakeEntryData()


func _on_stake_list_item_selected(index: int) -> void:
	current_stake_object = current_stake_list[index]
	$HBoxContainer/VBoxContainer2/TextEdit.text = current_stake_object.Text
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/StakeKey.text = str(current_stake_object.Key)


func _on_dialog_comment_des_text_changed(new_text: String) -> void:
	current_dialog_object.Comment_des = new_text


func _on_play_audio_pressed() -> void:
	if is_instance_valid(current_dialog_preview_instance):
		current_dialog_preview_instance.StopSound()
		current_dialog_preview_instance.queue_free()
	current_dialog_preview_instance = dialog_preview_scene.instantiate()
	add_child(current_dialog_preview_instance)
	var audio_path_list = []
	for i in current_stake_list.size():
		audio_path_list = audio_path_list + [current_stake_list[i].WavPath]
	
	if $HBoxContainer/VBoxContainer/UseRoomSound.pressed:
		var room = main_data_object.roomlist.GetObjectwithKey(current_dialog_object.Room)
		current_dialog_preview_instance.LoadDialogRoomTree(audio_path_list, room.Sound)
	else:
		current_dialog_preview_instance.LoadDialogTree(audio_path_list)


func _on_stop_audio_pressed() -> void:
	if is_instance_valid(current_dialog_preview_instance):
		current_dialog_preview_instance.StopSound()
		current_dialog_preview_instance.queue_free()


func _on_export_all_files_pressed() -> void:
	main_data_object.ExportFiles()
