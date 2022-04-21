({
    doInit : function(component, event, helper) {

        let words = helper.getWords(6);
        component.set("v.words", words);
        let winWords = helper.getWinWord(words);
        component.set("v.winWord", winWords);
    },
    doRender : function(component, event, helper) {

    }
})
