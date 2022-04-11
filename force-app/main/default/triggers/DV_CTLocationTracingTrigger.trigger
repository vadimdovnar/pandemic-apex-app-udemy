trigger DV_CTLocationTracingTrigger on Location_Tracing__c (before insert) {

    switch on Trigger.operationType {
        when  BEFORE_INSERT{
            DV_CTLocationTracingTriggerHandler.beforeInsert(Trigger.new);
        }
        
    }
}