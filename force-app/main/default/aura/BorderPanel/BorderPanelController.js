({
    startGame : function(component, event, helper) {

        const selectedGameMode = component.find("SelectedGame");
        let selectedValue = selectedGameMode.get("v.value");
        component.set("v.SelectedMode", selectedValue);
    },
    reshuffle : function(component, event, helper) {
        console.log('Reshuffle');
    }
})
