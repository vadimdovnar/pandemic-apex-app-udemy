public with sharing class DV_PersonModel {

    public static List<Person__c> getAllPersons() {
        List<Person__c> persons = [SELECT Id, Name, Mobile__c, Token__c, Health_Status__c, Status_Update_Date__c 
                                    FROM Person__c 
                                    ORDER BY Status_Update_Date__c 
                                    DESC];
        return persons;
    }

    public static List<Person__c> getSerchPersons(String serchTemp) {
        serchTemp = serchTemp + '%';
        List<Person__c> serchPersons = [SELECT Id, Name, Mobile__c, Token__c, Health_Status__c, Status_Update_Date__c 
                                        FROM Person__c 
                                        WHERE Name LIKE :serchTemp 
                                            OR Mobile__c LIKE :serchTemp 
                                            OR Token__c LIKE :serchTemp 
                                        ORDER BY Status_Update_Date__c 
                                        DESC];
        return serchPersons;
    }
    public static List<Person__c> getPersonsLimit100() {
        List<Person__c> persons = [SELECT Id, Name, Mobile__c, Token__c, Health_Status__c, Status_Update_Date__c 
                                    FROM Person__c 
                                    ORDER BY Status_Update_Date__c  
                                    DESC NULLS LAST 
                                    LIMIT 100];
        return persons;
    }

    public static List<Person__c> getListPersonsById(String personId) {
        List<Person__c> person = [SELECT Id, Name, Mobile__c, Token__c, Health_Status__c, Status_Update_Date__c 
                            FROM Person__c 
                            WHERE Id = :personId];
        return person;
    }
    
    
}
