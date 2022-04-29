// eslint-disable-next-line no-unused-expressions
({
    getWords : function(count) {

        if(count > 100) return;

        let wordsArray = [
            "expansion",
            "grandfather",
            "nappy",
            "oranges",
            "beds",
            "quack",
            "achiever",
            "yell",
            "hospital",
            "winter",
            "understood",
            "squalid",
            "merciful",
            "reaction",
            "wipe",
            "fearless",
            "tiresome",
            "introduce",
            "planes",
            "drum",
            "muddle",
            "capable",
            "canvas",
            "route",
            "enchanted",
            "quirky",
            "switch",
            "apparatus",
            "loss",
            "agreement",
            "substance",
            "back",
            "oafish",
            "expand",
            "aromatic",
            "quarrelsome",
            "free",
            "useful",
            "raspy",
            "drown",
            "ring",
            "lush",
            "numberless",
            "embarrass",
            "shrill",
            "rice",
            "ice",
            "crow",
            "pumped",
            "sparkle",
            "instruct",
            "girl",
            "glass",
            "frog",
            "murky",
            "impolite",
            "crabby",
            "pin",
            "grade",
            "upbeat",
            "linen",
            "flaky",
            "side",
            "unknown",
            "cactus",
            "round",
            "busy",
            "grab",
            "crush",
            "faithful",
            "mother",
            "clean",
            "unhealthy",
            "event",
            "absent",
            "thoughtless",
            "icy",
            "prefer",
            "charge",
            "confuse",
            "clam",
            "dress",
            "snake",
            "evasive",
            "unit",
            "flow",
            "annoying",
            "gusty",
            "possessive",
            "rhetorical",
            "rule",
            "frantic",
            "farm",
            "poor",
            "possess",
            "men",
            "pleasant",
            "zoom",
            "sidewalk",
            "reply"
        ];

        wordsArray = this.randomizeArray(wordsArray);

        const wordObjArray = wordsArray.map( element => {
            return { word : element, open : false }
        } )

        let arrayWordsOfCount = wordObjArray.slice(0, count);

        return arrayWordsOfCount;
    }, 

    randomizeArray : function(array) {
        const randomArr = array;

        for(let i = randomArr.length -1; i > 0; i-- ) {
            const j = Math.floor( Math.random() * i );
            const temp = randomArr[i];
            randomArr[i] = randomArr[j];
            randomArr[j] = temp;
        }
        return randomArr;
    },

    getWinWord : function(array) {
        let randomIndex = Math.floor( Math.random() * array.length );
        return array[randomIndex].word;
    },
    diaabledBoard : function(component) {
        component.set("v.disabledBoard", true);
    },
    enabledBoard : function(component) {
        component.set("v.disabledBoard", false);
    },
    resetBorder : function(component) {
        this.enabledBoard(component);
        component.set("v.clickCount", 0);
        component.set("v.result", "");
    },
    fireResultEvent : function ( eventValue ) {
        const appEvent = $A.get("e.c:ResultApplicationEvent");
        appEvent.setParams( {result : eventValue } );
        appEvent.fire();
    }
})
