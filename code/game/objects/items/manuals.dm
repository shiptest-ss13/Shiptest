/*********************MANUALS (BOOKS)***********************/

//Oh god what the fuck I am not good at computer
/obj/item/book/manual
	icon = 'icons/obj/library.dmi'
	due_date = 0 // Game time in 1/10th seconds
	unique = TRUE   // FALSE - Normal book, TRUE - Should not be treated as normal book, unable to be copied, unable to be modified

/obj/item/book/manual/hydroponics_pod_people
	name = "The Human Harvest - From seed to market"
	icon_state ="bookHydroponicsPodPeople"
	author = "Farmer John" // Whoever wrote the paper or book, can be changed by pen or PC. It is not automatically assigned.
	title = "The Human Harvest - From seed to market"
	//book contents below
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>Growing Humans</h3>

				Why would you want to grow humans? Well I'm expecting most readers to be in the slave trade, but a few might actually
				want to revive fallen comrades. Growing pod people is easy, but prone to disaster.
				<p>
				<ol>
				<li>Find a dead person who is in need of cloning. </li>
				<li>Take a blood sample with a syringe. </li>
				<li>Inject a seed pack with the blood sample. </li>
				<li>Plant the seeds. </li>
				<li>Tend to the plants water and nutrition levels until it is time to harvest the cloned human.</li>
				</ol>
				<p>
				It really is that easy! Good luck!

				</body>
				</html>
				"}

/obj/item/book/manual/ripley_build_and_repair
	name = "APLU \"Ripley\" Construction and Operation Manual"
	icon_state ="book"
	author = "Weyland-Yutani Corp"
	title = "APLU \"Ripley\" Construction and Operation Manual"
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<center>
				<b style='font-size: 12px;'>Weyland-Yutani - Building Better Worlds</b>
				<h1>Autonomous Power Loader Unit \"Ripley\"</h1>
				</center>
				<h2>Specifications:</h2>
				<ul>
				<li><b>Class:</b> Autonomous Power Loader</li>
				<li><b>Scope:</b> Logistics and Construction</li>
				<li><b>Weight:</b> 820kg (without operator and with empty cargo compartment)</li>
				<li><b>Height:</b> 2.5m</li>
				<li><b>Width:</b> 1.8m</li>
				<li><b>Top speed:</b> 5km/hour</li>
				<li><b>Operation in vacuum/hostile environment:</b> Possible</b>
				<li><b>Airtank Volume:</b> 500liters</li>
				<li><b>Devices:</b>
					<ul>
					<li>Hydraulic Clamp</li>
					<li>High-speed Drill</li>
					</ul>
				</li>
				<li><b>Propulsion Device:</b> Powercell-powered electro-hydraulic system.</li>
				<li><b>Powercell capacity:</b> Varies.</li>
				</ul>

				<h2>Construction:</h2>
				<ol>
				<li>Connect all exosuit parts to the chassis frame</li>
				<li>Connect all hydraulic fittings and tighten them up with a wrench</li>
				<li>Adjust the servohydraulics with a screwdriver</li>
				<li>Wire the chassis. (Cable is not included.)</li>
				<li>Use the wirecutters to remove the excess cable if needed.</li>
				<li>Install the central control module (Not included. Use supplied datadisk to create one).</li>
				<li>Secure the mainboard with a screwdriver.</li>
				<li>Install the peripherals control module (Not included. Use supplied datadisk to create one).</li>
				<li>Secure the peripherals control module with a screwdriver</li>
				<li>Install the internal armor plating (Not included due to Nanotrasen regulations. Can be made using 5 metal sheets.)</li>
				<li>Secure the internal armor plating with a wrench</li>
				<li>Weld the internal armor plating to the chassis</li>
				<li>Install the external reinforced armor plating (Not included due to Nanotrasen regulations. Can be made using 5 reinforced metal sheets.)</li>
				<li>Secure the external reinforced armor plating with a wrench</li>
				<li>Weld the external reinforced armor plating to the chassis</li>
				<li></li>
				<li>Additional Information:</li>
				<li>The firefighting variation is made in a similar fashion.</li>
				<li>A firesuit must be connected to the Firefighter chassis for heat shielding.</li>
				<li>Internal armor is plasteel for additional strength.</li>
				<li>External armor must be installed in 2 parts, totaling 10 sheets.</li>
				<li>Completed exosuit is more resiliant against fire, and is a bit more durable overall</li>
				<li>Nanotrasen is determined to the safety of its <s>investments</s> employees.</li>
				</ol>
				</body>
				</html>

				<h2>Operation</h2>
				Please consult the Nanotrasen compendium "Robotics for Dummies".
			"}

/obj/item/book/manual/chef_recipes
	name = "Chef Recipes"
	icon_state = "cooked_book"
	author = "Lord Frenrir Cageth"
	title = "Chef Recipes"
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Food for Dummies</h1>
				Here is a guide on basic food recipes and also how to not poison your customers accidentally.


				<h2>Basic ingredients preparation:</h2>

				<b>Dough:</b> 10u water + 15u flour for simple dough.<br>
				15u egg yolk + 15u flour + 5u sugar for cake batter.<br>
				Doughs can be transformed by using a knife and rolling pin.<br>
				All doughs can be microwaved.<br>
				<b>Bowl:</b> Add water to it for soup preparation.<br>
				<b>Meat:</b> Microwave it, process it, slice it into microwavable cutlets with your knife, or use it raw.<br>
				<b>Cheese:</b> Add 5u universal enzyme (catalyst) to milk and soy milk to prepare cheese (sliceable) and tofu.<br>
				<b>Rice:</b> Mix 10u rice with 10u water in a bowl then microwave it.

				<h2>Custom food:</h2>
				Add ingredients to a base item to prepare a custom meal.<br>
				The bases are:<br>
				- bun (burger)<br>
				- breadslices(sandwich)<br>
				- plain bread<br>
				- plain pie<br>
				- vanilla cake<br>
				- empty bowl (salad)<br>
				- bowl with 10u water (soup)<br>
				- boiled spaghetti<br>
				- pizza bread<br>
				- metal rod (kebab)

				<h2>Table Craft:</h2>
				Put ingredients on table, then click and drag the table onto yourself to see what recipes you can prepare.

				<h2>Microwave:</h2>
				Use it to cook or boil food ingredients (meats, doughs, egg, spaghetti, donkpocket, etc...).
				It can cook multiple items at once.

				<h2>Processor:</h2>
				Use it to process certain ingredients (meat into meatballs, doughslice into spaghetti, potato into fries,etc...)

				<h2>Gibber:</h2>
				Stuff an animal in it to grind it into meat.

				<h2>Meat spike:</h2>
				Stick an animal on it then begin collecting its meat.


				<h2>Example recipes:</h2>
				<b>Vanilla Cake</b>: Microwave cake batter.<br>
				<b>Burger:</b> 1 bun + 1 meat steak<br>
				<b>Bread:</b> Microwave dough.<br>
				<b>Waffles:</b> 2 pastry base<br>
				<b>Popcorn:</b> Microwave corn.<br>
				<b>Meat Steak:</b> Microwave meat.<br>
				<b>Meat Pie:</b> 1 plain pie + 1u black pepper + 1u salt + 2 meat cutlets<br>
				<b>Boiled Spagetti:</b> Microwave spaghetti.<br>
				<b>Donuts:</b> 1u sugar + 1 pastry base<br>
				<b>Fries:</b> Process potato.

				<h2>Sharing your food:</h2>
				You can put your meals on your kitchen counter or load them in the snack vending machines.
				</body>
				</html>
			"}

/obj/item/book/manual/nuclear
	name = "Fission Mailed: Nuclear Sabotage 101"
	icon_state ="bookNuclear"
	author = "Syndicate"
	title = "Fission Mailed: Nuclear Sabotage 101"
	dat = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			Nuclear Explosives 101:<br>
			Hello and thank you for choosing the Syndicate for your nuclear information needs.<br>
			Today's crash course will deal with the operation of a Fusion Class Nanotrasen made Nuclear Device.<br>
			First and foremost, DO NOT TOUCH ANYTHING UNTIL THE BOMB IS IN PLACE.<br>
			Pressing any button on the compacted bomb will cause it to extend and bolt itself into place.<br>
			If this is done to unbolt it one must completely log in which at this time may not be possible.<br>
			To make the nuclear device functional:<br>
			<li>Place the nuclear device in the designated detonation zone.</li>
			<li>Extend and anchor the nuclear device from its interface.</li>
			<li>Insert the nuclear authorisation disk into slot.</li>
			<li>Type numeric authorisation code into the keypad. This should have been provided. Note: If you make a mistake press R to reset the device.
			<li>Press the E button to log onto the device.</li>
			You now have activated the device. To deactivate the buttons at anytime for example when you've already prepped the bomb for detonation	remove the auth disk OR press the R on the keypad.<br>
			Now the bomb CAN ONLY be detonated using the timer. Manual detonation is not an option.<br>
			Note: Nanotrasen is a pain in the neck.<br>
			Toggle off the SAFETY.<br>
			Note: You wouldn't believe how many Syndicate Operatives with doctorates have forgotten this step.<br>
			So use the - - and + + to set a det time between 5 seconds and 10 minutes.<br>
			Then press the timer toggle button to start the countdown.<br>
			Now remove the auth. disk so that the buttons deactivate.<br>
			Note: THE BOMB IS STILL SET AND WILL DETONATE<br>
			Now before you remove the disk if you need to move the bomb you can:<br>
			Toggle off the anchor, move it, and re-anchor.<br><br>
			Good luck. Remember the order:<br>
			<b>Disk, Code, Safety, Timer, Disk, RUN!</b><br>
			Intelligence Analysts believe that normal Nanotrasen procedure is for the Captain to secure the nuclear authorisation disk.<br>
			Good luck!
			</body>
			</html>"}

/obj/item/book/manual/trickwines_4_brewers
	name = "Ashen Brewing"
	icon_state = "book2"
	author = "Amarasatsu ke Qazawat"
	title = "Ashen Brewing"
	dat = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			<style>
			h1 {font-size: 18px; margin: 15px 0px 5px;}
			h2 {font-size: 15px; margin: 15px 0px 5px;}
			li {margin: 2px 0px 2px 15px;}
			ul {list-style: none; margin: 5px; padding: 0px;}
			ol {margin: 5px; padding: 0px 15px;}
			</style>
			</head>
			<body>
			<h1>On the Topic of Trickwines</h1>
			The alchemists of Roumain have long held that with sufficient preparation can many a potion be made. Many a daring hunter has returned to their domicile at the aid of an Alchemist. For those who travel, the 'Trickwine' is oft chosen, and so the learners of Roumain pass the secrets on to others. <br>
			A 'trickwine' is a potent brew, made by taking the powers that rest in the world around us and fermenting them in the blessings of Illestren. When imbibed by a Hunter, strength and power flow through their body, yet when shattered upon the beasts of the World, Illestrens' curses are unleashed upon it.<br>
			To freely create a trickwine is the mark of a rising alchemist, and to deliver it in the heat of a brawl is the mark of a true Hunter.<br>
			May this document guide you to both those marks. <br>

			<h2>Brewing Vessels.</h2>
			While many vessels permeate the minds of alchemists, the Breakaway Flask is the instrument of choice for the rising talent. By taking the essence of plasma and infusing it within the body of glass - a most durable vessel is produced for the Trickwine. The glass remains firm lest it impacts upon a foe.<br>
			Any who tinker will find the infusion of essence is done most easily with a flame. Something that burns with a flame most potent. Away from the furnaces of Illestren, the burn of a welder suffices to create the vessel.<br>

			<h2> The Bacteria Of Illestren </h2>
			The world of Illestren gave birth to a bacterium that has formed the backbone of alchemical experimentation for countless years. It has given birth to countless fermentation methods, including the cycle of brewing a Trickwine.<br>
			By use of a specialized distillery, the Illestren Bacteria can be maintained in amounts ideal to the fermentation of reagents from Trickwines to Beers. A talented brewer can create their own heritage by blending activating bacterium and reagent into a new concotion. <br>
			Not all vessels of the Militia bear a distillery, but plants transplanted from Illestren carry the bacterium within the flesh of their fruit. Careful nurture of a fruit-bearing plant will allow it to spread the blessings of Illestren. Treat the plant as you would treat any other ally. Allot it drinks. Trim its branches. Protect it from those who seek to harm it.<br>
			Once the fruit has ripened and dropped from the host, an alchemist can take it, fermenting the ripe flesh into a potent mixture of ciders and bacterias entangled together.<br>
			Just as we give to the tree, it shall give to us. It pays a talent to remember this.<br>

			<h2> Common Mixtures </h2>
			Those that find easy success within the alchemical arts have written that to make a Trickwine, one must maintain a careful mixture.<br>
			Three wholes of an ethanol base, with the flavor varied for impact. Entangled with a whole strand of beast, and the blessings of plant. Once cut with the potent catalyst that is the Bacterium, the fermentation is rapid, and a Trickwine is born from the mixture. <br>

			<h2> Wine Of Ash </h2>
			The Wine Of Ash is the most endearing brew to have come from the Distilleries of the Militia. It carries a variety of uses, from the Ceremonies of Roumain, to the warm afterparty of a successful hunt. The flavor is said to be somewhat rustic, with hints of fruit and a sweet yet ashy tang. <br>
			Brewing the Wine Of Ash is a simple task, that even Shadows are expected to do at times. By fermenting a flower of the moon into a potent absinthe, a strong base is formed. Seeping a hallucinogenic mushroom within the absinthe, and then introducing an ash into the mixture of drink and plant creates the Wine Of Ash. One must be patient when brewing, as the brew will be strong, but further fermentation will allow it to blossom into a true vintage.<br>
			Take care whilst brewing to maintain a proper ratio of ingredients. The Wine shall become off-balance if more than one whole of mushroom and one whole of ash is introduced to three wholes of absinthe. One must also take care to protect their eyes, as the Vapors of Ash are a potent irritant.<br>
			The Wine itself is held to be hallucinogenic, although debate rages within the halls of Roumain on the nature of such. A talented brewer can offset such trivialities by cutting the Wine with water, or introducing another substance once it has been fermented. Many a Hunter holds the drink to purify the soul, and strengthen the mind for days ahead.<br>

			<h2> Wine Of Ice </h2>
			The Wine Of Ice is a strong brew formented by the Talent Keo Lanai. Talent Lanai had long found solace from the heat in his visions of the 'Godsforsaken Precipice' that the Ashen Huntsman was said to wander, and sought to share this solace with other Hunters. The flavor is said to be somewhat meaty, with a pleasing current of pepper.
			Brewing of the Wine Of Ice requires a unique assortment of reagents. By fermenting the fur of a bear within traditionally brewed rice sake, Keo Lanai found a solid base for the introduction of Frozen Pepper Essence. It is said that the original brew produced a cold so potent that frost formed on Lanai's brow.<br>
			Hunters favor the Wine Of Ice for blessed relief from heat imbibing it provide. Alchemists have theorized that the brew stimulates the production of sweat in the body, allowing the body to cool itself more rapidly. Other Hunters swear by relief seeping into their burns as the brew finds its way into their system. Others find usage in the potent frost that it leaves upon impact, using it to freeze everything from foe to food.<br>

			<h2> Lightning's Blessing </h2>
			Lightning's Blessing is said to be a potent stimulant, brewed by Hunter Trackers to allow them to track mobile prey through unknown environments. The flavor is said to be sharp and unrelenting, much like the Hunters who indulge in it.<br>
			Lightning's Blessing is brewed with a base of Vodka. By taking vodka and fermenting ground down bones within it, a strong alchemical blend is created. This blend is then inoculated with juiced lemon whilst within a distillery. The resulting blend is an environment ripe for a particular strain of Bacterium to multiply in. This strain of the Bacterium is said to be what gives the flavor to the brew, and its digestion produces a high in most sapients.<br>
			Hunters are said to use Lightning's Blessing as a weapon, where the bacterium, upon being introduced to open air quickly produces an electrical field, shocking whatever the mixture lands upon.

			<h2> Hearthflame </h2>
			Hearthflame is Talent Lanai's other great creation. While travelling through the cold of many a fringe world, Lanai sought the warmth of his home, and took the creation of another mixture as a challenge. By taking the hearty fermented blend of an Illestren Apple, The petals of a Fireblossom, and a hint of phosphorous, Lanai produced a potent heating drink.<br>
			Hearthflame is said to have a bold flavor profile, not unlike an apple shredded apart by tangy pricks. The bacterium is said to stimulate the body and cause it to start heating herself, or in cases of localized exposure, causes rapid, cauterizing heating.<br>
			When this particular blend is exposed to the air, it rapidly heats up. Hunters have advised Shadows be careful if issued it, and most Alchemists refuse to make it unless it is required for the hunt at hand.<br>
			<br>Transcribed by Amarasatsu ke Qazawat<br>

			<font face="Segoe Script">Amarasatsu ke Qazawat</font><br>

			</body>
			</html>"}

// Wiki books that are linked to the configured wiki link.

// A book that links to the wiki
/obj/item/book/manual/wiki
	var/page_link = ""
	window_size = "970x710"

/obj/item/book/manual/wiki/attack_self()
	if(!dat)
		initialize_wikibook()
	return ..()

/obj/item/book/manual/wiki/proc/initialize_wikibook()
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		dat = {"
			<iframe
				id='ext_frame'
				src='[wikiurl]/frame.html'
				style='border: none; width: 100vw; height: 100vh;'>
			</iframe>
			<style>
			html, body {
				height: 100vh;
				width: 100vw;
				margin: 0;
				overflow: hidden;
			}
			body > :not(iframe) {
				display: none;
				}
			</style>
			<script>
				window.onmessage = function() {
					document.getElementById('ext_frame').contentWindow.postMessage('[page_link]', '*')
				}
			</script>
			"}

/obj/item/book/manual/wiki/chemistry
	name = "Chemistry Textbook"
	icon_state = "chemistrybook"
	author = "GREMLIN"
	title = "Chemistry Textbook"
	page_link = "Guide_to_Chemistry"

/obj/item/book/manual/wiki/command
	name = "Command and Delegate"
	icon_state = "book"
	author = "Frontier Assistance Program"
	title = "Command and Delegate: The Entreprising Captain's Guide"
	page_link = "Guide_to_Command"

/obj/item/book/manual/wiki/piloting
	name = "You and Helm Consoles"
	icon_state = "book"
	author = "Frontier Assistance Program"
	title = "You and Helm Consoles: The Bold Helmsman's Manual"
	page_link = "Guide_to_the_Overmap"

/obj/item/book/manual/wiki/ghetto_chemistry
	name = "Ghetto Chemistry Textbook"
	icon_state = "chemistrybook"
	author = "GREMLIN"
	title = "Less Legal Chemistry Textbook"
	page_link = "Guide_to_Ghetto_Chemistry"

/obj/item/book/manual/wiki/cooking
	name = "Cookbook"
	desc = "It's a cookbook!"
	icon_state = "cooked_book"
	author = "Frontier Assistance Program"
	title = "To Serve Man"
	page_link = "Guide_to_Food_and_Drinks"

/obj/item/book/manual/wiki/construction
	name = "Ship Repairs and Construction"
	icon_state = "bookEngineering"
	author = "Frontier Assistance Program"
	title = "Ship Repairs and Construction"
	page_link = "Construction"

/obj/item/book/manual/wiki/engineering
	name = "Engineering Guide"
	icon_state = "bookEngineering2"
	author = "Frontier Assistance Program"
	title = "The Ship Engineer's Guide to Mechanical and Electrical Engineering"
	page_link = "Guide_to_Engineering"

/obj/item/book/manual/wiki/hacking
	name = "Hacking"
	icon_state = "bookHacking"
	author = "Frontier Assistance Program"
	title = "Hacking"
	page_link = "Hacking"

/obj/item/book/manual/wiki/drinks
	name = "Barman Recipes: Mixing Drinks and Changing Lives"
	icon_state = "barbook"
	author = "Sir John Rose"
	title = "Barman Recipes: Mixing Drinks and Changing Lives"
	page_link = "Guide_to_Food_and_Drinks"

/obj/item/book/manual/wiki/medicine
	name = "Guide to Medical Aid"
	icon_state = "book8"
	author = "Frontier Assistance Program"
	title = "The Crewman's Guide to Medical Aid"
	page_link = "Guide_to_Medical"

/obj/item/book/manual/wiki/surgery
	name = "Guide to Surgery"
	icon_state = "book4"
	author = "Frontier Assistance Program"
	title = "Guide to Surgery: Scalpel, Hemostat, Wristwatch"
	page_link = "Guide_to_Surgery"

/obj/item/book/manual/wiki/robotics
	name = "Robotics for Dummies"
	icon_state = "borgbook"
	author = "XISC"
	title = "Robotics for Dummies"
	page_link = "Guide_to_Robotics"

// /obj/item/book/manual/wiki/engineering_singulo_tesla
//	name = "Singularity and Tesla for Dummies"
//	icon_state ="bookEngineeringSingularitySafety"
//	author = "Engineering Encyclopedia"
//	title = "Singularity and Tesla for Dummies"
//	page_link = "Singularity_and_Tesla_engines"

// /obj/item/book/manual/wiki/security_space_law
//	name = "Space Law"
//	desc = "A set of Nanotrasen guidelines for keeping law and order on their space stations."
//	icon_state = "bookSpaceLaw"
//	author = "Nanotrasen"
//	title = "Space Law"
//	page_link = "Space_Law"

// /obj/item/book/manual/wiki/infections
//	name = "Infections - Making your own pandemic!"
//	icon_state = "bookInfections"
//	author = "Infections Encyclopedia"
//	title = "Infections - Making your own pandemic!"
//	page_link = "Infections"

// /obj/item/book/manual/wiki/telescience
//	name = "Teleportation Science - Bluespace for dummies!"
//	icon_state = "book7"
//	author = "University of Bluespace"
//	title = "Teleportation Science - Bluespace for dummies!"
//	page_link = "Guide_to_telescience"

// /obj/item/book/manual/wiki/detective
//	name = "The Film Noir: Proper Procedures for Investigations"
//	icon_state ="bookDetective"
//	author = "Nanotrasen"
//	title = "The Film Noir: Proper Procedures for Investigations"
//	page_link = "Detective"

// /obj/item/book/manual/wiki/research_and_development
// 	name = "Research and Development 101"
//	icon_state = "rdbook"
//	author = "Dr. L. Ight"
//	title = "Research and Development 101"
//	page_link = "Guide_to_Research_and_Development"

// /obj/item/book/manual/wiki/experimentor
//	name = "Mentoring your Experiments"
//	icon_state = "rdbook"
//	author = "Dr. H.P. Kritz"
//	title = "Mentoring your Experiments"
//	page_link = "E.X.P.E.R.I-MENTOR"

// /obj/item/book/manual/wiki/tcomms
//	name = "Subspace Telecommunications And You"
//	icon_state = "book3"
//	author = "Engineering Encyclopedia"
//	title = "Subspace Telecommunications And You"
//	page_link = "Guide_to_Telecommunications"

// /obj/item/book/manual/wiki/atmospherics
//	name = "Lexica Atmosia"
//	icon_state = "book5"
//	author = "the City-state of Atmosia"
//	title = "Lexica Atmosia"
//	page_link = "Guide_to_Atmospherics"

// /obj/item/book/manual/wiki/grenades
//	name = "DIY Chemical Grenades"
//	icon_state = "book2"
//	author = "W. Powell"
//	title = "DIY Chemical Grenades"
//	page_link = "Grenade"

// /obj/item/book/manual/wiki/toxins
//	name = "Toxins or: How I Learned to Stop Worrying and Love the Maxcap"
//	icon_state = "book6"
//	author = "Cuban Pete"
//	title = "Toxins or: How I Learned to Stop Worrying and Love the Maxcap"
//	page_link = "Guide_to_toxins"

// /obj/item/book/manual/wiki/plumbing
//	name = "Chemical Factories Without Narcotics"
//	icon_state ="plumbingbook"
//	author = "Nanotrasen"
//	title = "Chemical Factories Without Narcotics"
//	page_link = "Guide_to_plumbing"

// /obj/item/book/manual/wiki/medical_cloning
//	name = "Cloning techniques of the 26th century"
//	icon_state ="bookCloning"
//	author = "Medical Journal, volume 3"
//	title = "Cloning techniques of the 26th century"
//	page_link = "Guide_to_genetics#Cloning"
