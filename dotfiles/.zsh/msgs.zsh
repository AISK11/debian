#!/bin/zsh
msgs=()
if ((#zinsults_load == 0)) || [[ ${zinsults_load[(r)default]} == default ]];then
	msgs+=(
        ## Zinsults:
	"(╯°□°）╯︵ ┻━┻"
	"ACHTUNG! ALLES TURISTEN UND NONTEKNISCHEN LOOKENPEEPERS! DAS KOMPUTERMASCHINE IST NICHT FÜR DER GEFINGERPOKEN UND MITTENGRABEN! ODERWISE IST EASY TO SCHNAPPEN DER SPRINGENWERK, BLOWENFUSEN UND POPPENCORKEN MIT SPITZENSPARKEN. IST NICHT FÜR GEWERKEN BEI DUMMKOPFEN. DER RUBBERNECKEN SIGHTSEEREN KEEPEN DAS COTTONPICKEN HÄNDER IN DAS POCKETS MUSS. ZO RELAXEN UND WATSCHEN DER BLINKENLICHTEN."
	"Allowing you to survive childbirth was medical malpractice."
	"And the Darwin Award goes to.... %n!"
	"Are you always this stupid or are you making a special effort today?!"
	"Are you even trying?!"
	"Bad."
	"Boooo!"
	"Brains aren't everything. In your case they're nothing."
	"Come on! You can do it!"
	"Commands, random gibberish, who cares!"
	"Don't you have anything better to do?!"
	"Don't you know anything?"
	"Dropped on your head as a baby, eh?"
	"error code: 1D10T"
	"ERROR_INCOMPETENT_USER"
	"Even your mom loves you only as a friend."
	"Fake it till you make it!"
	"Go outside."
	"Haha, n00b!"
	"How many times do I have to flush before you go away?"
	"I am _seriously_ considering 'rm -rf /'-ing myself..."
	"I don't know what makes you so stupid, but it really works."
	"I'd slap you, but that'd be animal abuse."
	"If beauty fades then you have nothing to worry about."
	"If brains were gasoline you wouldn't have enough to propel a flea's motorcycle around a doughnut."
	"If ignorance is bliss, you must be the happiest person on earth."
	"If shit was music, you'd be an orchestra."
	"If what you don't know can't hurt you, you're invulnerable."
	"Incompetence is also a form of competence"
	"I've heard of being hit with the ugly stick, but you must have been beaten senseless with it."
	"I was going to give you a nasty look, but I see you already have one."
	"Keep trying, someday you'll do something intelligent!"
	"Let's play horse. I'll be the front end. And you be yourself."
	"Life is good, you should get one."
	"lol"
	"lol... plz"
	"My keyboard is not a touch screen!"
	"My uptime is longer than your relationships."
	"n00b alert!"
	"Nice try."
	"Pathetic"
	"Perhaps computers are not for you..."
	"Perhaps computers is not for you..."
	"Perhaps you should leave the command line alone..."
	"Please step away from the keyboard!"
	"plz uninstall"
	"Pro tip: type a valid command!"
	"Rose are red. Violets are blue. I have five fingers. The middle one's for you."
	"RTFM!"
	"So, I'm just going to go ahead and run rm -rf / for you."
	"Sorry what? I don't understand idiot language."
	"The degree of your stupidity is enough to boil water."
	"The worst one today!"
	"This is not a search engine."
	"This is not Windows"
	"This is why nobody likes you."
	"This is why you get to see your children only once a month."
	"Try using your brain the next time!"
	"Two wrongs don't make a right, take your parents as an example."
	"Typing incorrect commands, eh?"
	"u suk"
	"What if I told you... it is possible to type valid commands."
	"What if... you type an actual command the next time!"
	'What is this...? Amateur hour!?'
	"Why are you doing this to me?!"
	"Why are you so stupid?!"
	"Why did the chicken cross the road? To get the hell away from you."
	"Wow! That was impressively wrong!"
	"You are not as bad as people say, you are much, much worse."
	"You are not useless since you can still be used as a bad example."
	"You must have been born on a highway because that's where most accidents happen."
	"Your application for reduced salary has been sent!"
	"You're proof that god has a sense of humor."
	"You're so dumb your first words were DUH."
	"You're so fat, people jog around you for exercise."
	"You're the reason Santa says ho, ho, ho, on Christmas!"
	"Your mom had a severe case of diarrhea when you were born."
	"Y u no speak computer???"
	'¯\_(ツ)_/¯'
        ## Bash insults:
        "Boooo!"
        "Don't you know anything?"
        "RTFM!"
        "Haha, n00b!"
        "Wow! That was impressively wrong!"
        "Pathetic"
        "The worst one today!"
        "n00b alert!"
        "Your application for reduced salary has been sent!"
        "lol"
        "u suk"
        "lol... plz"
        "plz uninstall"
        "And the Darwin Award goes to.... ${USER}!"
        "ERROR_INCOMPETENT_USER"
        "Incompetence is also a form of competence"
        "Bad."
        "Fake it till you make it!"
        "What is this...? Amateur hour!?"
        "Come on! You can do it!"
        "Nice try."
        "What if... you type an actual command the next time!"
        "What if I told you... it is possible to type valid commands."
        "Y u no speak computer???"
        "This is not Windows"
        "Perhaps you should leave the command line alone..."
        "Please step away from the keyboard!"
        "error code: 1D10T"
        "ACHTUNG! ALLES TURISTEN UND NONTEKNISCHEN LOOKENPEEPERS! DAS KOMPUTERMASCHINE IST NICHT FÜR DER GEFINGERPOKEN UND MITTENGRABEN! ODERWISE IST EASY TO SCHNAPPEN DER SPRINGENWERK, BLOWENFUSEN UND POPPENCORKEN MIT SPITZENSPARKEN. IST NICHT FÜR GEWERKEN BEI DUMMKOPFEN. DER RUBBERNECKEN SIGHTSEEREN KEEPEN DAS COTTONPICKEN HÄNDER IN DAS POCKETS MUSS. ZO RELAXEN UND WATSCHEN DER BLINKENLICHTEN."
        "Pro tip: type a valid command!"
        "Go outside."
        "This is not a search engine."
        "(╯°□°）╯︵ ┻━┻"
        "¯\\_(ツ)_/¯"
        "So, I'm just going to go ahead and run rm -rf / for you."
        "Why are you so stupid?!"
        "Perhaps computers is not for you..."
        "Why are you doing this to me?!"
        "Don't you have anything better to do?!"
        "I am _seriously_ considering 'rm -rf /'-ing myself..."
        "This is why you get to see your children only once a month."
        "This is why nobody likes you."
        "Are you even trying?!"
        "Try using your brain the next time!"
        "My keyboard is not a touch screen!"
        "Commands, random gibberish, who cares!"
        "Typing incorrect commands, eh?"
        "Are you always this stupid or are you making a special effort today?!"
        "Dropped on your head as a baby, eh?"
        "Brains aren't everything. In your case they're nothing."
        "I don't know what makes you so stupid, but it really works."
        "You are not as bad as people say, you are much, much worse."
        "Two wrongs don't make a right, take your parents as an example."
        "You must have been born on a highway because that's where most accidents happen."
        "If what you don't know can't hurt you, you're invulnerable."
        "If ignorance is bliss, you must be the happiest person on earth."
        "You're proof that god has a sense of humor."
        "Keep trying, someday you'll do something intelligent!"
        "If shit was music, you'd be an orchestra."
        "How many times do I have to flush before you go away?"
        ## Sudo insults:
        "Just what do you think you're doing Dave?"
        "It can only be attributed to human error."
        #"That's something I cannot allow to happen."
        "My mind is going. I can feel it."
        #"Sorry about this, I know it's a bit silly."
        "Take a stress pill and think things over."
        #"This mission is too important for me to allow you to jeopardize it."
        #"I feel much better now."
        #"Wrong!  You cheating scum!"
        "And you call yourself a Rocket Scientist!"
        "No soap, honkie-lips."
        "Where did you learn to type?"
        "Are you on drugs?"
        "My pet ferret can type better than you!"
        "You type like i drive."
        "Do you think like you type?"
        "Your mind just hasn't been the same since the electro-shock, has it?"
        "Maybe if you used more than just two fingers..."
        #"BOB says:  You seem to have forgotten your passwd, enter another!"
        "stty: unknown mode: doofus"
        "I can't hear you -- I'm using the scrambler."
        "The more you drive -- the dumber you get."
        "Listen, broccoli brains, I don't have time to listen to this trash."
        "Listen, burrito brains, I don't have time to listen to this trash."
        "I've seen penguins that can type better than that."
        "Have you considered trying to match wits with a rutabaga?"
        "You speak an infinite deal of nothing"
        "You silly, twisted boy you."
        #"He has fallen in the water!"
        #"We'll all be murdered in our beds!"
        #"You can't come in. Our tiger has got flu"
        "I don't wish to know that."
        "What, what, what, what, what, what, what, what, what, what?"
        #"You can't get the wood, you know."
        #"You'll starve!"
        #"... and it used to be so popular..."
        #"Pauses for audience applause, not a sausage"
        "Hold it up to the light --- not a brain in sight!"
        #"Have a gorilla..."
        "There must be cure for it!"
        #"There's a lot of it about, you know."
        #"You do that again and see what happens..."
        "Ying Tong Iddle I Po"
        #"Harm can come to a young lad like that!"
        #"And with that remarks folks, the case of the Crown vs yourself was proven."
        "Speak English you fool --- there are no subtitles in this scene."
        #"You gotta go owwwww!"
        #"I have been called worse."
        #"It's only your word against mine."
        "I think ... err ... I think ... I think I'll go home"
	)
fi
