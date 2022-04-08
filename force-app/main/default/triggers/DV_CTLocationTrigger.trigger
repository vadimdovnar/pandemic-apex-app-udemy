trigger DV_CTLocationTrigger on Location__c (before insert, after insert, before update, after update) {

    switch on Trigger.operationType {
        when  BEFORE_INSERT {
            DV_CTLocationTriggerHandler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            DV_CTLocationTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE {
            DV_CTLocationTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}