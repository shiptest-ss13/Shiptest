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
	name = "Trickwines for brewers"
	icon_state = "book2"
	author = "Bridget Saint-Baskett"
	title = "Trickwines for brewers"
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
			<h1>Trickwines for brewers</h1>
			Okay, so you just joined the SRM and you want to make some brews! I'm tired of explaining all of this so I'm jotting it all down for the new hires.<br>
			Trickwines almost all share the same effect. When you drink them, they provide a beneficial effect and when you toss them at someone it provides some sort of bad effect.
			<h2> Breakaway flasks</h2>
			Honestly, I love these things. I'm not a scientist so I cant exactly explain how it works but somehow when you fuse plasma into glass it makes it ultra sharp and makes it really good for cracking over fauna heads.<br>
			The simplest way I have found of making them is crafting them with a chunk of glass, plasma, and a welder.<br>

			<h2> Bacteria </h2>
			A speical speices of bacteria native to Illestren is what allows Trickwines form.<br>
			Now we use a special distiller that keeps just enough bacertia alive to ferment without turning the batch sour.<br>
			Now you should still have one on board but if you dont its fine.<br>
			It just so happens we have trees on board our ships host to the Bacteria.<br>
			To get enough Bacteria your going to need to feed it anything that would help a plant.<br>
			Water, Fertilizer, Ashwine are all good options.<br>
			Soon it will drops some apples and you can grind them for the bacteria.<br>
			Once you have enough you can fabricate it the same way you would a normal barrel.<br>

			<h2> Ratios </h2>
			A common trend among Trickwines is the ratio of 3:1:1.<br>
			3 parts being an ethonal, the other 2 parts are often made from flora or fauna.<br>

			<h2> Ashwine </h2>
			It's kind of our trademark, and it's one of the simplest trickwines to make.<br>
			These are the most common wines used in ceremonies so we often stock ships with the moonflowers needed to make them.<br>
			It's made with a ratio of 3:1:1 absinthe, mushroom hallucinogen, and ash respectively.<br>
			Mushroom hallucinogens come from mushroom caps and you can ferment absinthe from moonflowers.<br>
			Its a mild hallucinogenic but seems to have powerful cleansing effects on the devoted SRM.<br>
			It can also really fuck someone up, causing their vision to go shaky and blurry which makes it difficult for them to fight.<br>

			<h2> Icewine </h2>
			This one helps stopping foes in their tracks. One of my favorite flavor wise.
			Its made with 3:1:1 saké, polar bear fur, frost oil(grind chilled peppers).<br>
			You can get polar bear fur and frost oil from grinding up polar bear hides and chilled peppers.<br>
			It's pretty good at sealing burns and lowering your temperature quickly.<br>
			However, it completely encases foes in ice and drops their temperature substantially.<br>

			<h2> Shockwine </h2>
			Easily my favorite for its splashed effect, this thing is great at scorching most fauna.<br>
			Its made with vodka, calcium, and lemon juice.<br>
			If you did not know, vodka requires enzymes instead of the normal fermenting process.<br>
			It's a nice upper. Great if you're trying to run away.<br>
			This one's really flashy. Expect some severe burns on your target<br>

			<h2> Hearthwine </h2>
			I once threw back a flask of this stuff in the heat of a really bad battle and it sealed my wounds within seconds its honestly increadible.<br>
			It also acts like the inverse of Icewine heating you up more then a fever.<br>
			Last time I threw it at someone though i almost burnt down the forest I was in.<br>
			Its made out of ground up fireblossems with some nice hard cider and a bit of welding fuel with of course a ratio of 3:1:1.<br>

			<h2> Forcewine </h2>
			Two intresting effects from the consumption of Forcewine.<br>
			First it seems to give you an "anti magic" effect, I have read about of tales of how it fizzled out some sort of great curse that we could best trace back to a ancient cult.<br>
			I doubt it does anything in that regards but as magic is not real its difficult to test.<br>
			You can also use it to entrap Fauna inside of a forcefield like bubble, Gives you time to breath and prepare an attack.<br>
			3:1:1. Tequila, Space Montain Wind, and I know its one of the most difficult things to come by but hollow water, Its that stuff you can extract from geysers<br>

			<h2> Prismwine </h2>
			Gives you a nice shiny layer of armour, fire seems to have alot harder time sticking to me when i tested it.<br>
			Throwing it seeems to do the reverse acting like a magnifying glass to burns and lasers<br>
			3:1:1. Good ol Gin, then add plasma and tinea luxor which is found from mushroom stems<br>

			Some of these can be a bit situatinal but its always nice to have a few in your bag for emergecys.<br>
			As a bonus, most of the other factions have no clue how to make these so you can sell them for a fair chunk of cash.<br>

			<br>Bridget Saint-Baskett, Senior Brewer<br>

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
