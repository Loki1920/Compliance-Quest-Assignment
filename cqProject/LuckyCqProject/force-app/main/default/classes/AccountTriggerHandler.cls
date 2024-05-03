public class AccountTriggerHandler {
    
    public static void accountTrigger(List<Account> newAccounts, Map<Id, Account> oldMap) {
        List<Contact> newContacts = new List<Contact>();
        
        List<String> substringsToCheck = new List<String>{'Customer - Direct', 'Customer - Channel'}; // here we can add our values 
        
        for (Account acc : newAccounts) {
            // Check if the account meets the criteria
            
            if (StringUtils.containsAny(acc.Type, substringsToCheck) && acc.accountActive__c && (Trigger.isInsert || (Trigger.isUpdate && oldMap.get(acc.Id).accountActive__c == false))) {
                // Create a new Contact using Account fields directly
                newContacts.add(new Contact(
                    FirstName = acc.Name,
                    LastName = 'Customer Representative',
                    Phone = acc.Phone,
                    Email = acc.Company_Email__c,
                    AccountId = acc.Id
                ));
            }
        }
        
        // Insert the new contacts if there are any
        if (!newContacts.isEmpty()) {
            insert newContacts;
        }
    }
}


