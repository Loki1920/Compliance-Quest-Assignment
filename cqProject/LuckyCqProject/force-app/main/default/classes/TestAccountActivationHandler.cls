@isTest
private class TestAccountTriggerHandler {
    @testSetup
    static void setupTestData() {
        // Create test data for positive case
        Account testAccountPositive = new Account(
            Name = 'Test Account Positive',
            Type = 'Customer - Direct',
            accountActive__c = true,
            Phone = '1234567890',
            Company_Email__c = 'test@example.com'
        );
        insert testAccountPositive;

        // Create test data for negative case
        Account testAccountNegative = new Account(
            Name = 'Test Account Negative',
            Type = 'Customer - Direct', 
            accountActive__c = true,
            Phone = '0987654321',
            Company_Email__c = 'test2@example.com'
        );
        insert testAccountNegative;
    }

    static testMethod void testAccountTriggerHandler_Positive() {
        // Set up user for runAs method
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1]; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        System.runAs(u) {
            Test.startTest();
            // Positive case: Account meets the criteria
            Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account Positive' LIMIT 1];
            testAccount.accountActive__c = false;
            update testAccount; 
            Test.stopTest();

            List<Contact> createdContacts = [SELECT Id FROM Contact WHERE AccountId = :testAccount.Id];
            System.assertEquals(1, createdContacts.size(), 'Contact not created for active customer account');
        }
    }

    static testMethod void testAccountTriggerHandler_Negative() {
        Test.startTest();
        // Negative case: Account does not meet the criteria
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account Negative' LIMIT 1];
        testAccount.accountActive__c = false;
        update testAccount; // Trigger should not create a contact for this account
        Test.stopTest();

        List<Contact> createdContacts = [SELECT Id FROM Contact WHERE AccountId = :testAccount.Id];
        System.assertEquals(0, createdContacts.size(), 'Contact created for inactive customer account');
    }
}
