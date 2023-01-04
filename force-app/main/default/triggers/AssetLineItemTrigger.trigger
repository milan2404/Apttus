trigger AssetLineItemTrigger on Apttus_Config2__AssetLineItem__c(before insert, before update) {
    TriggerDispatcher.Run(new AssetLineItemTriggerHandler());
}