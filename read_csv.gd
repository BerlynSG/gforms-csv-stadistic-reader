extends Node

@export var file_dialog: FileDialog
@export var rich_text_label: RichTextLabel
@export var file_label: Label

var csv: Dictionary[String, Question]

func load_csv(path: String, delim := ","):
	csv.clear()
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	var questions = file.get_csv_line(delim)
	for question in questions:
		csv[question] = Question.new()
	
	while file.get_position() < file.get_length():
		var line = file.get_csv_line(delim)
		for l in line.size():
			if l == 0: continue
			var question: Question = csv.values()[l]
			question.add_answer(line[l])
	file.close()

func _on_load_button_pressed() -> void:
	file_dialog.visible = true


func _on_file_dialog_file_selected(path: String) -> void:
	load_csv(path)
	var text: String
	for q in csv:
		if q == csv.keys()[0]: continue
		csv[q].calculate()
		text += "----------------------------------------"
		text += q + ":\n"
		text += csv[q].get_table()
		text += "\n"
	rich_text_label.clear()
	rich_text_label.append_text(text)
	file_label.text = path
