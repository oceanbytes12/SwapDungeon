extends Control

@export var Mimic : Control
@export var MimicButton : TextureButton
@export var RerollButton : Button
var targetMimicAlpha : float = 0
var targetRerollAlpha : float = 0
var displayedText = 10
var textspeed = 15
var Selected
var money = 10
var rerollcost = 1
var fade_duration = 0.2
var PartyCount = 0
signal rerolled

func _ready():
	HeroUiController.moneyManager = self
	Mimic.modulate.a = targetMimicAlpha
	RerollButton.modulate.a = targetRerollAlpha
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(displayedText < money):
		displayedText = displayedText + delta * textspeed
	elif(displayedText > money):
		displayedText = displayedText - delta * textspeed
	$Label.text = "%s" % roundf(displayedText)

func _process(delta):

	targetMimicAlpha = (1 if PartyCount > 1 else 0)
	targetRerollAlpha = (1 if PartyCount > 0 else 0)
		
	Mimic.modulate.a = lerp(Mimic.modulate.a, targetMimicAlpha, delta/fade_duration)
	RerollButton.modulate.a = lerp(RerollButton.modulate.a, targetRerollAlpha, delta/fade_duration)


func _on_area_2d_mouse_entered():
	Selected = true
	print("Selected Money!")

func _on_area_2d_mouse_exited():
	Selected = false

func HandlePurchase(purchasedHero):
	print("Getting Cost1: ", purchasedHero)
	money = money - Globals.unitManager._GetCost(purchasedHero)

func sell(soldHero):
	money = money + ceil(Globals.unitManager._GetCost(soldHero)/2)
	print("Selling for: ", ceil(Globals.unitManager._GetCost(soldHero)/2))

func GainMoney(amount):
	money = money + amount

func AttemptReroll():
	if(money > rerollcost && HeroUiController.partyRoster.getPartyCount() > 0):
		money = money - rerollcost
		emit_signal("rerolled")
