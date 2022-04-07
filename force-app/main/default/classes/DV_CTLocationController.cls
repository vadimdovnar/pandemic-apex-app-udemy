public with sharing class DV_CTLocationController {
    
    public static List<Location__c> getRecentStatusLocacion() {
        List<Location__c> locacions = DV_LoacionModel.getLocationsLimit100();
        return locacions;
    }

    public static List<Location__c> serchLocations(String serchTerm) {
        List<Location__c> locations = DV_LoacionModel.getSerchLocations(serchTerm);
        return locations;
    }

    public static Location__c getLocationById(String locacionId) {
        List<Location__c> locations = DV_LoacionModel.getListLocationsById(locacionId);
        if(locations != null && locations.size() > 0) {
            return locations[0];
        }
        return null;
    }

    public static void updateRedScore(Set<id> locationIds) {
        List<Location__c> locationToUpdate = new List<Location__c>();
        AggregateResult [] redPeoplePerLocation = [SELECT Location__c, COUNT(Id) total FROM Location_Tracing__c
                                                    WHERE Person__r.Health_Status__c = 'Red'
                                                    AND Visit_Date__c = LAST_N_DAYS:10
                                                    AND Location__c IN : locationIds
                                                    GROUP BY Location__c];

        for (AggregateResult ar : redPeoplePerLocation) {
            String locationId = String.valueOf(ar.get('Location__c'));
            Integer redScore = Integer.valueOf(ar.get('total'));
            String status = getStatus(redScore);
            locationToUpdate.add(new Location__c(Id = locationId, Red_Score__c = redScore, Status__c = status));
        }

        if(locationToUpdate != null && locationToUpdate.size() > 0) {
            update locationToUpdate;
        }
    }

    public static String getStatus(Integer redScore) {
        if(redScore == 0) {
            return 'Green';
        } else if(redScore <= 5) {
            return 'Yellow';
        } else if(redScore <= 10) {
            return 'Orange';
        } else {
            return 'Red';
        }
    }
}
