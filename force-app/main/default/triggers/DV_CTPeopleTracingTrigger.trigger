trigger DV_CTPeopleTracingTrigger on People_Tracing__c (before insert) {

    switch on Trigger.operationtype {
        when BEFORE_INSERT {
            DV_CTPeopletracingHandler.beforeInsert(Trigger.new);
        }
        
    }
}