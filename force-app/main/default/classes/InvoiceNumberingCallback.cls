public with sharing class InvoiceNumberingCallback implements Apttus_Billing.CustomClass.IFacilitateCustomTransactionNumbers {
    public boolean isValidConfiguration(
        Apttus_Billing__CustomNumberingConfigurationSetting__c numberingConfigSettings
    ) {
        System.debug(LoggingLevel.Error, 'MSA in isValidConfiguration');
        System.debug(
            LoggingLevel.Error,
            'MSA in isValidConfiguration : ' + numberingConfigSettings
        );
        if (
            numberingConfigSettings.Apttus_Billing__ObjectType__c.equals(
                Apttus_Billing.CustomClass.CUSTOM_NUMBERING_OBJECT_TYPE_INVOICE
            )
        ) {
            if (
                true == numberingConfigSettings.Apttus_Billing__FieldOneEnabled__c &&
                false == numberingConfigSettings.Apttus_Billing__FieldtwoEnabled__c &&
                false == numberingConfigSettings.Apttus_Billing__FieldThreeEnabled__c &&
                false == numberingConfigSettings.Apttus_Billing__FieldFourEnabled__c &&
                false == numberingConfigSettings.Apttus_Billing__FieldFiveEnabled__c
            ) {
                return true;
            }
        }

        return false;
    }

    public List<List<String>> fetchInvoiceCustomNumberingFieldLists(
        List<Apttus_Billing__Invoice__c> invoices,
        Apttus_Billing__CustomNumberingConfigurationSetting__c customNumberingConfigSetting
    ) {
        System.debug(LoggingLevel.Error, 'MSA in fetchInvoiceCustomNumberingFieldLists');
        System.debug(
            LoggingLevel.Error,
            'MSA in fetchInvoiceCustomNumberingFieldLists : ' + customNumberingConfigSetting
        );
        List<List<String>> fieldLists = new List<List<String>>();
        for (Apttus_Billing__Invoice__c inv : invoices) {
            List<String> fieldList = new List<String>();
            fieldList.add(inv.Apttus_Billing__BillingCountry__c);
            fieldLists.add(fieldList);
        }
        return fieldLists;
    }
}