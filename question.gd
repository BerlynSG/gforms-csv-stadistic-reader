class_name Question

var answers: Dictionary[String, Answer]

var frecuencia_total: int
var frecuencia_porcentual_total: float

func add_answer(name: String):
	if answers.has(name):
		answers[name].add_frecuencia()
		return
	var answer = Answer.new(name, self)
	answers[name] = answer

func get_table() -> String:
	var text: String = "[table=5]"
	const table_row = "[cell]{0}[/cell][cell]|{1}[/cell][cell]|{2}[/cell][cell]|{3}[/cell][cell]|{4}[/cell]"
	text += table_row.format(["Opciones", "f", "F", "fp", "Fp"])
	for a in answers:
		text += table_row.format([a, answers[a].frecuencia, answers[a].frecuencia_acumulada, String.num(answers[a].frecuencia_porcentual, 2) + "%", String.num(answers[a].frecuencia_porcentual_acumulada, 2) + "%"])
	text += table_row.format(["", frecuencia_total, "", String.num(frecuencia_porcentual_total, 2) + "%", ""])
	text += "[/table]"
	return text

func calculate():
	set_frecuencia_total()
	for a in answers:
		answers[a].calculate()
	set_frecuencia_porectual_total()

func set_frecuencia_total():
	for a in answers:
		var answer: Answer = answers[a]
		frecuencia_total += answer.frecuencia
		answer.frecuencia_acumulada = frecuencia_total

func set_frecuencia_porectual_total():
	for a in answers:
		var answer: Answer = answers[a]
		frecuencia_porcentual_total += answer.frecuencia_porcentual
		answer.frecuencia_porcentual_acumulada = frecuencia_porcentual_total
