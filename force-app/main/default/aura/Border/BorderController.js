// eslint-disable-next-line no-unused-expressions
({
    doInit : function(component, event, helper) {

        let gameMode = component.get("v.mode");
        let column = 0;

        if(gameMode && gameMode === "hard") {
            column = 6;
        } else if (gameMode === "medium") {
            column = 4;
        } else {
            column = 3;
        }
        let blockSize = 12 / column;

        component.set("v.blockSize", blockSize);
        let words = helper.getWords(column * column);
        component.set("v.words", words);
        let winWords = helper.getWinWord(words);
        component.set("v.winWord", winWords);

        helper.resetBorder(component);
    },
    

    blockClickHandler : function(component, event, helper) {

        let value = event.getParam("value");
        let clickCount = component.get("v.clickCount") + 1;

        if( value === component.get("v.winWord") ) {
            component.set("v.result", "YOU WIN");
            helper.diaabledBoard(component);
            helper.fireResultEvent("win");
        } else if( clickCount === 3 ) {
            component.set("v.result", "YOU LOSE");
            helper.diaabledBoard(component);
            helper.fireResultEvent("lose");
        }
        component.set("v.clickCount", clickCount);
    },

    reshuffleBoard : function(component, event, helper) {

        const words = component.get("v.words");
        const randomazedWords = helper.randomizeArray(words);
        component.set("v.words", randomazedWords);
        helper.resetBorder(component);
    },
})
