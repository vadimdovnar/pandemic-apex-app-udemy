public with sharing class DV_ContactModel {
    
    public static List<AggregateResult> getActiveContacts(Set<Id> accountIds) {
        return [SELECT AccountId, COUNT(Id) total FROM Contact WHERE Active__c = TRUE AND AccountId IN : accountIds GROUP BY AccountId];
    }
}
