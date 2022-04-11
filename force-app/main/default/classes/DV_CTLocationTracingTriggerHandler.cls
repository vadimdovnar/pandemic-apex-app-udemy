public with sharing class DV_CTLocationTracingTriggerHandler {
    
    public static void beforeInsert(List<Location_Tracing__c> newRecords) {
        List<Location_Tracing__c> duplicate = DV_CTLocationTracingController.checkDuplicates(newRecords);

        for (Location_Tracing__c trace : duplicate) {
            trace.addError('Duplicate record found. Location Id' + trace.Location__c + 'Person Id' + trace.Person__c);
        }
    }
}
