public with sharing class DV_LoacionModel {
    
    public static List<Location__c> getLocationsLimit100() {
        List<Location__c> locations = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                                        FROM Location__c 
                                        ORDER BY Status_Update_Date__c DESC NULLS LAST
                                        LIMIT 100];
        return locations;
    }

    public static List<Location__c> getSerchLocations(String serchTemp) {
        serchTemp = serchTemp + '%';
        List<Location__c> locations = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                                        FROM Location__c
                                        WHERE Name LIKE :serchTemp
                                            OR  Address__c LIKE :serchTemp
                                            OR Pincode__c LIKE :serchTemp
                                        ORDER BY Status_Update_Date__c DESC];
        return locations;
    }

    public static List<Location__c> getListLocationsById(String LocationId) {
        List<Location__c> locations = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                                        FROM Location__c
                                        WHERE Id = :LocationId];
        return locations;
    }
}
