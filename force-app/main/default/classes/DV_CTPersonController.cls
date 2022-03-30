public with sharing class DV_CTPersonController {
    
    public static String getToken(String mobile) {
        Blob targetBlob = Blob.valueOf('ExampleMD5String');
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        // get the string targetBlob of hash blob;
        return EncodingUtil.base64Encode(hash);
    }

    public static List<Person__c> getRecentHealthChanges() {
        List<Person__c> persons = DV_PersonModel.getPersonsLimit100();
        return persons;
    }

    public static List<Person__c> serchPerson(String serchTemp) {
        List<Person__c> allPersons = DV_PersonModel.getSerchPersons(serchTemp);
        List<Person__c> persons = new List<Person__c>();
        return persons;
    }

    public static Person__c getPersonById(String personId) {
        List<Person__c> person = DV_PersonModel.getListPersonsById(personId);
        if(person != null && person.size() > 0) {
            return person[0];
        }
        return null;
    }
    
    public static Map<String, Integer> getHealthStatusCount() {
        Map<String, Integer> healtStatusMap = new Map<String, Integer>();
        for(AggregateResult ar : DV_PersonModel.getPersonStatusCount()) {

            String healthStatus = String.valueOf(ar.get('Health_Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));
            healtStatusMap.put(healthStatus, count);
        }
        return healtStatusMap;
    }

}
