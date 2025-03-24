class_name Question

var answers: Dictionary[String, Answer]

var frecuency_total: int

func add_answer(name: String):
	if answers.has(name):
		answers[name].add_frecuency()
		return
	var answer = Answer.new(name, self)
	answers[name] = answer

func get_table() -> String:
	var text: String = "[table=4]"
	text += "[cell]x[/cell][cell]|f[/cell][cell]|fr[/cell][cell]|fp[/cell]"
	for a in answers:
		text += "[cell]" + a + "[/cell]"
		text += "[cell]|" + str(answers[a].frecuency) + "[/cell]"
		text += "[cell]|" + String.num(answers[a].frecuency_relative, 2) + "[/cell]"
		text += "[cell]|" + String.num(answers[a].frecuency_porcent, 2) + "[/cell]"
	text += "[cell][/cell][cell]|" + str(frecuency_total) + "[/cell][cell]|[/cell][cell]|[/cell]"
	text += "[/table]"
	return text

func calculate():
	set_frecuency_total()
	for a in answers:
		answers[a].calculate()

func set_frecuency_total():
	for a in answers:
		frecuency_total += answers[a].frecuency
