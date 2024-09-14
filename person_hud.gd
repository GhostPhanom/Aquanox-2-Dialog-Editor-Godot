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
	


func _on_update_person_name_pressed() -> void:
	if $HBoxContainer/VBoxContainer/NewPersonName.text != "":
		currentperson.Name = $HBoxContainer/VBoxContainer/NewPersonName.text
	if $HBoxContainer/VBoxContainer/NewPersonShortName.text != "":
		currentperson.ShortName = $HBoxContainer/VBoxContainer/NewPersonShortName.text


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
