/datum/reagent/consumable/ethanol/beer
	name = "Beer"
	description = "An alcoholic beverage, brewed originally to keep a safe source of drinking water. A timeless classic."
	color = "#664300" // rgb: 102, 67, 0
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 25
	taste_description = "bad water"
	glass_name = "glass of beer"
	glass_desc = "A pint of beer."

/datum/reagent/consumable/ethanol/beer/light
	name = "Light Beer"
	description = "An alcoholic beverage, brewed originally to keep a safe source of drinking water. This variety has reduced calorie and alcohol content."
	boozepwr = 5 //Space Europeans hate it
	taste_description = "dish water"
	glass_name = "glass of light beer"
	glass_desc = "A pint of watery light beer."

/datum/reagent/consumable/ethanol/kahlua
	name = "Kahlua"
	description = "A widely known coffee-flavoured liqueur. Still labeled under an old name from Earth, despite the loss of history."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 45
	taste_description = "a bitter combination"
	glass_icon_state = "kahluaglass"
	glass_name = "glass of coffee liquor"
	glass_desc = "Bitter from the coffee and alcohol alike!"
	shot_glass_icon_state = "shotglasscream"

/datum/reagent/consumable/ethanol/kahlua/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-40)
	if(!HAS_TRAIT(M, TRAIT_ALCOHOL_TOLERANCE))
		M.adjust_jitter(5, max = 100)
	..()
	. = 1

/datum/reagent/consumable/ethanol/whiskey
	name = "Whiskey"
	description = "A well-aged whiskey."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 75
	taste_description = "molasses"
	glass_icon_state = "whiskeyglass"
	glass_name = "glass of whiskey"
	glass_desc = "Often described as having a silky mouthfeel and a smokey aftertaste. The brown-amber color catches the light very well."
	shot_glass_icon_state = "shotglassbrown"

/datum/reagent/consumable/ethanol/vodka
	name = "Vodka"
	description = "A clear, hard liquor. Doubles as a flammable fuel source, if you really need it."
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 65
	taste_description = "grain alcohol"
	glass_icon_state = "ginvodkaglass"
	glass_name = "glass of vodka"
	glass_desc = "It's almost difficult to tell the glass is full of vodka until you tip it around. The smell makes your nose wrinkle... but it might just be worth it."
	shot_glass_icon_state = "shotglassclear"

/datum/reagent/consumable/ethanol/vodka/on_mob_life(mob/living/carbon/M)
	M.radiation = max(M.radiation-2,0)
	return ..()

/datum/reagent/consumable/ethanol/gin
	name = "Gin"
	description = "A very sharp alcohol, with a flavor that's distinctly fresh."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 45
	taste_description = "an alcoholic pine tree"
	glass_icon_state = "ginvodkaglass"
	glass_name = "glass of gin"
	glass_desc = "A glass of gin, made with a specific type of berry that leaves it smelling like the tree it came from. It's enough to wet your eyes."

/datum/reagent/consumable/ethanol/rum
	name = "Rum"
	description = "The liquor of choice for sailors and spacers alike."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 60
	taste_description = "spiked butterscotch"
	glass_icon_state = "rumglass"
	glass_name = "glass of rum"
	glass_desc = "There's no need to worry about being seen as a pirate with one of these. If you add enough ice and let it melt, it'll turn into grog."
	shot_glass_icon_state = "shotglassbrown"

/datum/reagent/consumable/ethanol/tequila
	name = "Tequila"
	description = "A strongly flavoured spirit."
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 70
	taste_description = "paint stripper"
	glass_icon_state = "tequilaglass"
	glass_name = "glass of tequila"
	glass_desc = "Despite the strong, woody taste, there's just enough sweetness to keep you coming for more."
	shot_glass_icon_state = "shotglassgold"

/datum/reagent/consumable/ethanol/vermouth
	name = "Vermouth"
	description = "A fine wine to go with a meal."
	color = "#91FF91" // rgb: 145, 255, 145
	boozepwr = 45
	taste_description = "dry alcohol"
	glass_icon_state = "vermouthglass"
	glass_name = "glass of vermouth"
	glass_desc = "Vermouth was used as a medicine in the past, and the flavor makes sure to remind you of that."
	shot_glass_icon_state = "shotglassclear"

/datum/reagent/consumable/ethanol/wine
	name = "Wine"
	description = "An alcoholic beverage made from fermented grapes of all kinds."
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 35
	taste_description = "bitter sweetness"
	glass_icon_state = "wineglass"
	glass_name = "glass of wine"
	glass_desc = "Deeply red wine in a glass. You're not enough of a sommelier to really describe how it smells."
	shot_glass_icon_state = "shotglassred"

/datum/reagent/consumable/ethanol/lizardwine
	name = "Blueflame Pyrecask"
	description = "A popular Zohil beverage, made by infusing specially-gathered cacti and grapes in ethanol."
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 45
	quality = DRINK_FANTASTIC
	taste_description = "warm sweetness"

/datum/reagent/consumable/ethanol/grappa
	name = "Grappa"
	description = "A fine brandy mixed with spirits."
	color = "#F8EBF1"
	boozepwr = 60
	taste_description = "classy bitter sweetness"
	glass_icon_state = "grappa"
	glass_name = "glass of grappa"
	glass_desc = "Despite being made from the recycled remains of wine grapes, it's not bad at all."

/datum/reagent/consumable/ethanol/amaretto
	name = "Amaretto"
	description = "A gentle drink that carries a sweet aroma."
	color = "#E17600"
	boozepwr = 25
	taste_description = "fruity and nutty sweetness"
	glass_icon_state = "amarettoglass"
	glass_name = "glass of amaretto"
	glass_desc = "A sweet and syrupy looking alcohol. You're lucky it wasn't lost to history."

/datum/reagent/consumable/ethanol/cognac
	name = "Cognac"
	description = "A sweet and strongly alcoholic drink, made after numerous distillations and years of maturing."
	color = "#AB3C05" // rgb: 171, 60, 5
	boozepwr = 75
	taste_description = "sharp and relaxing"
	glass_icon_state = "cognacglass"
	glass_name = "glass of cognac"
	glass_desc = "You wonder how many exhausted Solarian bureaucrats are drinking this the same way you are, right now."
	shot_glass_icon_state = "shotglassbrown"

/datum/reagent/consumable/ethanol/absinthe
	name = "Absinthe"
	description = "A powerful alcoholic drink. Rumored to cause hallucinations if taken irresponsibly."
	color = rgb(10, 206, 0)
	boozepwr = 80 //Very strong even by default
	taste_description = "death and licorice"
	glass_icon_state = "absinthe"
	glass_name = "glass of absinthe"
	glass_desc = "The smell is enough to bring you to the verge of tears. The hint of liquorice threatens to bring you over the edge."
	shot_glass_icon_state = "shotglassgreen"

/datum/reagent/consumable/ethanol/absinthe/on_mob_life(mob/living/carbon/M)
	if(prob(10) && !HAS_TRAIT(M, TRAIT_ALCOHOL_TOLERANCE))
		M.hallucination += 4 //Reference to the urban myth
	..()

/datum/reagent/consumable/ethanol/hooch
	name = "Hooch"
	description = "Low quality, low grade, and low expectations."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 100
	taste_description = "pure resignation"
	glass_icon_state = "glass_brown2"
	glass_name = "Hooch"
	glass_desc = "You can't help but feel like you'd rather drink anything else right now, just from looking at it."

/datum/reagent/consumable/ethanol/hooch/on_mob_life(mob/living/carbon/M)
	if(M.mind && M.mind.assigned_role == "Assistant")
		M.heal_bodypart_damage(1,1)
		. = 1
	return ..() || .

/datum/reagent/consumable/ethanol/ale
	name = "Ale"
	description = "A dark alcoholic beverage made with malted barley and yeast."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 65
	taste_description = "hearty alcoholic grains"
	glass_icon_state = "aleglass"
	glass_name = "glass of ale"
	glass_desc = "A pint of ale. A classic for the working class."

/datum/reagent/consumable/ethanol/hcider
	name = "Hard Cider"
	description = "The alcoholic sibling to apple cider."
	color = "#CD6839"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 25
	taste_description = "the season that <i>falls</i> between summer and winter"
	glass_icon_state = "whiskeyglass"
	glass_name = "hard cider"
	glass_desc = "Sharper tasting, alcoholic apple cider."
	shot_glass_icon_state = "shotglassbrown"

/datum/reagent/consumable/ethanol/triple_sec
	name = "Triple Sec"
	description = "A sweet and vibrant orange liqueur."
	color = "#ffcc66"
	boozepwr = 30
	taste_description = "a warm flowery orange taste which recalls the ocean air and summer wind of distant shores"
	glass_icon_state = "glass_orange"
	glass_name = "Triple Sec"
	glass_desc = "A glass of straight triple sec. Citrusy and warm."

/datum/reagent/consumable/ethanol/creme_de_menthe
	name = "Creme de Menthe"
	description = "A minty liqueur excellent for refreshing, cool drinks."
	color = "#00cc00"
	boozepwr = 20
	taste_description = "a minty, cool, and invigorating splash of cold streamwater"
	glass_icon_state = "glass_green"
	glass_name = "Creme de Menthe"
	glass_desc = "Bright green and minty - enough to tell you what it's going to taste like."

/datum/reagent/consumable/ethanol/creme_de_cacao
	name = "Creme de Cacao"
	description = "A chocolatey liqueur excellent for adding dessert notes to beverages."
	color = "#996633"
	boozepwr = 20
	taste_description = "a slick and aromatic hint of chocolates swirling in a bite of alcohol"
	glass_icon_state = "glass_brown"
	glass_name = "Creme de Cacao"
	glass_desc = "Creme de Cacao - chocolate-wine, essentially. Not milk chocolate, so expect some bite."

/datum/reagent/consumable/ethanol/creme_de_coconut
	name = "Creme de Coconut"
	description = "A coconut liqueur for smooth, creamy, tropical drinks."
	color = "#F7F0D0"
	boozepwr = 20
	taste_description = "a sweet milky flavor with notes of toasted sugar"
	glass_icon_state = "glass_white"
	glass_name = "Creme de Coconut"
	glass_desc = "A white glass of coconut liqueur."

/datum/reagent/consumable/ethanol/sake
	name = "Sake"
	description = "A sweet rice wine."
	color = "#DDDDDD"
	boozepwr = 70
	taste_description = "sweet rice wine"
	glass_icon_state = "sakecup"
	glass_name = "cup of sake"
	glass_desc = "A cup of sake. Capable of being served hot, cold, or at room temperature, and served in a traditionally-sized little cup."

/datum/reagent/consumable/ethanol/fernet
	name = "Fernet"
	description = "An incredibly bitter herbal liqueur used as a digestif."
	color = "#2d4b3b" // rgb: 27, 46, 36
	boozepwr = 80
	taste_description = "utter bitterness"
	glass_name = "glass of fernet"
	glass_desc = "A glass of pure Fernet. Intensely bitter and reserved to being a digestive more than something to be enjoyed." //Hi Kevum

/datum/reagent/consumable/ethanol/applejack
	name = "Applejack"
	description = "The officially sponsored drink by the National Association for Anti-Gravity Automobile Dragracing (NAAGAD)."
	color = "#ff6633"
	boozepwr = 20
	taste_description = "resisting gravity through brandy"
	glass_icon_state = "applejack_glass"
	glass_name = "Applejack"
	glass_desc = "You lament you can't watch any Agrav Races while out here."

/datum/reagent/consumable/ethanol/champagne //How the hell did we not have champagne already!?
	name = "Champagne"
	description = "A sparkling wine known for its ability to strike fast and hard."
	color = "#ffffc1"
	boozepwr = 40
	taste_description = "auspicious occasions and bad decisions"
	glass_icon_state = "champagne_glass"
	glass_name = "Champagne"
	glass_desc = "A sparkling wine, traditionally served in a flute that clearly displays the slowly rising bubbles."

/datum/reagent/consumable/ethanol/dotusira
	name = "Dotusira"
	description = "A bitter liquor made from fermented dotu-fime."
	color = "#9b9b78"
	boozepwr = 25
	taste_description = "bitter fruit with a smooth aftertaste"
	glass_icon_state = ""
	glass_name = "Dotusira"
	glass_desc = "A bitter tecetian liquor that leaves behind a smooth aftertaste."

/datum/reagent/consumable/ethanol/faraseta
	name = "Fara-Seta"
	description = "A spicy cider known to floor those with sensitive tastes."
	color = "#c5533a"
	boozepwr = 55
	taste_description = "spicy alcoholic heat"
	glass_icon_state = ""
	glass_name = "Fara-Seta"
	glass_desc = "A spicy cider fermented from a small pepper-esque fruit."

/datum/reagent/consumable/ethanol/sosomira
	name = "Sososi-Mira"
	description = "Sososi Leaves and Miras are used to make this variety of alcohol, a warm and sweet alcohol with a tendency to leave nasty hangovers. It’s typically served before a meal, to get conversation flowing."
	color = "#b9d6d8"
	boozepwr = 45
	taste_description = "a tingling, sweet warmth"
	glass_icon_state = ""
	glass_name = "Sososi-Mira"
	glass_desc = "A conversation starter, a drink, and a setpiece all in one. There's no Miras in this one."

/datum/reagent/consumable/ethanol/sososeta
	name = "Sososi-Seta"
	description = "A bitter drink made from the leaves of the Sososi plant. The sugars of the leaf are seeped out as it ferments, leaving behind a bitter spirit, that is then seasoned with cactus fruit and berries to be served as a digestif."
	color = "#c2d4d5"
	boozepwr = 45
	taste_description = "bitter-savory fruitiness"
	glass_icon_state = ""
	glass_name = "Sososi-Seta"
	glass_desc = "A white liquid with small pieces of fruit floating inside it. Typically served as a digestive after a hearty meal."

/datum/reagent/consumable/ethanol/sososeta/on_mob_life(mob/living/carbon/M)
	if(M.nutrition <= NUTRITION_LEVEL_STARVING)
		M.adjustToxLoss(0.5*REM, 0)
	M.adjust_nutrition(-2)
	M.overeatduration = 0
	return ..()
