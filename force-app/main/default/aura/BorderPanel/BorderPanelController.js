// eslint-disable-next-line no-unused-expressions
({
    startGame : function(component, event, helper) {

        const selectedGameMode = component.find("SelectedGame");
        let selectedValue = selectedGameMode.get("v.value");
        const selrctedMode = component.get("v.SelectedMode");
        component.set("v.SelectedMode", selectedValue);

        if(selrctedMode) {
            const boardComp = component.find("boardComp");
            boardComp.startGame();
        }
    },
    onResultHandler : function(component, event, helper) {
        const result = event.getParam("result");

        if ( result === "win" ) {
            component.set("v.disabled", true);
        } else {
            component.set("v.disabled", false);
        }
        helper.addResultRecord(component, result);
    },

    reshuffle : function(component, event, helper) {
        const boardComp = component.find("boardComp");
        boardComp.reshuffleBoard();
        component.set("v.disabled", true);
    }
})
