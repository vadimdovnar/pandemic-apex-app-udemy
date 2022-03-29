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
}
