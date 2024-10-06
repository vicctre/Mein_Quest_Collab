
/*
These are adv logs how they are displayed in adv log screen

How to add a new log:
1. Add log struct in adventure_logs down below
2. ... and add log's name to adventure_logs_array 
3. Update oStageManager.DefaultStagesData function - add new adv log 
   to the needed stage
4. After launching the game make sure to reset_progress
   The game will eventually crash without this
*/

adventure_logs = {
	Mein: {
		name: "Mein",
        sprite: sPage_Mein,
		description: "This 1'8\" tall creature has the unique ability to use his"
					 + " ears for practically anything, turning as strong as steel"
					 + " on command. Calling Eldoon his home, Mein travels to the Sister"
					 + " Temple to figure out what is going on with the peaceful planet"
	},
	Genull: {
		name: "Genull",
        sprite: sPage_Genull,
		description: "With the balance of Eldoon constantly shifting, "
					 + "these gentle creatures seem indifferent to the situation. They " 
					 + "never look for trouble, but tend to find themselves always caught "
					 + "up in something  . . . makes you feel kinda bad"
	},
	Rularog: {
		name: "Rularog",
        sprite: sPage_Rularog,
		description: "The long tongued loaf enjoys the swamps of Longroot Lane. "  
					+ "While usually lax, something has changed. . .After being tipped off by a"
					+ "mysterious figure, he now hordes the Sister Spirit Gem to "
					+ "rule the forest and all the swamps. Quite rude!" 
        // name_rel_y: -240,
        // text_rel_y: 80,
	},
	Tuffull: {
		name: "Tuffull",
        sprite: sPage_Tuffull,
		description: "She is sort of a mother figure to the wandering Genulls"
					 + " in Longroot Lane. Tuffull is very aggressive and territorial," 
					 + " using her size to intimidate and rush down enemies. While not good at" 
					 + " turning around, shes doing her best!"
	},
	Apploon: {
		name: "Apploon",
        sprite: sPage_Apploon,
		description: "They dont seem to mind bonking anyone who steps under their tree." 
					 + " They fall without a care in the world. How do they climb trees?" 
					 + " Determination I suppose. Wonder how they taste . . ." 
					 + " are they even actually fruit?"
	},
	
	Naturina: {
		name: "Naturina",
		sprite: sPage_Naturina, 
		description: "One of the Sister Spirits who brought life to Eldoon during the Rebirth. "
					+ "She isolates herself in dense forests, nurturing the environment " 
					+ "and anyone in need. She is a free spirit who is constantly "
					+ "looking for more to do with her life." 
	},
	
	Fleater: {
		name: "Fleater",
		sprite: sPage_Fleater, 
		description: "Fleaters can be seen flying around, minding their own business. Not" 
					+ " sure what his deal is, but he is always smiling . . ." 
					+ " Should I be freaked out? What are they thinking? " 
					+ " Maybe they are just silly guys. . ." 
	},
	
	Pinnik: {
		name: "Pinnik",
		sprite: sPage_Pinnik, 
		description: "A species that is specked fully into defense, surrounded" 
					+ " by retractable steel barbs. The carapace shell is " 
					+ "impossible to break, making them fully invincible to all attacks. " 
					+ "Eating habits are unknown, as they don't talk much." 
	},
	
	Chantie: {
		name: "Chantie",
		sprite: sPage_Chantie, 
		description: "This predominately female species is known for dancing in groups wherever they" 
					+ " find comfort. Get too close, and they will instinctually whip you "  
					+ "with their hair! The one with the silkiest hair is considered" 
					+ " the leader of a pack." 
	},
}


//// Used by oMenuAdventrueLogs
adventure_logs_array = []
var names_order = [
    "Mein",
    "Genull",
    "Tuffull",
    "Apploon",
    "Rularog",
	"Naturina", 
	"Fleater",
	"Pinnik",
	"Chantie",
]

for (var i = 0; i < array_length(names_order); ++i) {
    var name = names_order[i]
    array_push(adventure_logs_array, adventure_logs[$ name])
}
