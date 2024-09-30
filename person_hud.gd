extends Control

var main_data_object

var maxpersonlist = 1
var maxpersontablelist = 0
var currentspincounter = 1
var currentperson

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Initialize():
	SetupPersonList()
	ShowListEntry(1)

func SetupPersonList():
	UpdateListLength()

func UpdateListLength():
	var highestkey = 0
	var highesttablekey = 0
	var person_list = main_data_object.charlist
	for entry in person_list.table.keys():
		var char = person_list.table[entry]
		if char.Key > highestkey:
			highestkey = char.Key
		var tablekey = entry.right(-6)#Strips from Person12 the Person Part
		if(int(tablekey) > highesttablekey):
			highesttablekey = int(tablekey)
		
	maxpersonlist = highestkey
	maxpersontablelist = highesttablekey
	

func ShowListEntry(Key):
	#$Mood0BG.visible = false
	#$HBoxContainer/VBoxContainer2/ElfPreview.visible = false
	#$HBoxContainer/VBoxContainer2/Mood0Preview.visible = false
	currentperson = main_data_object.charlist.GetObjectwithKey(Key)
	if currentperson == null:#If Key does not exists it bumps the counter one up
		var text_object = $HBoxContainer/VBoxContainer/SpinBox.get_line_edit()
		text_object.text = str(int(text_object.text) + 1)
		PersonNumberSelectionSanetize(float(currentspincounter + 1))#Function expects float
	else:
		if currentperson.Name != null:
			$HBoxContainer/VBoxContainer/HBoxContainer/PersonName.text = currentperson.Name
			$HBoxContainer/VBoxContainer/NewPersonName.text = currentperson.Name
		else:
			$HBoxContainer/VBoxContainer/HBoxContainer/PersonName.text = ""
			$HBoxContainer/VBoxContainer/NewPersonName.text = ""
		if currentperson.ShortName != null:
			$HBoxContainer/VBoxContainer/HBoxContainer2/PersonShortName.text = currentperson.ShortName
			$HBoxContainer/VBoxContainer/NewPersonShortName.text = currentperson.ShortName
		else:
			$HBoxContainer/VBoxContainer/HBoxContainer2/PersonShortName.text = ""
			$HBoxContainer/VBoxContainer/NewPersonShortName.text = ""
		if currentperson.ImageElf != null:
			$HBoxContainer/VBoxContainer/HBoxContainer3/ImageElf.text = currentperson.ImageElf
			$HBoxContainer/VBoxContainer/NewImageElf.text = currentperson.ImageElf
		else:
			$HBoxContainer/VBoxContainer/HBoxContainer3/ImageElf.text = ""
			$HBoxContainer/VBoxContainer/NewImageElf.text = ""
		if currentperson.ImageMood0 != null:
			$HBoxContainer/VBoxContainer/HBoxContainer4/ImageMood0.text = currentperson.ImageMood0
			$HBoxContainer/VBoxContainer/NewImageMood0.text = currentperson.ImageMood0
		else:
			$HBoxContainer/VBoxContainer/HBoxContainer4/ImageMood0.text = ""
			$HBoxContainer/VBoxContainer/NewImageMood0.text = ""
		SetPreviewPictures()

func _on_update_image_paths_pressed() -> void:
	currentperson.ImageElf = $HBoxContainer/VBoxContainer/NewImageElf.text
	if currentperson.ImageElf == "":
		currentperson.ImageElfPath = main_data_object.charlist.aquanox_basepath + "no_file_path"
	else:
		currentperson.ImageElfPath = main_data_object.charlist.aquanox_basepath + currentperson.ImageElf
	currentperson.ImageMood0 = $HBoxContainer/VBoxContainer/NewImageMood0.text
	if currentperson.ImageMood0 == "":
		currentperson.ImageMood0Path = main_data_object.charlist.aquanox_basepath + "no_file_path"
	else:
		currentperson.ImageMood0Path = main_data_object.charlist.aquanox_basepath + currentperson.ImageMood0
	ShowListEntry(currentspincounter)

func _on_update_person_name_pressed() -> void:
	if $HBoxContainer/VBoxContainer/NewPersonName.text != "":
		currentperson.Name = $HBoxContainer/VBoxContainer/NewPersonName.text
	if $HBoxContainer/VBoxContainer/NewPersonShortName.text != "":
		currentperson.ShortName = $HBoxContainer/VBoxContainer/NewPersonShortName.text
	ShowListEntry(currentspincounter)


func _on_export_all_files_pressed() -> void:
	main_data_object.ExportFiles()

func PersonNumberSelectionSanetize(input):
	await get_tree().create_timer(0,03).timeout#wait one frame so the textbox data gets updated after signalfireing
	var text_object = $HBoxContainer/VBoxContainer/SpinBox.get_line_edit()
	#var current_number = int(text_object.text)
	var current_number = input
	if current_number >= 1 and current_number <= maxpersonlist:
		currentspincounter = input
		ShowListEntry(current_number)
	elif current_number == 0:
		currentspincounter = maxpersonlist
		text_object.text = str(maxpersonlist)
		ShowListEntry(maxpersonlist)
	else:
		currentspincounter = 1
		text_object.text = "1"#Reset
		ShowListEntry(1)

func _on_spin_box_value_changed(value: float) -> void:
	PersonNumberSelectionSanetize(int(value))


func _on_new_entry_pressed() -> void:
	main_data_object.AddNewCharacter(main_data_object.charlist, maxpersontablelist, maxpersonlist)
	UpdateListLength()


func _on_delete_last_entry_pressed() -> void:
	if currentperson == main_data_object.charlist.GetObjectwithKey(maxpersonlist):
		main_data_object.charlist.table.erase("Person" + str(maxpersontablelist))
		UpdateListLength()
		ShowListEntry(1)
	else:
		print("Current Entry not last entry, will not be deleted")

func _on_preview_pictures_pressed() -> void:
	SetPreviewPictures()

func SetPreviewPictures():
	if FileAccess.file_exists(currentperson.ImageElfPath):
		var image = Image.load_from_file(currentperson.ImageElfPath)
		var texture = ImageTexture.create_from_image(image)
		$HBoxContainer/VBoxContainer2/ElfPreview.texture = texture
		$HBoxContainer/VBoxContainer2/ElfPreview.visible = true
	else:
		$HBoxContainer/VBoxContainer2/ElfPreview.visible = false
		
	if FileAccess.file_exists(currentperson.ImageMood0Path):
		var image = Image.load_from_file(currentperson.ImageMood0Path)
		var texture = ImageTexture.create_from_image(image)
		$HBoxContainer/VBoxContainer2/Mood0Preview.texture = texture
		$HBoxContainer/VBoxContainer2/Mood0Preview.visible = true
		await get_tree().create_timer(0,03).timeout
		var vector = $HBoxContainer/VBoxContainer2/Mood0Preview.get_screen_position()
		$Mood0BG.set_position(Vector2(vector[0] - 5, vector[1] - 31))
		$Mood0BG.visible = true
	else:
		$HBoxContainer/VBoxContainer2/Mood0Preview.visible = false
		$Mood0BG.visible = false


func _on_print_all_m_take_pressed() -> void:
	var counter = 0
	var personname = currentperson.Name
	var missionname_printed = false
	for mission in main_data_object.mtakedict.keys():
		missionname_printed = false
		for mtake in main_data_object.mtakedict[mission].table.keys():
			var take = main_data_object.mtakedict[mission].table[mtake]
			if take.Person == currentperson.Key:
				if missionname_printed == false:
					print("Mission: " + mission)
					missionname_printed = true
				print("Key:" + str(take.Key) + " " + currentperson.Name + ": " + take.Text)
				counter += 1
	print("Number of lines: " + str(counter))


func _on_print_all_s_take_pressed() -> void:
	var counter = 0
	var personname = currentperson.Name
	var stakelist_temp = []
	var roomname_printed = false
	var dialogname_printed = false
	for stake in main_data_object.stakelist.table.keys():
		if main_data_object.stakelist.table[stake].Person == currentperson.Key:
			stakelist_temp = stakelist_temp + [main_data_object.stakelist.table[stake]]
	for roomname in main_data_object.roomlist.table.keys():
		var room = main_data_object.roomlist.table[roomname]
		roomname_printed = false
		for dialogname in main_data_object.sdialoglist.table.keys():
			var dialog = main_data_object.sdialoglist.table[dialogname]
			dialogname_printed = false
			if room.Key == dialog.Room:
				for take in stakelist_temp:
					if dialog.Key == take.Dialog:
						if roomname_printed == false:
							print("Room: " + room.Comment_des)
							roomname_printed = true
						if dialogname_printed == false:
							print("Dialog: " + dialog.Comment_des)
							dialogname_printed = true
						print(personname + ": " + take.Text)
						counter += 1
	print("Counter: " + str(counter))


func _on_print_all_m_take_v_2_pressed() -> void:
	var counter = 0
	var person_present = false
	var export_needed = false
	var complete_text = ""
	var current_textblock = ""
	for mission in main_data_object.mtakedict.keys():
		person_present = false
		current_textblock = "#####\n" + "Mission: " + main_data_object.mtakedict[mission].filename + "\n"+ "Mission Name: " + main_data_object.mtakedict[mission].missionname + "\n"+ "Mission Description: " + main_data_object.mtakedict[mission].missiondescription + "\n\n"
		for mtake in main_data_object.mtakedict[mission].table.keys():
			var take = main_data_object.mtakedict[mission].table[mtake]
			if take.Person == currentperson.Key:
				person_present = true
				current_textblock = current_textblock + "**Key:" + str(take.Key) + " " + currentperson.Name + ": " + take.Text + "**\n"
				counter += 1
			elif main_data_object.mtakedict[mission].filename != "mtake_gen":
				var person = main_data_object.charlist.GetObjectwithKey(take.Person)
				current_textblock = current_textblock + person.Name + ": " + take.Text + "\n"
		if person_present == true:
			export_needed = true
			complete_text = complete_text + current_textblock
	complete_text = complete_text + "Number of lines: " + str(counter)
	if export_needed == true:
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var error = DirAccess.make_dir_recursive_absolute(main_data_object.export_basepath + currenttimepath + "/")
		var file = FileAccess.open(main_data_object.export_basepath + currenttimepath + "/" + "person_" + str(currentperson.Key) + ".md", FileAccess.WRITE)
		file.store_string(complete_text)
		file.close()
		print(main_data_object.export_basepath + currenttimepath + "/" + "person_" + str(currentperson.Key) + ".md")
	else:
		print("No lines for character found. No file exported")
