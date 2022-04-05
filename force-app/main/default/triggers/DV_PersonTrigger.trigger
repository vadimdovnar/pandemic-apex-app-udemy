trigger DV_PersonTrigger on Person__c (before insert, before update) {
    
    switch on Trigger.operationType {
        when BEFORE_INSERT  {

            DV_PersonTriggerHandler.beforeInsertHandler(Trigger.new);
        }
        when BEFORE_UPDATE {

            DV_PersonTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        
        
    }
}