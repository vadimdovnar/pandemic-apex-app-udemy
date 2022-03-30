public with sharing class DV_CTPeopleTracingModel {
    
    public static List<People_Tracing__c> getPeopleTracingByRecorsId(String recordId) {

        List<People_Tracing__c> records = [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_1__r.Health_Status__c, Person_1__r.Token__c, Person_2__c, Person_2__r.Health_Status__c, Person_2__r.Token__c 
                                            FROM People_Tracing__c 
                                            WHERE Person_1__c = : recordId
                                                OR Person_2__c = :recordId
                                                ORDER BY Contact_Date__c DESC];
        return records;
    } 

    public static List<People_Tracing__c> getBothPerson(Set<Id> recordId) {
        List<People_Tracing__c> records = [SELECT Id, Person_1__c, Person_2__c 
                                            FROM People_Tracing__c
                                            WHERE Person_1__c IN : recordId
                                                OR Person_2__c IN : recordId];
        return records;
    }
}
