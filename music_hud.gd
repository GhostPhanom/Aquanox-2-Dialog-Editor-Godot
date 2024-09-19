extends Control

var main_data_object
var music_path
var metadata_path
var metadata_json

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Initialize():
	metadata_path = main_data_object.aquanox_basepath + "sfx/sample/music/metadata.json"
	music_path = main_data_object.aquanox_basepath + "sfx/sample/music/"
	if FileAccess.file_exists(metadata_path):
		metadata_json = JSON.new()
		var file = FileAccess.open(metadata_path, FileAccess.READ)
		var content = file.get_as_text()
		metadata_json.parse(content)
		$HBoxContainer/VBoxContainer/Label.text = "Nextindex: " + str(metadata_json.data["nextindex"])
		#print(metadata_json)
		#print(metadata_json.data)

func _on_button_pressed() -> void:
	$HBoxContainer/FileDialog.set_current_path(music_path)
	$HBoxContainer/FileDialog.set_filters(["*.ogg"])
	$HBoxContainer/FileDialog.popup_centered_clamped()
	
func _on_file_dialog_file_selected(path: String) -> void:
	print(path)
	if FileAccess.file_exists(path):
		metadata_json.data["lengthlist"][0]
		var filename = ""
		var index = metadata_json.data["nextindex"]
		var reminder = metadata_json.data["lengthlist"][0] - str(index).length() 
		for n in range(reminder):
			filename = filename + "0"
		filename = music_path + "music_" + filename + str(index) + ".ogg"
		DirAccess.copy_absolute(path, filename)
		var SAMfilename = ""
		for filenamelength in metadata_json.data["lengthlist"]:
			SAMfilename = ""
			var filepath = music_path
			reminder = filenamelength - str(index).length()
			for n in range(reminder):
				SAMfilename = SAMfilename + "0"
			SAMfilename = music_path + "music_" + SAMfilename + str(index) + ".sam"
			CreateSAMFile(SAMfilename, filename.get_file())
		metadata_json.data["nextindex"] = metadata_json.data["nextindex"] + 1
		var file = FileAccess.open(metadata_path, FileAccess.WRITE)
		file.store_string(metadata_json.stringify(metadata_json.data, "  "))
		file.close()
		$HBoxContainer/VBoxContainer/Label.text = "Nextindex: " + str(metadata_json.data["nextindex"])
	
func CreateSAMFile(path, music_filename):
	var tempstring = "\n[SampleInfo]\n{\n\n"
	tempstring = tempstring + "	name = \"music\\" + music_filename + "\"" + "\n"
	tempstring = tempstring + "	freq = " + str(metadata_json.data["template_freq"]) + "\n"
	tempstring = tempstring + "	freqrnd = " + str(metadata_json.data["template_freqrnd"]) + "\n"
	tempstring = tempstring + "	vol = " + str(metadata_json.data["template_vol"]) + "\n"
	tempstring = tempstring + "	volrnd = " + str(metadata_json.data["template_volrnd"]) + "\n"
	tempstring = tempstring + "	cnt = " + str(metadata_json.data["template_cnt"]) + "\n"
	tempstring = tempstring + "	minr = " + str(metadata_json.data["template_minr"]) + ".0" + "\n"
	tempstring = tempstring + "	maxr = " + str(metadata_json.data["template_maxr"]) + ".0" + "\n\n}\n"
	#print(tempstring)
	#print(path)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(tempstring)
	file.close()
