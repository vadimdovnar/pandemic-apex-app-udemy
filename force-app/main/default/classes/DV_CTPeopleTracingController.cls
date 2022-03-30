public with sharing class DV_CTPeopleTracingController {
    
    public static List<People_Tracing__c> getTraces(String recordId) {
        List<People_Tracing__c> recordsById = DV_CTPeopleTracingModel.getPeopleTracingByRecorsId(recordId);
        return recordsById;
    }

    

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPersonTraces) {
        Set<Id> personIds = new Set<id>();

        for(People_Tracing__c trace : newPersonTraces) {
            personIds.add(trace.Person_1__c);
            personIds.add(trace.Person_2__c);
        }
        List<People_Tracing__c> duplicateList = new List<People_Tracing__c>();

        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
        List<People_Tracing__c> existingRecords = DV_CTPeopleTracingModel.getBothPerson(personIds);

        if(mapOfExistingRecords != null && mapOfExistingRecords.size() > 0) {
            for (People_Tracing__c trace : existingRecords) {
                if(! mapOfExistingRecords.containsKey(trace.Person_1__c)) {
                    mapOfExistingRecords.put(trace.Person_1__c, new Set<Id>());
                }
                mapOfExistingRecords.get(trace.Person_1__c).add(trace.Person_2__c);

                //build map of Person 2
                if(! mapOfExistingRecords.containsKey(trace.Person_2__c)) {
                    mapOfExistingRecords.put(trace.Person_2__c, new Set<Id>());
                }
                mapOfExistingRecords.get(trace.Person_2__c).add(trace.Person_1__c);
            }
            for(People_Tracing__c trace : newPersonTraces) {
                if(
                    (mapOfExistingRecords.containsKey(trace.Person_1__c) && mapOfExistingRecords.get(trace.Person_1__c).contains(trace.Person_2__c))
                    || 
                    (mapOfExistingRecords.containsKey(trace.Person_2__c) && mapOfExistingRecords.get(trace.Person_2__c).contains(trace.Person_1__c))
                 ) {
                    duplicateList.add(trace);
                }
            }
        }
        return duplicateList;
    }
}
