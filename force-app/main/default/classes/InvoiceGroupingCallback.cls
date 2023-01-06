global class InvoiceGroupingCallback implements Apttus_Billing.CustomClass.IInvoiceGroupingCallback {
    global String getKeyComponentForInvoiceGrouping(Apttus_Billing.CustomClass.Parameters params) {
        String key = string.valueOf(params.billingScheduleSO.Grouping__c);
        return key;
    }
}