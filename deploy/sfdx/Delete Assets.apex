delete [SELECT Id FROM Task];
delete [SELECT Id FROM Apttus_Billing__RelatedARTransaction2__c];
delete [SELECT Id FROM Apttus_Billing__Invoice__c];
delete [SELECT Id FROM Apttus_Billing__CreditMemo__c];
delete [SELECT Id FROM Apttus_Billing__WalletDrawdown__c];
delete [SELECT Id FROM Apttus_Config2__AccountBillingSummary__c];

delete [SELECT Id FROM Apttus_Config2__RelatedAssetLineItem__c];
delete [SELECT Id FROM Apttus_Config2__AssetLineItem__c];
delete [SELECT Id FROM Apttus_Config2__AssetLineItemHistory__c];
delete [SELECT Id FROM Apttus_Config2__Order__c];
delete [SELECT Id FROM Apttus_Billing__BillingSchedule__c];
delete [SELECT Id FROM Apttus_Billing__UsageSchedule__c];
delete [SELECT Id FROM Apttus_Billing__UsageInput__c];
delete [SELECT Id FROM Apttus_Config2__BillingPlan__c];
delete [SELECT Id FROM Apttus_Config2__Milestone2__c];

delete [SELECT Id FROM Apttus_Billing__InvoiceRun__c];

delete [SELECT Id FROM Apttus_Config2__ProductConfiguration__c];
delete [SELECT Id FROM Apttus_Proposal__Proposal_Line_Item__c];
delete [SELECT Id FROM Apttus_Billing__WalletDrawdown__c];
delete [SELECT Id FROM Apttus_Billing__Payment__c];
delete [SELECT Id FROM Apttus_Billing__PaymentMethod__c];
delete [SELECT Id FROM Apttus_Billing__Refund__c];
delete [SELECT Id FROM Apttus_Billing__LateFee__c];

delete [SELECT Id FROM Apttus_Billing__ForecastedLineItemOptions__c];
delete [SELECT Id FROM Apttus_Billing__ForecastedBillingOptions__c];
delete [SELECT Id FROM Apttus_Billing__ForecastedBillingSchedule__c];
delete [
    SELECT Id
    FROM Apttus_Billing__ForecastedBillingSummary__c
];