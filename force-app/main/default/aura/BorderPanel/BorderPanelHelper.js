// eslint-disable-next-line no-unused-expressions
({
    addResultRecord : function(component, resultGage) {
        const action = component.get("c.addResult");
        const modeValue = component.get("v.SelectedMode").toUpperCase();

        action.setParams( {
            result : resultGage.toUpperCase(),
            mode : modeValue
        } );
        action.setCallback(this, function(response) {
            const state = response.getState();

            if(state !== 'SUCCESS') {
                console.error('Error in saving records');
            }
        }) ;

        $A.enqueueAction(action);


    }
})
