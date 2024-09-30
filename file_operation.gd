extends Node

var aquanox_basepath = "C:/Games/AquaNox 2 Revelation/aq2/"#Attention windows path but used/ instead of \
var locale = "de"
var export_basepath = "C:/Games/AquaNox 2 Revelation/aq2/export/"
var audio_preview_path = "D:/Programme/Godot/previewfile.ogg"
var audio_reference_mtake_path = "D:/Programme/Godot/reference_mtake.ogg"

var charlist
var roomlist
var shiplist
var moodlist
var sdialoglist
var stakelist
var FileOptions

var mtakefilelist = [
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

var mtakedict = {}

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

var missioninfolist = [
	["mtake_1h1", "Erste Mission","Aufgabe:~Notruf von Hank Bellows verfolgen.~Navigationspunkte anfahren.~Den Canyon durchsteuern."],
	["mtake_1h2","Lima 2","Aufgabe:~Neo-Yuppies bei Lima II ausschalten.~Funkanweisungen von Amitab folgen.~~Taktischer Hinweis:~Stoney Fox und May Ling passen auf!"],
	["mtake_1h3","Dr Finch retten","Aufgabe:~Dr. Finch wird von Crawler-Bande angegriffen. Die Zeit wird knapp!~Dr. Finch befreien und zur Harvester zurück eskortieren.~~Taktischer Hinweis:~Vendetta Sniper ideal um leicht gepanzerte, weit entfernte Ziele zu eliminieren! Auf's Cockpit zielen!"],
	["mtake_1h4","Stoney in Gefahr","Aufgabe:~Die Eerie eskortieren, damit Stoney Fox befreit werden kann.~Anschließend die Eerie nach Atacama City geleiten.~~Taktischer Hinweis:~Schiffe der Tornado Zone sind im Cockpit-Bereich mangelhaft geschützt!"],
	["mtake_1h5","Mighty Maggie","Aufgabe:~Neues Boot beschaffen.~Einige Verrückte versuchen, sich in der Station Scavenger zu verstecken.~Sie sind im Besitz dreier interessanter Boote.~~Taktischer Hinweis:~EMPactor sollte an Bord sein!~FlashSharks gegen starken EMP-Schild einsetzen!"],
	["mtake_1n1","Intrepido","Aufgabe:~Goons, im Dienste von Atahualpa Jones, wurde von der Intrepido hochgenommen.~Goons aufspüren, ihn befreien und nach Atacama City zurückbringen.~~Taktischer Hinweis:~Die Intrepido fährt Boote, die den leichten Scouts der Atlantischen Föderation ähneln!"],
	["mtake_1n2","Der Coup","Aufgabe:~Zwei Frachter müssen auf ihrem Weg zur Station Brainfire gestoppt werden.~Die Eerie dockt dann an um die Ladung zu erbeuten.~~Taktischer Hinweis:~Falls Brainfire Verstärkung entsendet, sollte zusätzlich zur EMPactor eine wirkungsvolle kinetische Waffe montiert sein."],
	["mtake_2b1","Das Rennen","Aufgabe:~Stoney Fox fordert zu einem Wettrennen!~Dem Sieger winkt eine kleine, feine Belohnung!~~Taktischer Hinweis:~Nur die Salty Dog hat eine Chance gegen Stoneys Boot!~Kinetische Waffen sind nicht erlaubt!~Aber EMP-Waffen dürften nützlich sein!"],
	["mtake_2h1","Machina Antarctica","Aufgabe:~Dr. Finch zum Außenposten der Machina Antarctica eskortieren.~Der Auftraggeberin darf auf keinen Fall etwas zustoßen!~~Taktischer Hinweis:~Die See um Kap Horn wimmelt vor Piraten, die aber nur über leichte Bewaffnung verfügen!"],
	["mtake_2h2","Chow Lung Angriff","Aufgabe:~Chow Lung hat Amitab und May Ling nach langer Zeit aufgespürt.~Er greift die Harvester massiv an. Der Frachter muss beschützt werden!~~Taktischer Hinweis:~Vor dem Dock wird bereits Feindfeuer gemeldet. Vorsicht beim Abdocken!"],
	["mtake_2h3","Swedenborgs Flucht","Aufgabe:~Swedenborg hat eine neuartige Waffe, eine Forschungsarbeit von Dr. Finch, erbeutet.~Amitab will diese Waffe haben!~Swedenborg verfolgen, dessen Schiff lahm legen, aber auf keinen Fall zerstören!~~Taktischer Hinweis: EMPactor mitnehmen!"],
	["mtake_3b1","Redbeard Eldorado","Aufgabe:~Captain Redbeards Versteck ausheben.~Weg durch den Canyon nehmen.~Verteidigungsanlagen ausschalten."],
	["mtake_3h1","Angriff","Aufgabe:~Harvester steht unter Feindbeschuss.~Angreifer nicht identifiziert.~Sofortige Abwehrmaßnahmen einleiten und Angreifer vernichten!"],
	["mtake_3h2","Der Konvoi","Aufgabe:~Militärischen Konvoi am ersten Navigationspunkt ansteuern.~Den Konvoi durch dieses Gebiet eskortieren.~Befehlen Amitabs folgen."],
	["mtake_3h3","Asylum Patrouille","Aufgabe:~Ein Angriff von Leo van der Waals Schergen wird erwartet.~Gemeinsam mit May Ling um das Gebiet von El Topo's Asylum Patrouille fahren.~Funkanweisungen befolgen.~~Taktischer Hinweis:~Die Schiffe von EnTrOx sind schwer gepanzert!"],
	["mtake_3h4","Das Höllenbad","Aufgabe:~Das Höllenbad wartet.~Erkundung des Abgrundes."],
	["mtake_3h5","Sein oder nicht sein","Aufgabe:~Harvester wird von Lt. Hamlet und zwei weiteren Söldnern mit EMP-Waffen angegriffen.~So schnell wie möglich abdocken und die Harvester beschützen.~Lt. Hamlet vernichten.~~Taktischer Hinweis:~Der Feind ist bestens ausgerüstet!"],
	["mtake_3n1","Piraten","Aufgabe:~Piratenangriff auf El Topos bereits angeschlagenen Verteidigungsanlagen.~Vernichtung der Piraten bringt viele Credits."],
	["mtake_3n2","Plünderung","Aufgabe:~Außenposten der Atlantischen Föderation überfallen.~Die Eerie zu einem entlegenen Fahrzeug-Hangar eskortieren und Andock-Manöver decken.~~Taktischer Hinweis:~Viele Bodeneinheiten und Geschütztürme werden erwartet!"],
	["mtake_3n3","Freeman","Aufgabe:~Freeman ist mit seinem neuen Schiff noch nicht ganz vertraut und muss zum EnTroPoint eskortiert werden."],
	["mtake_4h1","Crawler und Engel","Aufgabe:~Crawler greifen die Harvester an.~Angelinas Schiff wurde gekapert und verschleppt.~Angelina befreien.~~Taktischer Hinweis:~Ein Crawler Scout wäre praktisch!"],
	["mtake_4h2","Schatzsuche","Aufgabe:~Das Versteck des Schatzes von Juan Garcia Lopez finden."],
	["mtake_4h3","Der Schatz des Lopez","Aufgabe:~Amitab zum Dock des Versteckes eskortieren."],
	["mtake_4h4","Die Ordenssöldner","Aufgabe:~Ordenssöldner greifen die Harvester an.~Alarmstufe Rot! Feind vernichten oder in die Flucht schlagen.~~Taktischer Hinweis:~Die Ordenssöldner sind bestens ausgerüstet!"],
	["mtake_4h5","Angelinas Offenbarung","Aufgabe:~Neue Angriffswelle der Ordenssöldner attackiert die Harvester.~~Taktischer Hinweis:~Die Ordenssöldner sind bestens ausgerüstet!"],
	["mtake_5b1","Drakes Rache","Aufgabe:~Cpt. Redbeard ist der Mörder deiner Mutter.~Rache! Cpt. Redbeard vernichten."],
	["mtake_5h1","Deimos","Aufgabe:~Verteidigungsanlagen von Lunats Werft zerstören.~Andock-Manöver der Eerie überwachen.~Die Schiffe Deimos und Eerie zum Dock von Neopolis eskortieren.~~Taktischer Hinweis:~Viele Bodenziele und Geschütztürme werden erwartet!"],
	["mtake_5h2","Das Museum der Moderne","Aufgabe:~Verteidigungsanlagen des Museums durch Zerstörung der Energie-Relais des Stadtviertels ausschalten.~Durch Versorgungstunnel ins Museum vordringen.~Andock-Manöver der Eerie überwachen.~Die Eerie zum Dock von Neopolis eskortieren."],
	["mtake_5h3","Der Öffner der Tore","Aufgabe:~Stoney und Animal aus dem Navy Headquarter befreien.~Durch Sub-Level den Notgenerator für den Versorgungstunnel zerstören.~Andock-Manöver der Eerie überwachen.~~Taktischer Hinweis:~Im Sub-Level ist es sehr eng! Salty Dog nehmen!"],
	["mtake_5n1","Vastian Griegh","Aufgabe:~Vastian Grieghs Transporter ausrauben."],
	["mtake_6h1","Stregas Zorn","Aufgabe:~Queen Strega startet Großangriff ihrer Ordenssöldner.~Harvester verteidigen.~Feind vernichten.~~Taktischer Hinweis:~Die Ordenssöldner sind bestens ausgerüstet!"],
	["mtake_6h2","Blutrache","Aufgabe:~Queen Strega wartet auf das finale Duell.~Rache für Nat!"],
	["mtake_6h3","Die Tränen des Engels","Aufgabe:~Hier liegt der Eingang zum Felsengrab verborgen.~Zugang suchen und öffnen.~~Taktischer Hinweis:~McGregors Torpedo mitnehmen!"],
	["mtake_gen","generische_sounds","Generische Sounds ohne spezifische Mission"]
	]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func LoadFiles():
	FileOptions = FilemanagerOptions.new()
	FileOptions.ConfigureFilemanagerOptions(aquanox_basepath, locale, export_basepath)
	
	charlist = Character_List.new(FileOptions)
	ParseCharacters(charlist)
	#charlist.Export()
	
	roomlist = Room_List.new(FileOptions)
	ParseRooms(roomlist)
	#roomlist.Export()
	
	shiplist = Ship_List.new(FileOptions)
	ParseShips(shiplist)
	#shiplist.Export()
	
	moodlist = Mood_List.new(FileOptions)
	ParseMoods(moodlist)
	#moodlist.Export()
	
	sdialoglist = Sdialog_List.new(FileOptions)
	ParseSdialogs(sdialoglist)
	#sdialoglist.Export()
	
	stakelist = Stake_List.new(FileOptions)
	ParseStakes(stakelist)
	#stakelist.Export()
	
	MtakeDictCreate()#dict of mtake lists gets exported to variable mtakedict
	#MtakeDictExport()
	
	#stakelist.GetObjectwithKey(17).Print()
	#for stake in stakelist.GetDialogeStakeEntrys(18):
	#	print(charlist.GetObjectwithKey(stake.Person).Name + ": " + stake.Text)

func ExportFiles():
	charlist.Export()
	roomlist.Export()
	shiplist.Export()
	moodlist.Export()
	sdialoglist.Export()
	stakelist.Export()
	MtakeDictExport()

func ReadANSIFile(filepath):
	var output = []
	#print_debug(Array(filepath.split(" ")))
	#print_debug(["\""] + Array(filepath.split(" ")) + ["\""])
	var filepath_split = Array(filepath.split(" "))
	filepath_split[0] = "\"" + filepath_split[0]
	filepath_split[-1] = filepath_split[-1] + "\""
	var exit_code = OS.execute(
		"C:/Python310/python.exe", 
		[
			"\"D:\\Programme\\Godot\\Aquanox-2-Dialog-Editor-Godot\\encoding_convert.py\"",
			"--file",
		] + filepath_split + [
			"--operation",
			"read"
		],
		output,
		true,#write STDERR to output
		false#open shell; might not be necessary?
	)
	#print(exit_code)
	#print_debug(output)
	#assert(false, "lel")
	#var line_content = output[0].split("\n")
	return(output[0])

func ConvertAudioFile(filepath, targetvolume, override_source):
	var output = []
	var ffmpeg_path = "D:/Programme/Godot/ffmpeg/bin/ffmpeg.exe"
	var templocation = audio_preview_path
	var filepath_split = Array(filepath.split(" "))
	filepath_split[0] = "\"" + filepath_split[0]
	filepath_split[-1] = filepath_split[-1] + "\""
	var filepath_temp_split = Array(templocation.split(" "))
	filepath_temp_split[0] = "\"" + filepath_temp_split[0]
	filepath_temp_split[-1] = filepath_temp_split[-1] + "\""
	
	targetvolume = targetvolume / 100
	var targetvolume_string = str(targetvolume)
	
	if FileAccess.file_exists(filepath):
		if FileAccess.file_exists(templocation):
			print("File already exists:" + templocation)
			var errorcode = DirAccess.remove_absolute(templocation)
			if errorcode == OK:
				print("Deleted:" + templocation)
			else:
				print("Could not delete:" + templocation)
				return(false)
		
		var exit_code = OS.execute(
			ffmpeg_path, 
			[
				"-i"
			] + filepath_split + [
				"-filter:a",
				"\"volume=" + targetvolume_string + "\""
			] + filepath_temp_split,
			output,
			true,#write STDERR to output
			false#open shell; might not be necessary?
		)
		
		if override_source == true:
			var errorcode = DirAccess.remove_absolute(filepath)
			if errorcode == OK:
				print("Deleted:" + filepath)
			else:
				print("Could not delete:" + filepath)
				return(false)
			
			errorcode = DirAccess.copy_absolute(templocation, filepath)
			if errorcode == OK:
				print("Copied:" + templocation + " to " + filepath)
			else:
				print("Could not copy:" + templocation + " to " + filepath)
				return(false)
		return true
	else:
		print("Could not find SourceSound")
		return false

class FilemanagerOptions:
	var aquanox_basepath = ""
	var locale = ""
	var export_basepath = ""

	func ConfigureFilemanagerOptions(basepath: String, game_locale: String, export_path: String):
		#print("LEL")
		self.aquanox_basepath = basepath
		self.locale = game_locale
		self.export_basepath = export_path
		#print("Set aquanox_basepath: " + aquanox_basepath)
		#print("Set locale: " + locale)
		#print("Set export_basepath: " + export_basepath)
		
class FileDataTypes:
	var aquanox_basepath = ""
	var locale = ""
	var export_basepath = ""
	
	func WriteANSIFile(filepath, filecontent):
		#print_debug(filepath)
		#print_debug(filecontent)
		var file = FileAccess.open(filepath, FileAccess.WRITE)
		file.store_string(filecontent)
		file.close()
		var output = []
		#print_debug(Array(filepath.split(" ")))
		#print_debug(["\""] + Array(filepath.split(" ")) + ["\""])
		var filepath_split = Array(filepath.split(" "))
		filepath_split[0] = "\"" + filepath_split[0]
		filepath_split[-1] = filepath_split[-1] + "\""
		var exit_code = OS.execute(
			"C:/Python310/python.exe", 
			[
				"\"D:\\Programme\\Godot\\Aquanox-2-Dialog-Editor-Godot\\encoding_convert.py\"",
				"--file",
			] + filepath_split + [
				"--operation",
				"convert"
			],
			output,
			true,#write STDERR to output
			false#open shell; might not be necessary?
		)
		#print(exit_code)
		#print_debug(output)
		#assert(false, "lel")
		#var line_content = output[0].split("\n")
		#return(output[0])

class Character_List extends FileDataTypes:
	var filepath_des = ""
	var filepath_loc = ""
	var table = {}
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_des = aquanox_basepath + "dat/sty/person.des"
		self.filepath_loc = aquanox_basepath + "dat/sty/" + self.locale + "/person.loc"
		#self.table = {}

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Character.new()
	
	func Export():
		#currenttimepath = time.strftime("%Y-%m-%d-%H-%M")
		#YYYY-MM-DDTHH:MM:SS
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_des = self.export_basepath + currenttimepath + "/dat/sty/person.des"
		var outputpath_loc = self.export_basepath + currenttimepath + "/dat/sty/" + self.locale + "/person.loc"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")
		error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/" + self.locale)
		if error != OK:
			printerr("Failure!")

		var output_des = "[Table]\n"
		output_des += "{\n"
		output_des += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_des += "    [" + entry + "]\n"
			output_des += "    {\n"
			if char.Comment_des != "NO .DES COMMENT":
				output_des += "        //" + char.Comment_des + "\n"
			output_des += "        Key = " + str(char.Key) + "\n"
			output_des += "        ImageElf = \"" + char.ImageElf + "\"\n"
			output_des += "        ImageMood0 = \"" + char.ImageMood0 + "\"\n"
			output_des += "        Sex = \"" + char.Sex + "\"\n"
			output_des += "    }\n"
			output_des += "\n"
		output_des += "}\n"

		var output_loc = "[Table]\n"
		output_loc += "{\n"
		output_loc += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_loc += "    [" + entry +"]\n"
			output_loc += "    {\n"
			if char.Comment_loc != "NO .LOC COMMENT":
				output_loc += "        //" + char.Comment_des + "\n"
			output_loc += "        Key = " + str(char.Key) + "\n"
			output_loc += "        Name = \"" + char.Name + "\"\n"
			output_loc += "        ShortName = \"" + char.ShortName + "\"\n"
			output_loc += "    }\n"
			output_loc += "\n"
		output_loc += "}\n"
		WriteANSIFile(outputpath_des, output_des)
		WriteANSIFile(outputpath_loc, output_loc)

class Character extends FileDataTypes:
	var Key = -1
	var ImageElf = "-1"
	var ImageElfPath = "-1"
	var ImageMood0 = "-1"
	var ImageMood0Path = "-1"
	var Sex = "-1"
	var Name = "-1"
	var ShortName = "-1"
	var Comment_des = "NO .DES COMMENT"
	var Comment_loc = "NO .LOC COMMENT"

	func Print():
		print("Key: " + str(self.Key))
		print("ImageElf: " + self.ImageElf)
		print("ImageElfPath: " + self.ImageElfPath)
		print("ImageMood0: " + self.ImageMood0)
		print("ImageMood0Path: " + self.ImageMood0Path)
		print("Sex: " + self.Sex)
		print("Name: " + self.Name)
		print("ShortName: " + self.ShortName)
		print("Comment_des: " + self.Comment_des)
		print("Comment_loc: " + self.Comment_loc)

func ParseCharacters(listobj):
	var file_des = ""
	var file_loc = ""
	#if listobj.filepath_des != "" or listobj.filepath_loc != "":
		#file_des = open(listobj.filepath_des, 'r')
		#file_loc = open(listobj.filepath_loc, 'r')
	file_des = ReadANSIFile(listobj.filepath_des)
	#print_debug(file_des)
	file_loc = ReadANSIFile(listobj.filepath_loc)

	#var Lines = file_des.readlines()
	var Lines = file_des.split("\n")
	var readstate = "TableStart"
	var tempchar = Character.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if "ImageElf = " in line:
				tempchar.ImageElf = line.split("\"")[1]
				if len(line.split("\"")[1]) > 0:
					tempchar.ImageElfPath = listobj.aquanox_basepath + line.split("\"")[1]
			if "ImageMood0 = " in line:
				tempchar.ImageMood0 = line.split("\"")[1]
				if len(line.split("\"")[1]) > 0:
					tempchar.ImageMood0Path = listobj.aquanox_basepath + line.split("\"")[1]
			if "Sex = " in line:
				tempchar.Sex = line.split("\"")[1]
			if line == "}":
				listobj.table[entryname] = tempchar
				if tempchar.ImageElfPath == "-1":
					tempchar.ImageElfPath = listobj.aquanox_basepath + "no_file_path"
				if tempchar.ImageMood0Path == "-1":
					tempchar.ImageMood0Path = listobj.aquanox_basepath + "no_file_path"
				tempchar = Character.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue
	#print_debug(listobj.table)
	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")
	#print_debug(listobj.table)
	#file_des.close()
	
	Lines = file_loc.split("\n")
	readstate = "TableStart"
	tempchar = Character.new()#Object will not be used
	entryname = ""
	var tempcomment = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				tempchar = listobj.table[entryname]
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				if tempchar.Key == -1:
					tempcomment = line.split("/")[2]
				else:
					tempchar.Comment_loc = line.split("/")[2] #Needed if table number is not stable
			if "Key = " in line:
				var key = int(line.split(" ")[2])
				if key != tempchar.Key:
					print(tempchar)
					print(key)
					assert(false, "Key in Tablekey in .loc does not match Key in Tablekey in .des")
			if "Name = " in line:
				tempchar.Name = line.split("\"")[1]
			if "ShortName = " in line:
				tempchar.ShortName = line.split("\"")[1]
			if line == "}":
				#listobj.table[entryname] = tempchar # Not needed as the object is already in the list
				tempchar = Character.new()
				entryname = ""
				tempcomment = ""
				readstate = "SearchTableEntry"
				continue

func AddNewCharacter(listobj, lasttablekey, lastkey):
	var tempchar = Character.new()
	tempchar.Key = lastkey + 1
	tempchar.ImageElf = ""
	tempchar.ImageElfPath = "-1"
	tempchar.ImageMood0 = ""
	tempchar.ImageMood0Path = "-1"
	tempchar.Sex = "male"
	tempchar.Name = "New Entry"
	tempchar.ShortName = "New Short Entry"
	tempchar.Comment_des = "NO .DES COMMENT"
	tempchar.Comment_loc = "NO .LOC COMMENT"
	listobj.table["Person" + str(lasttablekey + 1)] = tempchar
	

class Room_List extends FileDataTypes:
	var filepath_des = ""
	var table = {}
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_des = aquanox_basepath + "dat/sty/room.des"

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Room.new()

	func Export():	
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_des = self.export_basepath + currenttimepath + "/dat/sty/room.des"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")

		var output_des = "[Table]\n"
		output_des += "{\n"
		output_des += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_des += "    [" + entry + "]\n"
			output_des += "    {\n"
			if char.Comment_des != "NO .DES COMMENT":
				output_des += "        //" + char.Comment_des + "\n"
			output_des += "        Key = " + str(char.Key) + "\n"
			output_des += "        Station = " + str(char.Station) + "\n"
			output_des += "        Sound = \"" + char.Sound +  "\"\n"
			output_des += "    }\n"
			output_des += "\n"
		output_des += "}\n"
		#print(output_des)
		WriteANSIFile(outputpath_des, output_des)

class Room extends FileDataTypes:
	var Key = -1
	var Station = -1
	var Sound = "-1"
	var SoundPath = "-1"
	var Comment_des = "NO .DES COMMENT"

	func Print():
		print("Key: " + str(self.Key))
		print("Station: " + str(self.Station))
		print("Sound: " + self.Sound)
		print("SoundPath: " + self.SoundPath)
		print("Comment_des: " + self.Comment_des)

func ParseRooms(listobj):
	var file_des = ""
	file_des = ReadANSIFile(listobj.filepath_des)
	var Lines = file_des.split("\n")
	var readstate = "TableStart"
	var tempchar = Room.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if "Station = " in line:
				tempchar.Station = int(line.split(" ")[2])
			if "Sound = " in line:
				tempchar.Sound = line.split("\"")[1]
				tempchar.SoundPath = aquanox_basepath + line.split("\"")[1].left(-4) + ".wav"
				tempchar.SoundPath = tempchar.SoundPath.replace("\\", "/")
			if line == "}":
				listobj.table[entryname] = tempchar
				tempchar = Room.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue

	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")

class Ship_List extends FileDataTypes:
	var filepath_loc = ""
	var table = {}
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_loc = aquanox_basepath + "dat/sty/" + self.locale + "/ship.loc"
		self.table = {}

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Ship.new()

	func Export():
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_loc = self.export_basepath + currenttimepath + "/dat/sty/" + self.locale + "/ship.loc"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")
		error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/" + self.locale)
		if error != OK:
			printerr("Failure!")

		var output_loc = "[Table]\n"
		output_loc += "{\n"
		output_loc += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_loc += "    [" + entry + "]\n"
			output_loc += "    {\n"
			if char.Comment_loc != "NO .LOC COMMENT":
				output_loc += "        //" + char.Comment_loc + "\n"
			output_loc += "        Key = " + str(char.Key) + "\n"
			output_loc += "        Name = \"" + char.Name + "\"\n"
			output_loc += "        RewardName = \"" + char.RewardName + "\"\n"
			output_loc += "        ShortDescription = \"" + char.ShortDescription + "\"\n"
			output_loc += "        Info = \"" + char.Info + "\"\n"
			output_loc += "    }\n"
			output_loc += "\n"
		output_loc += "}\n"
		#print(output_loc)
		WriteANSIFile(outputpath_loc, output_loc)

class Ship extends FileDataTypes:
	var Key = -1
	var Name = "-1"
	var RewardName = "-1"
	var ShortDescription = "-1"
	var Info = "-1"
	var Comment_loc = "NO .LOC COMMENT"

	func Print():
		print("Key: " + str(self.Key))
		print("Name: " + self.Name)
		print("RewardName: " + self.RewardName)
		print("ShortDescription: " + self.ShortDescription)
		print("Info: " + self.Info)
		print("Comment_des: " + self.Comment_des)

func ParseShips(listobj):
	var file_loc = ""
	file_loc = ReadANSIFile(listobj.filepath_loc)
	var Lines = file_loc.split("\n")
	var readstate = "TableStart"
	var tempchar = Ship.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if "Name = " in line and "RewardName = " not in line:
				tempchar.Name = line.split("\"")[1]
			if "RewardName = " in line:
				tempchar.RewardName = line.split("\"")[1]
			if "ShortDescription = " in line:
				tempchar.ShortDescription = line.split("\"")[1]
			if "Info = " in line:
				tempchar.Info = line.split("\"")[1]
			if line == "}":
				listobj.table[entryname] = tempchar
				tempchar = Ship.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue

	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")

class Mood_List extends FileDataTypes:
	var filepath_des = ""
	var table = {}
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_des = aquanox_basepath + "dat/sty/mood.des"
		

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Mood.new()

	func Export():
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_des = self.export_basepath + currenttimepath + "/dat/sty/mood.des"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")

		var output_des = "[Table]\n"
		output_des += "{\n"
		output_des += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_des += "\t[" + entry + "]\n"
			output_des += "\t{\n"
			if char.Comment_des != "NO .DES COMMENT":
				output_des += "\t\t//" + char.Comment_des + "\n"
			output_des += "\t\tKey = " + str(char.Key) + "\n"
			output_des += "\t}\n"
			output_des += "\n"
		output_des += "}\n"
		#print(output_des)
		WriteANSIFile(outputpath_des, output_des)

class Mood extends FileDataTypes:
	var Key = -1
	var Comment_des = "NO .DES COMMENT"

	func Print():
		print("Key: " + self.Key)
		print("Comment_des: " + self.Comment_des)

func ParseMoods(listobj):	
	var file_des = ""
	file_des = ReadANSIFile(listobj.filepath_des)
	var Lines = file_des.split("\n")
	var readstate = "TableStart"
	var tempchar = Mood.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if line == "}":
				listobj.table[entryname] = tempchar
				tempchar = Mood.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue

	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")

class Sdialog_List extends FileDataTypes:
	var filepath_des = ""
	var table = {}
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_des = aquanox_basepath + "dat/sty/sdialog.des"
		

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Sdialog.new()

	func Export():
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_des = self.export_basepath + currenttimepath + "/dat/sty/sdialog.des"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")

		var output_des = "[Table]\n"
		output_des += "{\n"
		output_des += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_des += "    [" + entry + "]\n"
			output_des += "    {\n"
			if char.Comment_des != "NO .DES COMMENT":
				output_des += "        //" + char.Comment_des + "\n"
			output_des += "        Key = " + str(char.Key) + "\n"
			output_des += "        Type = \"" + char.Type + "\"\n"
			output_des += "        Room = " + str(char.Room) + "\n"
			output_des += "    }\n"
			output_des += "\n"
		output_des += "}\n"
		#print(output_des)
		WriteANSIFile(outputpath_des, output_des)

class Sdialog extends FileDataTypes:
	var Key = -1
	var Type = "-1"
	var Room = -1
	var Comment_des = "NO .DES COMMENT"

	func Print():
		print("Key: " + str(self.Key))
		print("Type: " + self.Type)
		print("Room: " + str(self.Room))
		print("Comment_des: " + self.Comment_des)

func ParseSdialogs(listobj):
	var file_des = ""
	file_des = ReadANSIFile(listobj.filepath_des)
	var Lines = file_des.split("\n")
	var readstate = "TableStart"
	var tempchar = Sdialog.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if "Type = " in line:
				tempchar.Type = line.split("\"")[1]
			if "Room = " in line:
				tempchar.Room = int(line.split(" ")[2])
			if line == "}":
				listobj.table[entryname] = tempchar
				tempchar = Sdialog.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue

	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")

class Stake_List extends FileDataTypes:
	var filepath_des = ""
	var filepath_loc = ""
	var table = {}
	var last_key = -1
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_des = aquanox_basepath + "dat/sty/stake.des"
		self.filepath_loc = aquanox_basepath + "dat/sty/" + self.locale + "/stake.loc"

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Stake.new()

	func GetDialogeStakeEntrys(key: int):
		var stake_list = []
		#print(f"ProvidedKey:{key}")
		for table_entry in self.table:
			if self.table[table_entry].Dialog == key:
				stake_list.append(self.table[table_entry])
		return stake_list

	func Export():		
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_des = self.export_basepath + currenttimepath + "/dat/sty/stake.des"
		var outputpath_loc = self.export_basepath + currenttimepath + "/dat/sty/" + self.locale + "/stake.loc"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")
		error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/" + self.locale)
		if error != OK:
			printerr("Failure!")

		var output_des = "[Table]\n"
		output_des += "{\n"
		output_des += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_des += "    [" + entry + "]\n"
			output_des += "    {\n"
			if char.Comment_des != "NO .DES COMMENT":
				output_des += "        //" + char.Comment_des + "\n"
			output_des += "        Key = " + str(char.Key) + "\n"
			output_des += "        Dialog = " + str(char.Dialog) + "\n"
			output_des += "        Person = " + str(char.Person) + "\n"
			output_des += "        Wav = \"" + char.Wav + "\"\n"
			output_des += "        Mood = " + str(char.Mood) + "\n"
			output_des += "    }\n"
			output_des += "\n"
		output_des += "}\n"
		#print(output_des)

		var output_loc = "[Table]\n"
		output_loc += "{\n"
		output_loc += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_loc += "    [" + entry + "]\n"
			output_loc += "    {\n"
			if char.Comment_loc != "NO .LOC COMMENT":
				output_loc += "        //" + char.Comment_des + "\n"
			output_loc += "        Key = " + str(char.Key) + "\n"
			output_loc += "        Text = \"" + char.Text + "\"\n"
			output_loc += "    }\n"
			output_loc += "\n"
		output_loc += "}\n"
		#print(output_loc)
		WriteANSIFile(outputpath_des, output_des)
		WriteANSIFile(outputpath_loc, output_loc)

class Stake extends FileDataTypes:
	var Key = -1
	var Dialog = -1
	var Person = -1
	var Text = ""
	var Wav = "-1"
	var WavPath = "-1"
	var Mood = -1
	var Comment_des = "NO .DES COMMENT"
	var Comment_loc = "NO .LOC COMMENT"

	func Print():
		print("Key: " + str(self.Key))
		print("Dialog: " + str(self.Dialog))
		print("Person: " + str(self.Person))
		print("Text: " + self.Text)
		print("Wav: " + self.Wav)
		print("WavPath: " + self.WavPath)
		print("Mood: " + str(self.Mood))
		print("Comment_des: " + self.Comment_des)
		print("Comment_loc: " + self.Comment_loc)

func ParseStakes(listobj):
	var file_des = ""
	var file_loc = ""
	#if listobj.filepath_des != "" or listobj.filepath_loc != "":
		#file_des = open(listobj.filepath_des, 'r')
		#file_loc = open(listobj.filepath_loc, 'r')
	file_des = ReadANSIFile(listobj.filepath_des)
	#print_debug(file_des)
	file_loc = ReadANSIFile(listobj.filepath_loc)

	#var Lines = file_des.readlines()
	var Lines = file_des.split("\n")
	var readstate = "TableStart"
	var tempchar = Stake.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if "Dialog = " in line:
				tempchar.Dialog = int(line.split(" ")[2])
			if "Person = " in line:
				tempchar.Person = int(line.split(" ")[2])
			if "Wav = " in line:
				tempchar.Wav = line.split("\"")[1]
				if len(line.split("\"")[1]) > 0:
					tempchar.WavPath = aquanox_basepath + "sfx/speech/" + locale + "/" + line.split("\"")[1] + ".ogg"
					tempchar.WavPath = tempchar.WavPath.replace("\\", "/")
			if "Mood = " in line:
				tempchar.Mood = int(line.split(" ")[2])
			if line == "}":
				listobj.table[entryname] = tempchar
				tempchar = Stake.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue

	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")

	Lines = file_loc.split("\n")
	readstate = "TableStart"
	tempchar = Stake.new()#Object will not be used
	entryname = ""
	var tempcomment = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				tempchar = listobj.table[entryname]
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				if tempchar.Key == -1:
					tempcomment = line.split("/")[2]
				else:
					tempchar.Comment_loc = line.split("/")[2] #Needed if table number is not stable
			if "Key = " in line:
				var key = int(line.split(" ")[2])
				if key != tempchar.Key:
					print("Key in Tablekey in .loc does not match Key in Tablekey in .des")
					print(tempchar)
					print(key)
					assert(false,"Key in Tablekey in .loc does not match Key in Tablekey in .des")
			if "Text = " in line:
				#print_debug(line.split("\""))
				tempchar.Text = line.split("\"")[1]
			if line == "}":
				#listobj.table[entryname] = tempchar # Not needed as the object is already in the list
				tempchar = Stake.new()
				entryname = ""
				tempcomment = ""
				readstate = "SearchTableEntry"
				continue

func MtakeDictCreate():
	for missionentry in missioninfolist:
		var filename = missionentry[0]
		var mtakelist = Mtake_List.new(FileOptions)
		mtakelist.filepath_des = mtakelist.filepath_des + filename + ".des"
		mtakelist.filepath_loc = mtakelist.filepath_loc + filename + ".loc"
		mtakelist.filename = filename
		mtakelist.missionname = missionentry[1]
		mtakelist.missiondescription = missionentry[2]
		ParseMtakes(mtakelist)
		mtakedict[filename] = mtakelist
	
func MtakeDictExport():
	for key in mtakedict.keys():
		mtakedict[key].Export()

class Mtake_List extends FileDataTypes:
	var filepath_des = ""
	var filepath_loc = ""
	var table = {}
	var last_key = -1
	var filename = ""
	var missionname = ""
	var missiondescription = ""
	
	func _init(FileOptions):
		self.aquanox_basepath = FileOptions.aquanox_basepath
		self.locale = FileOptions.locale
		self.export_basepath = FileOptions.export_basepath
		self.filepath_des = aquanox_basepath + "dat/sty/"
		self.filepath_loc = aquanox_basepath + "dat/sty/" + self.locale + "/"

	func GetObjectwithKey(key: int):
		#print(f"ProvidedKey:{key}")
		if not self.table.is_empty():
			for table_entry in self.table:
				if self.table[table_entry].Key == key:
					return self.table[table_entry]
		else:
			return Mtake.new()

	func Export():		
		var currenttimepath = Time.get_datetime_string_from_system().replace(":","-").left(-3)
		var outputpath_des = self.export_basepath + currenttimepath + "/dat/sty/" + filename + ".des"
		var outputpath_loc = self.export_basepath + currenttimepath + "/dat/sty/" + self.locale + "/" + filename + ".loc"

		var error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/")
		if error != OK:
			printerr("Failure!")
		error = DirAccess.make_dir_recursive_absolute(self.export_basepath + currenttimepath + "/dat/sty/" + self.locale)
		if error != OK:
			printerr("Failure!")

		var output_des = "[Table]\n"
		output_des += "{\n"
		output_des += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_des += "    [" + entry + "]\n"
			output_des += "    {\n"
			if char.Comment_des != "NO .DES COMMENT":
				output_des += "        //" + char.Comment_des + "\n"
			output_des += "        Key = " + str(char.Key) + "\n"
			output_des += "        Person = " + str(char.Person) + "\n"
			output_des += "        Wav = \"" + char.Wav + "\"\n"
			output_des += "        Mood = " + str(char.Mood) + "\n"
			output_des += "    }\n"
			output_des += "\n"
		output_des += "}\n"
		#print(output_des)

		var output_loc = "[Table]\n"
		output_loc += "{\n"
		output_loc += "\n"

		for entry in self.table.keys():
			var char = self.table[entry]
			output_loc += "    [" + entry + "]\n"
			output_loc += "    {\n"
			if char.Comment_loc != "NO .LOC COMMENT":
				output_loc += "        //" + char.Comment_des + "\n"
			output_loc += "        Key = " + str(char.Key) + "\n"
			output_loc += "        Text = \"" + char.Text + "\"\n"
			output_loc += "    }\n"
			output_loc += "\n"
		output_loc += "}\n"
		#print(output_loc)
		WriteANSIFile(outputpath_des, output_des)
		WriteANSIFile(outputpath_loc, output_loc)

class Mtake extends FileDataTypes:
	var Key = -1
	var Person = -1
	var Text = ""
	var Wav = "-1"
	var WavPath = "-1"
	var Mood = -1
	var Comment_des = "NO .DES COMMENT"
	var Comment_loc = "NO .LOC COMMENT"

	func Print():
		print("Key: " + str(self.Key))
		print("Person: " + str(self.Person))
		print("Text: " + self.Text)
		print("Wav: " + self.Wav)
		print("WavPath: " + self.WavPath)
		print("Mood: " + str(self.Mood))
		print("Comment_des: " + self.Comment_des)
		print("Comment_loc: " + self.Comment_loc)

func ParseMtakes(listobj):
	var file_des = ""
	var file_loc = ""
	#if listobj.filepath_des != "" or listobj.filepath_loc != "":
		#file_des = open(listobj.filepath_des, 'r')
		#file_loc = open(listobj.filepath_loc, 'r')
	file_des = ReadANSIFile(listobj.filepath_des)
	#print_debug(file_des)
	file_loc = ReadANSIFile(listobj.filepath_loc)

	#var Lines = file_des.readlines()
	var Lines = file_des.split("\n")
	var readstate = "TableStart"
	var tempchar = Mtake.new()
	var entryname = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				tempchar.Comment_des = line.split("/")[2]
			if "Key = " in line:
				tempchar.Key = int(line.split(" ")[2])
			if "Person = " in line:
				tempchar.Person = int(line.split(" ")[2])
			if "Wav = " in line:
				tempchar.Wav = line.split("\"")[1]
				if len(line.split("\"")[1]) > 0:
					tempchar.WavPath = aquanox_basepath + "sfx/speech/" + locale + "/" + line.split("\"")[1] + ".ogg"
					tempchar.WavPath = tempchar.WavPath.replace("\\", "/")
			if "Mood = " in line:
				tempchar.Mood = int(line.split(" ")[2])
			if line == "}":
				listobj.table[entryname] = tempchar
				tempchar = Mtake.new()
				entryname = ""
				readstate = "SearchTableEntry"
				continue

	if entryname != "":
		assert(false,"Current TableEntry was not closed")
	if readstate != "TableClosed":
		assert(false,"Search did not find closing bracket")

	Lines = file_loc.split("\n")
	readstate = "TableStart"
	tempchar = Stake.new()#Object will not be used
	entryname = ""
	var tempcomment = ""
	for line in Lines:
		line = line.strip_edges()
		if len(line) == 0: #Empty Line
			continue
		if readstate == "TableStart":#Search for [Table]
			if "[Table]" in line:
				readstate = "TableOpen"
				continue
		if readstate == "TableOpen":#Search for { after [Table]
			if line == "{":
				readstate = "SearchTableEntry"
				continue
		if readstate == "SearchTableEntry":#Search for [
			if line[0] == "[":
				line = line.split("[")[1]
				line = line.split("]")[0]
				entryname = line
				tempchar = listobj.table[entryname]
				readstate = "TableEntryOpen"
				continue
		if readstate == "SearchTableEntry":#Search for last }
			if line[0] == "}":
				readstate = "TableClosed"
				break#End
		if readstate == "TableEntryOpen":
			if line == "{":
				readstate = "TableEntryData"
				continue
		if readstate == "TableEntryData":
			if "//" in line:
				if tempchar.Key == -1:
					tempcomment = line.split("/")[2]
				else:
					tempchar.Comment_loc = line.split("/")[2] #Needed if table number is not stable
			if "Key = " in line:
				var key = int(line.split(" ")[2])
				if key != tempchar.Key:
					print("Key in Tablekey in .loc does not match Key in Tablekey in .des")
					print(tempchar)
					print(key)
					assert(false,"Key in Tablekey in .loc does not match Key in Tablekey in .des")
			if "Text = " in line:
				#print_debug(line.split("\""))
				tempchar.Text = line.split("\"")[1]
			if line == "}":
				#listobj.table[entryname] = tempchar # Not needed as the object is already in the list
				tempchar = Stake.new()
				entryname = ""
				tempcomment = ""
				readstate = "SearchTableEntry"
				continue
