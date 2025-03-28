class_name Question

var answers: Dictionary[String, Answer]

var frecuencia_total: int
var xf_total: int
var media: float
var mediana1: int
var mediana2: int
var moda: int

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
	set_mediana()
	set_moda()
	if frecuencia_total != 0:
		media = float(xf_total) / frecuencia_total

	var x: int = 1
func set_frecuencia_total():
	for a in answers:
		var answer: Answer = answers[a]
		frecuencia_total += answer.frecuencia
		answer.frecuencia_acumulada = frecuencia_total
		#answer.x = x
		#answer.xf = x * answer.frecuencia
		#xf_total += answer.xf
		#x += 1

func set_mediana():
	var pos = 0
	if frecuencia_total % 2 == 0:
		pos = frecuencia_total/2
		var x1 = 0
		var x2 = 0
		for a in answers:
			if pos <= answers[a].frecuencia_acumulada && x1 == 0:
				x1 = answers[a].x
			if pos <= answers[a].frecuencia_acumulada && x2 == 0:
				x2 = answers[a].x
			if x1 != 0 && x2 != 0: break
		mediana1 = x1
		mediana2 = x2
	else:
		pos = (frecuencia_total + 1)/2
		var x = 0
		for a in answers:
			if pos <= answers[a].frecuencia_acumulada && x == 0:
				x = answers[a].x
			if x != 0: break
		mediana1 = x
		mediana2 = x

func set_moda():
	var m = 0
	for a in answers.size():
		if answers[answers.keys()[m]].frecuencia < answers[answers.keys()[a]].frecuencia:
			m = a
	moda = m + 1
