@isTest
public with sharing class DV_CTContactTriggerHandlerTest {

    @TestSetup
    static void makeData() {

        List<Account> accountRecords = new List<Account>();
        accountRecords.add(new Account(Name = 'Test 1'));
        accountRecords.add(new Account(Name = 'Test 2'));

        insert accountRecords;

        List<Contact> contactRecords = new List<Contact>();
        contactRecords.add(new Contact(LastName = 'Contact Test 1', AccountId = accountRecords[0].Id, Active__c = true));
        contactRecords.add(new Contact(LastName = 'Contact Test 2', AccountId = accountRecords[0].Id, Active__c = true));
        contactRecords.add(new Contact(LastName = 'Contact Test 3', AccountId = accountRecords[0].Id));
        contactRecords.add(new Contact(LastName = 'Contact Test 4', AccountId = accountRecords[0].Id));
        contactRecords.add(new Contact(LastName = 'Contact Test 5', AccountId = accountRecords[1].Id));

        insert contactRecords;
    }

    @isTest
    static void afterInsrtHandlerTest2() {
        
        List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
        System.assertEquals(2, accs.size());
        for (Account acc : accs) {
            if (acc.Name == 'Test 1') {
                System.assertEquals(2, acc.Active_Contacts__c);
            }
            if (acc.Name == 'Test 2') {
                System.assertEquals(0, acc.Active_Contacts__c);
            }
        }

        List<Contact> allContacts = [SELECT Id FROM Contact];
        System.assertEquals(5, allContacts.size());
    }

    @isTest
    static void afterInsrtHandlerTestBulk() {
        Account testAccount1 = [SELECT Id, Name FROM Account WHERE Name = 'Test 1'];
        List<Contact> contactRecords = new List<Contact>();
        for (Integer i = 1; i <= 1000; i++) {
            contactRecords.add(new Contact(LastName = 'Contact Test ' + i, AccountId = testAccount1.Id, Active__c = true));
        }
        
        insert contactRecords;

        List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
        System.assertEquals(2, accs.size());
        for (Account acc : accs) {
            if (acc.Name == 'Test 1') {
                System.assertEquals(1002, acc.Active_Contacts__c);
            }
            if (acc.Name == 'Test 2') {
                System.assertEquals(0, acc.Active_Contacts__c);
            }
        }

        List<Contact> allContacts = [SELECT Id FROM Contact];
        System.assertEquals(1005, allContacts.size());
    }

    @isTest 
    public static void afterUpdateHandlerTest1() {

        List<Contact> allContacts = [SELECT Id, LastName FROM Contact];
        for (Contact con : allContacts) {
            if (con.LastName == 'Contact Test 3' || con.LastName == 'Contact Test 4') {
                con.Active__c = true;
            }
        }
        Test.startTest();
            update allContacts;
        Test.stopTest();

        List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
        System.assertEquals(2, accs.size());
        for (Account acc : accs) {
            if (acc.Name == 'Test 1') {
                System.assertEquals(4, acc.Active_Contacts__c);
            }
            if (acc.Name == 'Test 2') {
                System.assertEquals(0, acc.Active_Contacts__c);
            }
        }
        System.assertEquals(5, allContacts.size());
    }

    @isTest 
    public static void afterUpdateHandlerTest2() {

        Account testAccount2 = [SELECT Id, Name FROM Account WHERE Name = 'Test 2'];
        List<Contact> allContacts = [SELECT Id, LastName FROM Contact];
        for (Contact con : allContacts) {
            if (con.LastName == 'Contact Test 1') {
                con.Active__c = true;
                con.AccountId = testAccount2.Id;
            }
        }
        Test.startTest();
            update allContacts;
        Test.stopTest();

        List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
        System.assertEquals(2, accs.size());
        for (Account acc : accs) {
            if (acc.Name == 'Test 1') {
                System.assertEquals(1, acc.Active_Contacts__c);
            }
            if (acc.Name == 'Test 2') {
                System.assertEquals(1, acc.Active_Contacts__c);
            }
        }
        System.assertEquals(5, allContacts.size());
    }
}   
