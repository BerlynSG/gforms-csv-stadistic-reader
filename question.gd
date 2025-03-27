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
		answers[name].add_frecuency()
		return
	var answer = Answer.new(name, self)
	answers[name] = answer

func get_table() -> String:
	var text: String = "[table=7]"
	text += "[cell]Optiones[/cell][cell]|x[/cell]
	[cell]|f[/cell][cell]|fr[/cell][cell]|fp[/cell][cell]|F[/cell][cell]|xf[/cell]"
	var n = 1
	[cell]|f[/cell][cell]|fr[/cell][cell]|fp[/cell][cell]|F[/cell]"
	#var n = 1
	var fr_total: float = 0
	var fp_total: float = 0
	for a in answers:
		text += "[cell]" + a + "[/cell]"
		text += "[cell]|" + str(n) + "[/cell]"
		n += 1
		text += "[cell]|" + str(answers[a].frecuency) + "[/cell]"
		text += "[cell]|" + str(answers[a].frecuencia) + "[/cell]"
		text += "[cell]|" + String.num(answers[a].frecuencia_relativa, 2) + "[/cell]"
	text += "[cell][/cell][cell]|[/cell]
	[cell]|" + str(frecuencia_total) + "[/cell]
	[cell]|" + str(fr_total) + "[/cell][cell]|" + str(fp_total) + "%[/cell]]
	[cell]|[/cell][cell]|" + str(xf_total) + "[/cell]"
	text += "[/table]"
	text += "\nMedia = " + String.num(media, 2)
	text += "\nMediana = " + str(mediana1)
	if mediana1 != mediana2:
		text += ", " + str(mediana2)
	text += "\nModa = " + str(moda)
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
