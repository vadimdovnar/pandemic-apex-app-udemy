trigger DV_PersonTrigger on Person__c (before insert, before update, after update) {
    
    switch on Trigger.operationType {
        when BEFORE_INSERT  {

            DV_PersonTriggerHandler.beforeInsertHandler(Trigger.new);
        }
        when BEFORE_UPDATE {

            DV_PersonTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE {

            DV_PersonTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        
    }
}