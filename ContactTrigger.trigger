//Set Contact Mailing address to Account's Shipping Address
trigger ContactTrigger on Contact (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        ContactTriggerHandler.insertMailingAddress(Trigger.new, null);
    }

    if(Trigger.isBefore && Trigger.isUpdate){
        ContactTriggerHandler.updateMailingAddress(Trigger.new, Trigger.oldMap);
    }
}