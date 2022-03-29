public with sharing class DV_CTLocationTracingController {
    
    public static List<Location_Tracing__c> getVisitor(String locationId) {
        List<Location_Tracing__c> locationTracing = DV_LocationTracingModel.getAllLocationTracing(locationId);
        return locationTracing;
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
        List<Location_Tracing__c> locationsTracingByPersonIdsLast10Days = DV_LocationTracingModel.getLocationTracingLast10Days(personIds);
        return locationsTracingByPersonIdsLast10Days;
    }

    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds) {
        List<Location_Tracing__c> locationsTracingByLocationIds = DV_LocationTracingModel.getLocationTracingLocationIds(locationIds);
        return locationsTracingByLocationIds;
    }
}
