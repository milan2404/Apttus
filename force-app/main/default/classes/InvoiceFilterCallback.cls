global class InvoiceFilterCallback implements Apttus_Billing.CustomClass.IInvoiceFilterCallback {
    global String getBillingScheduleFilterExpression(Apttus_Billing.CustomClass.Parameters params) {
        String filter = 'Apttus_Billing__AssetLineItemId__c != null';
        return filter;
    }
}