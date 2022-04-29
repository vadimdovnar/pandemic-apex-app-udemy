public with sharing class DV_AccountContactService {
    public static void updateActiveContacts(Set<Id> accountIds) {
        Map<Id, Account> accountsForUpdate = new Map<Id, Account>();
        List<AggregateResult> contactTotal = DV_ContactModel.getActiveContacts(accountIds);
        for (AggregateResult result : contactTotal) {
            String accId = String.valueOf(result.get('AccountId'));
            Integer totalActiveContact = Integer.valueOf(result.get('total'));
            accountsForUpdate.put(accId, new Account(Id = accId, Active_Contacts__c = totalActiveContact));
        }
        for (Id accId : accountIds) {
            if (!accountsForUpdate.containsKey(accId)) {
                accountsForUpdate.put(accId, new Account(Id = accId, Active_Contacts__c = 0));
            }
        }
        update accountsForUpdate.values();
    }
}
