//Set Mailing Address to Account's Shipping address

public class ContactTriggerHandler {
    public static void insertMailingAddress(List<Contact> crNew, Map<Id,Contact> crOldMap){        
        //Stores a map of AccountId and its related Contacts.
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
        for(Contact c : crNew){                      
            if(c.AccountId != null){
                if(accountContactMap.containsKey(c.AccountId)){
                    List<Contact> cr = accountContactMap.get(c.AccountId);
                    cr.add(c);
                    accountContactMap.put(c.AccountId, cr);
                }
                else{
                    accountContactMap.put(c.AccountId, new List<Contact>{c});
                }
            }
        }

        //set mailing address by calling function setMailingAddress
        setMailingAddress(accountContactMap);        
    }

    public static void updateMailingAddress(List<Contact> crNew, Map<Id,Contact> crOldMap){        
        //Stores a map of AccountId and its related Contacts.
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
        for(Contact c : crNew){                      
            if(c.AccountId != null && c.AccountId!=crOldMap.get(c.Id).AccountId){
                if(accountContactMap.containsKey(c.AccountId)){
                    List<Contact> cr = accountContactMap.get(c.AccountId);
                    cr.add(c);
                    accountContactMap.put(c.AccountId, cr);
                }
                else{
                    accountContactMap.put(c.AccountId, new List<Contact>{c});
                }
            }
        }
        
        //set mailing address by calling function setMailingAddress
        setMailingAddress(accountContactMap);
    }

    public static void setMailingAddress(Map<Id,List<Contact>> accountContactMap){
        // Map of All Accounts along with its Account Id
        List<Account> ar = new List<Account>(
            [SELECT Id,Name,ShippingStreet,ShippingState,ShippingCity,ShippingCountry,ShippingPostalCode FROM Account WHERE Id IN :accountContactMap.keySet()]
        );

        // Copying Shipping address to Mailing Address
        for(Account a : ar){
            List<Contact> cr = accountContactMap.get(a.Id);
            if(a.ShippingStreet!=null || a.ShippingState!=null || a.ShippingCity!=null || a.ShippingCountry!=null || a.ShippingPostalCode!=null)
            {
                for(Contact c : cr){
                    c.MailingStreet = a.ShippingStreet;
                    c.MailingState = a.ShippingState;
                    c.MailingCity = a.ShippingCity;
                    c.MailingCountry = a.ShippingCountry;
                    c.MailingPostalCode = a.ShippingPostalCode;
                }
            }                         
        }
    }
}