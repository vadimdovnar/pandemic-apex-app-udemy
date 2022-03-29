public with sharing class DV_CTLocationTracingController {
    
    public static List<Location_Tracing__c> getVisitor(String locationId) {
        List<Location_Tracing__c> locationTracing = DV_LocationTracingModel.getLocationTracingByLocationId(locationId);
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

    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> locationTraces) {
        Set<Id> personIds = new Set<Id>();
        Set<Id> locationIds = new Set<Id>();

        // List of duplicate records
        List<Location_Tracing__c> listDuplicate = new List<Location_Tracing__c>();

        for(Location_Tracing__c trace : locationTraces) {
            personIds.add(trace.Person__c);
            locationIds.add(trace.Location__c);
        }

        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
        List<Location_Tracing__c> existingRecords = DV_LocationTracingModel.getLocationTracingByPersonIdsAndLocationIds(personIds, locationIds);
        
        if(existingRecords != null && existingRecords.size() > 0) {
            for(Location_Tracing__c trace : existingRecords) {
                if(! mapOfExistingRecords.containsKey(trace.Location__c)) {
                    mapOfExistingRecords.put(trace.Location__c, new Set<Id>());
                }
                mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);
            }
        }

        for(Location_Tracing__c trace : locationTraces) {
            if(mapOfExistingRecords.containsKey(trace.Location__c) 
                && mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__c)) {
                    listDuplicate.add(trace);
                }
        }
        return listDuplicate;
    }
}
