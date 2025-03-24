class_name Answer

var name: String
var question: Question

var x: int = 0
var frecuency: int = 0
var frecuency_relative: float
var frecuency_porcent: float
var frecuency_absolute: int

var xf: int

func _init(name: String, question: Question) -> void:
	self.name = name
	self.question = question
	frecuency = 1
	

func add_frecuency():
	frecuency += 1

func calculate():
	frecuency_relative = float(frecuency) / question.frecuency_total
	frecuency_porcent = frecuency_relative * 100
