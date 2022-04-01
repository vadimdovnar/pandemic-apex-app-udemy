public with sharing class DV_ContactTriggerHandler {
    
    public static void afterInsertHandler(List<Contact> contactList) {
        Set<Id> accountIds = new Set<Id>();
            for (Contact con : contactList) {
                if(String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);
                }
            }
        DV_AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterUpdateHandler(List<Contact> contactList, Map<Id, Contact> contactMap) {
        Set<Id> accountIds = new Set<Id>();
            for (Contact con : contactList) {
                if(String.isNotBlank(con.AccountId) && contactMap.get(con.Id).Active__c != con.Active__c) {
                    accountIds.add(con.AccountId);
                } else if(contactMap.get(con.Id).AccountId != con.AccountId){
                    accountIds.add(con.AccountId);
                    accountIds.add(contactMap.get(con.Id).AccountId);
                }
            }
        DV_AccountContactService.updateActiveContacts(accountIds);
    }
}
