// eslint-disable-next-line no-unused-expressions
({
    blockClickHandler : function(component, event, helper) {
        const open = component.get("v.open");
        if(!open) {
            component.set("v.open", true);
            let label = component.get("v.label");
            let compEvent = component.getEvent("onClick");
            compEvent.setParams({ value : label });
            compEvent.fire();
        }
    },

    loadedScript : function (component) {
        const elem = component.getElement(".blockWord");
        fitText(elem);
    }
})
