public with sharing class DV_LocationTracingModel {
    
    public static List<Location_Tracing__c> getAllLocationTracing(String locationId) {
        List<Location_Tracing__c> locationsTracing = [SELECT Id, Visit_Date__c, Person__c, Location__c, Person__r.Token__c, Person__r.Health_Status__c
                                                        FROM Location_Tracing__c
                                                        WHERE Id = :locationId
                                                        ORDER BY Visit_Date__c DESC];
        return locationsTracing;
    }

    public static List<Location_Tracing__c> getLocationTracingLast10Days(Set<Id> personIds) {
        List<Location_Tracing__c> locationsTracing = [SELECT Id, Visit_Date__c, Person__c
                                                        FROM Location_Tracing__c
                                                        WHERE Person__c IN :personIds 
                                                        AND  Visit_Date__c = LAST_N_DAYS:10];
        return locationsTracing;
    }

    public static List<Location_Tracing__c> getLocationTracingLocationIds(Set<Id> locationIds) {
        List<Location_Tracing__c> locationsTracing = [SELECT Id, Name, Visit_Date__c, Person__c, Location__c 
                                                        FROM Location_Tracing__c
                                                        WHERE Location__c IN :locationIds
                                                        AND Person__r.Health_Status__c = 'Green'];
        return locationsTracing;
    }
}
