trigger DV_ContactTrigger on Contact (after insert, after delete, after update, after undelete) {

    switch on Trigger.operationType {
        when  AFTER_INSERT {
            Set<Id> accountIds = new Set<Id>();
            for (Contact con : Trigger.new) {
                if(String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);
                }
            }
            List<AggregateResult> contactTotal = [SELECT AccountId, COUNT(Id) total FROM Contact WHERE Active__c = TRUE AND AccountId IN : accountIds GROUP BY AccountId];
            List<Account> listAccountForUpdate = new List<Account>();
            for (AggregateResult result : contactTotal) {
                    String accId = String.valueOf(result.get('AccountId'));
                    Integer totalActiveContact = Integer.valueOf(result.get('total'));
                    listAccountForUpdate.add(new Account(Id = accId, Active_Contacts__c = totalActiveContact));
                }
            update listAccountForUpdate;
        }
        when AFTER_UPDATE {
            Set<Id> accountIds = new Set<Id>();
            for (Contact con : Trigger.new) {
                if(String.isNotBlank(con.AccountId) && Trigger.oldMap.get(con.Id).Active__c != con.Active__c) {
                    accountIds.add(con.AccountId);
                } else if(Trigger.oldMap.get(con.Id).AccountId != con.AccountId){
                    accountIds.add(con.AccountId);
                    accountIds.add(Trigger.oldMap.get(con.Id).AccountId);
                }
            }
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
}
