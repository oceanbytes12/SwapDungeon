extends Control


var displayedText = 10
var textspeed = 15
var Selected
var money = 10
var rerollcost = 1
signal rerolled
func _ready():
	HeroUiController.moneyManager = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(displayedText < money):
		displayedText = displayedText + delta * textspeed
	elif(displayedText > money):
		displayedText = displayedText - delta * textspeed
	$Label.text = "%s" % roundf(displayedText)


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
	if(money > rerollcost):
		money = money - rerollcost
		emit_signal("rerolled")
