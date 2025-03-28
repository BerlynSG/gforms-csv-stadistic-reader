class_name Question

var answers: Dictionary[String, Answer]

var frecuencia_total: int

func add_answer(name: String):
	if answers.has(name):
		answers[name].add_frecuencia()
		return
	var answer = Answer.new(name, self)
	answers[name] = answer

func get_table() -> String:
	var text: String = "[table=4]"
	const table_row = "[cell]{0}[/cell][cell]|{1}[/cell][cell]|{2}[/cell][cell]|{3}[/cell]"
	text += table_row.format(["Opciones", "f", "fp", "F"])
	var fp_total: float = 0
	for a in answers:
		text += table_row.format([a, answers[a].frecuencia, String.num(answers[a].frecuencia_porcentual, 2), answers[a].frecuencia_acumulada])
		fp_total += answers[a].frecuencia_porcentual
	text += table_row.format(["", frecuencia_total, String.num(fp_total, 2), ""])
	text += "[/table]"
	return text

func calculate():
	set_frecuencia_total()
	for a in answers:
		answers[a].calculate()

func set_frecuencia_total():
	for a in answers:
		var answer: Answer = answers[a]
		frecuencia_total += answer.frecuencia
		answer.frecuencia_acumulada = frecuencia_total
