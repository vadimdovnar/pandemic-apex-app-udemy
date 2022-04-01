public with sharing class DV_AccountContactService {
    
    public static void updateActiveContacts(Set<Id> accountIds) {

        List<AggregateResult> contactTotal = [SELECT AccountId, COUNT(Id) total FROM Contact WHERE Active__c = TRUE AND AccountId IN : accountIds GROUP BY AccountId];
        List<Account> listAccountForUpdate = new List<Account>();
        for (AggregateResult result : contactTotal) {
                String accId = String.valueOf(result.get('AccountId'));
                Integer totalActiveContact = Integer.valueOf(result.get('total'));
                listAccountForUpdate.add(new Account(Id = accId, Active_Contacts__c = totalActiveContact));
            }
        update listAccountForUpdate;
    }
}
