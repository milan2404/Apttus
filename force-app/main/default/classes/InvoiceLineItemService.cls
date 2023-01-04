public abstract class InvoiceLineItemService {
    public static Map<Id, Apttus_Billing__InvoiceLineItem__c> getInvoiceLineItemMap(
        Set<Id> setInvoiceLineItemId
    ) {
        return new Map<Id, Apttus_Billing__InvoiceLineItem__c>(
            getInvoiceLineItemFromId(setInvoiceLineItemId)
        );
    }

    public static List<Apttus_Billing__InvoiceLineItem__c> getInvoiceLineItemFromId(
        Set<Id> setInvoiceLineItemId
    ) {
        List<Apttus_Billing__InvoiceLineItem__c> listInvoiceLineItem = new List<Apttus_Billing__InvoiceLineItem__c>();
        setInvoiceLineItemId?.remove(null);
        if (!setInvoiceLineItemId.isEmpty()) {
            listInvoiceLineItem = [
                SELECT
                    Id,
                    Name,
                    Apttus_Billing__Amount__c,
                    Apttus_Billing__Quantity__c,
                    Apttus_Billing__StartDate__c,
                    Apttus_Billing__EndDate__c,
                    Apttus_Billing__BillingScheduleId__c,
                    Apttus_Billing__BillingCountry__c,
                    Apttus_Billing__InvoiceId__c,
                    Apttus_Billing__InvoiceId__r.Name,
                    Apttus_Billing__InvoiceId__r.Apttus_Billing__PONumber__c,
                    Apttus_Billing__InvoiceId__r.Apttus_Billing__BillingCountry__c,
                    Apttus_Billing__AssetLineItemId__c,
                    Apttus_Billing__AssetLineItemId__r.Apttus_Config2__ChargeType__c,
                    Apttus_Billing__AssetLineItemId__r.Apttus_QPConfig__ProposalId__c,
                    Apttus_Billing__AssetLineItemId__r.Apttus_QPConfig__ProposalId__r.Apttus_QPConfig__PONumber__c,
                    Apttus_Billing__AssetLineItemId__r.Apttus_CMConfig__AgreementId__c,
                    Apttus_Billing__AssetLineItemId__r.Apttus_CMConfig__AgreementId__r.Apttus_CMConfig__PONumber__c
                FROM Apttus_Billing__InvoiceLineItem__c
                WHERE Id IN :setInvoiceLineItemId
                LIMIT :Constants.SOQL.RowLimit
            ];
        }

        return listInvoiceLineItem;
    }
}