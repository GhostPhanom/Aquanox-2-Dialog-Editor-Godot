extends Control

var main_data_object
var current_mtake_list = []
var current_mtake_dict = {}

var current_mtake_object

var dialog_preview_scene
var current_dialog_preview_instance = null

var missionlist = [
	"mtake_1h1",
	"mtake_1h2",
	"mtake_1h3",
	"mtake_1h4",
	"mtake_1h5",
	"mtake_2b1",
	"mtake_2h1",
	"mtake_2h2",
	"mtake_3b1",
	"mtake_3h1",
	"mtake_3h2",
	"mtake_3h3",
	"mtake_3h4",
	"mtake_3h5",
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
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonName.text = ""
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Dialog_Comment_des.text = ""
	var mtakelist = main_data_object.mtakedict[missionlist[index]].table
	var counter = 0
	for key in mtakelist.keys():
		print(key)
		print(mtakelist[key].Person)
		
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
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PersonName.text = main_data_object.charlist.GetObjectwithKey(current_mtake_object.Person).Name
	$HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Dialog_Comment_des.text = current_mtake_object.Comment_des
	$HBoxContainer/VBoxContainer2/TextEdit.text = current_mtake_object.Text

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
