public with sharing class DV_CTLocationTriggerHandler {
    
    public static void beforeInsert(List<Location__c> newRecords) {
        for (Location__c location : newRecords) {
            location.Status__c = 'Green';
        }
    }

    public static void beforeUpdate(List<Location__c> newRecords, Map<Id, Location__c> oldMapRecords) {
        for (Location__c location : newRecords) {
            if (location.Status__c != oldMapRecords.get(location.Id).Status__c) {
                location.Status_Update_Date__c = Date.today();
            }
        }
    }

    public static void afterUpdate(List<Location__c> newRecords, Map<Id, Location__c> oldMapRecords) {
        Set<Id> statusChange = new Set<Id>();
        for (Location__c location : newRecords) {
            if (location.Status__c == 'Red' && oldMapRecords.get(location.Id).Status__c != 'Red') {
                statusChange.add(location.Id);
            }
        }

        List<Location_Tracing__c> locationTraces = DV_CTLocationTracingController.getLocationsByLocationIds(statusChange);
        Set<Id> personIds = new Set<Id>();
        for (Location_Tracing__c trace : locationTraces) {
            personIds.add(trace.Person__c);
        }

        List<Person__c> personToUpdate = new List<Person__c>();
        for(Id pId : personIds) {
            personToUpdate.add(new Person__c(Id = pId, Health_Status__c = 'Yellow'));
        }
        if (personToUpdate.size() > 0) {
            update personToUpdate;
        }
    }
}
