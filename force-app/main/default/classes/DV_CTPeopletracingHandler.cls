public with sharing class DV_CTPeopletracingHandler {
    
    public static void beforeInsert(List<People_Tracing__c> newRecords) {
        List<People_Tracing__c> duplecates = DV_CTPeopleTracingController.checkDuplicates(newRecords);

        for (People_Tracing__c trace : duplecates) {
            trace.addError('Duplicate record found. Person 1:' + trace.Person_1__c + 'Person 2:' + trace.Person_2__c);
        }
    }
}
