class_name Answer

var name: String
var question: Question

var frecuencia: int = 0
var frecuencia_relativa: float
var frecuencia_porcentual: float
var frecuencia_acumulada: int

func _init(name: String, question: Question) -> void:
	self.name = name
	self.question = question
	frecuencia = 1

func add_frecuencia():
	frecuencia += 1

func calculate():
	frecuencia_relativa = float(frecuencia) / question.frecuencia_total
	frecuencia_porcentual = frecuencia_relativa * 100
