extends Label

@onready var timer = $Timer
@onready var gm = $"../../.."

var currTxt = ""
var currIndex = 0
var isInput = false
var promptValues = []
var focusIndex = 0
var npc = null


var keyWords = ["p", "m", "i"]


func getTextFromKeyword(keyword:String):
	if keyword == "p":
		return gm.playerName
	elif keyword[0] == "m":
		if isInput:#if we are setting the prompts, always take the end
			promptValues[-1].msgId = keyword.to_int()
		else:
			npc.msgIndex = keyword.to_int()
			npc.lineIndex = -1

	elif keyword[0] == "i":
		var n = keyword.to_int()
		isInput = true
		promptValues = []
		currTxt = ""
		var prompts = npc.dialogFile.data["EN_US"]["prompts"][n]
		for i in range(len(prompts)):
			var val = PromptValue.new()
			val.charPos = len(currTxt)
			promptValues.push_back(val)
			currTxt +=" "+ processText(prompts[i]) + "\n"
	return ""

func processText(txt):
	var out = ""
	var currWord
	var seekingWord = false #has there been a $ sign
	for v in txt:
		if v == "$":
			if seekingWord:
				assert(currWord[0] in keyWords)
				seekingWord = false
				out += getTextFromKeyword(currWord)
			else:
				seekingWord = true
				currWord = ""
		elif seekingWord:
			currWord += v
		else:
			out += v
	return out

func displayText(npc):
	self.npc = npc
	if not isInput:
		text = ""
		var buff = processText(npc.getMessage())
		if buff != "":
			currTxt = buff
		currIndex = 0
		text = ""
		currIndex = 0
		timer.start()

func _input(event: InputEvent) -> void:

	if promptValues.size() != 0 and timer.is_stopped():
		text[promptValues[focusIndex].charPos] = " "
		if event.is_action_pressed("up"):
			focusIndex -= 1
			focusIndex= focusIndex%promptValues.size()
		elif event.is_action_pressed("down"):
			focusIndex += 1
			focusIndex= focusIndex%promptValues.size()
		elif event.is_action_pressed("interact") and isInput:
			npc.msgIndex = promptValues[focusIndex].msgId
			npc.lineIndex = -1
			promptValues = []
			isInput = false
	if promptValues.size() != 0 and timer.is_stopped():
		text[promptValues[focusIndex].charPos] = "-"

		
		
		
func addChar():
	if currIndex == currTxt.length():
		timer.stop()
	else:
		text += currTxt[currIndex]
		currIndex += 1
