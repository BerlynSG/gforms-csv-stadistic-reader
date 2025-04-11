extends Node

@export var version_label: Label
@export var file_dialog: FileDialog
@export var rich_text_label: RichTextLabel
@export var file_label: Label
@export var save_button: Button
@export var save_file_dialog: FileDialog

var csv: Dictionary[String, Question]

func _ready() -> void:
	version_label.text = "Versión: " + ProjectSettings.get_setting("application/config/version", "")

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

func save_csv(path: String, delim := ","):
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	const empty_line = ["", "", "", "", ""]
	const table_header = ["Opciones", "f", "F", "fp", "Fp"]
	
	for question in csv:
		var question_data := csv[question]
		file.store_csv_line(empty_line, delim)
		file.store_csv_line(empty_line, delim)
		file.store_csv_line([question, "", "", "", ""], delim)
		file.store_csv_line(empty_line, delim)
		file.store_csv_line(table_header, delim)
		for answer in question_data.answers:
			var answer_data := question_data.answers[answer]
			file.store_csv_line([answer, answer_data.frecuencia, answer_data.frecuencia_acumulada, String.num(answer_data.frecuencia_porcentual, 2) + "%", String.num(answer_data.frecuencia_porcentual_acumulada, 2) + "%"], delim)
		file.store_csv_line(["", question_data.frecuencia_total, "", String.num(question_data.frecuencia_porcentual_total, 2) + "%", ""], delim)
	
	file.close()

func _on_load_button_pressed() -> void:
	file_dialog.visible = true

func _on_save_button_pressed() -> void:
	save_file_dialog.visible = true

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
	save_button.visible = true

func _on_save_file_dialog_file_selected(path: String) -> void:
	save_csv(path)
