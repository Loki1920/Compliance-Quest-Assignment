@isTest
public class TestAccountActivationHandler {
    @isTest
    static void testDefaultContactCreation() {
        // Create a test Account with Type = 'Customer - Direct' and IsActive = true
        Account testAccount = new Account(
            Name = 'Test Account',
            Type = 'Customer - Direct',
            accountActive__c = true
        );
        insert testAccount;

        // Default contact is created
        List<Contact> createdContacts = [SELECT Id FROM Contact WHERE AccountId = :testAccount.Id];
        System.assertEquals(1, createdContacts.size(), 'Default contact not created for active customer account');

        // Create a test Account with Type = 'Customer - Direct' and accountActive = false
        Account testInactiveAccount = new Account(
            Name = 'Test Inactive Account',
            Type = 'Customer - Direct',
            accountActive__c = false
        );
        insert testInactiveAccount;

        //  No default contact is created for inactive customer account
        List<Contact> createdInactiveAccountContacts = [SELECT Id FROM Contact WHERE AccountId = :testInactiveAccount.Id];
        System.assertEquals(0, createdInactiveAccountContacts.size(), 'Default contact created for inactive customer account');
        
        //updating accountActive__c contact should be created
        testInactiveAccount.accountActive__c = true;
        update testInactiveAccount;
        
        
           List<Contact> createdInactiveAccountContact = [SELECT Id FROM Contact WHERE AccountId = :testInactiveAccount.Id];
        System.assertEquals(1, createdInactiveAccountContact.size(), 'Default contact created for inactive customer account');
        
        
        
        
    }
}