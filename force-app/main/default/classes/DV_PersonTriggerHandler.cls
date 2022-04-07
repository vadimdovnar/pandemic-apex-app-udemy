public with sharing class DV_PersonTriggerHandler {
    
    public static void beforeInsertHandler(List<Person__c> records) {
        
        for (Person__c person : records) {
            person.Health_Status__c = 'Green';
            person.Token__c = DV_CTPersonController.getToken(person.Mobile__c);
        }
    }

    public static void beforeUpdateHandler(List<Person__c> newRecords, Map<Id, Person__c> oldMapRecords) {

        for (Person__c person : newRecords) {
            if(person.Health_Status__c != oldMapRecords.get(person.Id).Health_Status__c) {
                person.Status_Update_Date__c = Date.today();
            }
        }
    }

    public static void afterUpdateHandler(List<Person__c> newRecords, Map<Id, Person__c> oldMapRecords) {

        Set<Id> changeStatus = new Set<Id>();
        Set<Id> redStatus = new Set<Id>();
        for (Person__c person : newRecords) {
            if(person.Health_Status__c != oldMapRecords.get(person.Id).Health_Status__c) {
                changeStatus.add(person.Id);
            }
            if(person.Health_Status__c == 'Red' && oldMapRecords.get(person.Id).Health_Status__c != 'Red') {
                redStatus.add(person.Id);
            }
        }
        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(redStatus);

        Set<Id> orangeStatus = new Set<Id>();
        Set<Id> yellowStatus = new Set<Id>();

        List<Person__c> personToUpdate = new List<Person__c>();

        orangeStatus.addAll(DV_CTPersonController.getCohabitants(redStatus, alreadyProcessed));
        Set<Id> primaryContacts = DV_CTPersonController.getPrimaryContacts(redStatus,alreadyProcessed);
        yellowStatus.addAll(DV_CTPersonController.getNeighbours(redStatus, alreadyProcessed));
        orangeStatus.addAll(primaryContacts);
        yellowStatus.addAll(DV_CTPersonController.getSecondaryContacts(primaryContacts, alreadyProcessed));

        for (Id pId : orangeStatus) {
            personToUpdate.add(new Person__c(Id = pId, Health_Status__c = 'Orange'));
        }

        for (Id pId : yellowStatus) {
            personToUpdate.add(new Person__c(Id = pId, Health_Status__c = 'Yellow'));
        }

        if(personToUpdate.size() > 0) {
            update personToUpdate;
        }

        List<Location_Tracing__c> locationTraces = DV_CTLocationTracingController.getLocationsByPersonIds(changeStatus);
        if(locationTraces != null && locationTraces.size() > 0) {
            Set<Id> locationIds = new Set<Id>();

            for (Location_Tracing__c trace : locationTraces) {
                locationIds.add(trace.Location__c);
            }
            DV_CTLocationController.updateRedScore(locationIds);
        }
    }
}
