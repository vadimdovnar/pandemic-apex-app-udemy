trigger DV_ContactTrigger on Contact (after insert, after delete, after update, after undelete) {

    switch on Trigger.operationType {
        when  AFTER_INSERT {
            DV_ContactTriggerHandler.afterInsertHandler(Trigger.new);
        }
        when AFTER_UPDATE {
            DV_ContactTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
        }
    }
}
