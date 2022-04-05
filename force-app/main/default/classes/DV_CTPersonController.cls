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

    public static Set<Id> getCohabitants(Set<Id> personIds) {
        List<String> healthStatus = new List<String>{'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Contact_Type__c, Person_1__c, Person_2__c FROM People_Tracing__c
                                                 WHERE (Person_1__c IN :personIds OR Person_2__c IN :personIds) 
                                                 AND Contact_Type__c = 'Cohabitant'
                                                 AND (Person_1__r.Health_Status__c IN :healthStatus OR Person_2__r.Health_Status__c IN :healthStatus )];

        Set<Id> cohabitants = new Set<Id>();
        for (People_Tracing__c pt : peopleTraces) {
            if(! personIds.contains(pt.Person_1__c)) {
                cohabitants.add(pt.Person_1__c);
            }
            if(! personIds.contains(pt.Person_2__c)) {
                cohabitants.add(pt.Person_2__c);
            }
        }
        return cohabitants;
    }

    public static Set<Id> getNeighbours(Set<Id> personIds) {
        List<People_Tracing__c> peopleTraces = [SELECT Id, Contact_Type__c, Person_1__c, Person_2__c FROM People_Tracing__c
                                                 WHERE (Person_1__c IN :personIds OR Person_2__c IN :personIds) 
                                                 AND Contact_Type__c = 'Neighbour'
                                                 AND (Person_1__r.Health_Status__c = 'Green' OR Person_2__r.Health_Status__c = 'Green')];

        Set<Id> neighbours = new Set<Id>();
        for (People_Tracing__c pt : peopleTraces) {
            if(! personIds.contains(pt.Person_1__c)) {
                neighbours.add(pt.Person_1__c);
            }
            if(! personIds.contains(pt.Person_2__c)) {
                neighbours.add(pt.Person_2__c);
            }
        }
        return neighbours;
    }

    public static Set<Id> getPrimaryContacts(Set<Id> personIds) {
        List<String> healthStatus = new List<String>{'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c FROM People_Tracing__c
                                                 WHERE (Person_1__c IN :personIds OR Person_2__c IN :personIds) 
                                                 AND Contact_Type__c = 'Other'
                                                 AND Contact_Date__c = LAST_N_DAYS:10
                                                 AND (Person_1__r.Health_Status__c IN :healthStatus OR Person_2__r.Health_Status__c IN :healthStatus )];

        Set<Id> primaryContacts = new Set<Id>();
        for (People_Tracing__c pt : peopleTraces) {
            if(! personIds.contains(pt.Person_1__c)) {
                primaryContacts.add(pt.Person_1__c);
            }
            if(! personIds.contains(pt.Person_2__c)) {
                primaryContacts.add(pt.Person_2__c);
            }
        }
        return primaryContacts;
    }

}
