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

        for (Person__c person : newRecords) {
            if(person.Health_Status__c != oldMapRecords.get(person.Id).Health_Status__c) {
                
            }
        }
    }
}
