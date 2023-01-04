public class TaxCallbackService {
    private static final Schema.SObjectType INVOICE_LINE_ITEM = Schema.Apttus_Billing__InvoiceLineItem__c.getSObjectType();
    private static final Schema.SObjectType CERDITMEMO_LINE_ITEM = Schema.Apttus_Billing__CreditMemoLineItem__c.getSObjectType();
    private static final String STR_TAX_ERROR_TAXCODE_NOT_FOUND = 'Tax Code was not found';

    public static List<Apttus_Config2.CustomClass.TaxResult> getTaxResult(
        List<Apttus_Config2.CustomClass.TaxInput> listTaxInput
    ) {
        List<Apttus_Config2.CustomClass.TaxInput> listTaxInputInvoice = new List<Apttus_Config2.CustomClass.TaxInput>();
        List<Apttus_Config2.CustomClass.TaxInput> listTaxInputCreditMemo = new List<Apttus_Config2.CustomClass.TaxInput>();
        for (Apttus_Config2.CustomClass.TaxInput objTaxInput : listTaxInput) {
            if (INVOICE_LINE_ITEM == objTaxInput.Item.getSObjectType()) {
                listTaxInputInvoice.add(objTaxInput);
            } else if (CERDITMEMO_LINE_ITEM == objTaxInput.Item.getSObjectType()) {
                listTaxInputCreditMemo.add(objTaxInput);
            }
        }

        List<Apttus_Config2.CustomClass.TaxResult> listTaxResult = new List<Apttus_Config2.CustomClass.TaxResult>();

        if (!listTaxInputInvoice.isEmpty()) {
            listTaxResult.addAll(getTaxResultForAll(listTaxInputInvoice));
        }

        if (!listTaxInputCreditMemo.isEmpty()) {
            listTaxResult.addAll(getTaxResultForAll(listTaxInputCreditMemo));
        }
        return listTaxResult;
    }

    public static List<Apttus_Config2.CustomClass.TaxResult> getTaxResultForAll(
        List<Apttus_Config2.CustomClass.TaxInput> listTaxInput
    ) {
        List<Apttus_Config2.CustomClass.TaxResult> listTaxResult = new List<Apttus_Config2.CustomClass.TaxResult>();

        for (Apttus_Config2.CustomClass.TaxInput objTaxInput : listTaxInput) {
            Apttus_Config2.CustomClass.TaxResult objTaxResult = new Apttus_Config2.CustomClass.TaxResult();
            Apttus_Billing.CustomClass.TaxResultHandback objTaxResultHandback = new Apttus_Billing.CustomClass.TaxResultHandback();
            objTaxResultHandback.lineItem = objTaxInput.Item;

            objTaxResult.Handback = objTaxResultHandback;
            objTaxResult.TaxAmount = 0;
            objTaxResult.TaxBreakups = new List<Apttus_Config2__TaxBreakup__c>();

            Id taxCodeId = (Id) objTaxInput.Item.get('Apttus_Billing__TaxCodeId__c');
            Apttus_Config2__TaxCode__c objTaxCode = TaxCodeService.mapTaxCode.get(taxCodeId);
            if (objTaxCode != null) {
                Apttus_Config2__TaxBreakup__c objTaxBreakup = new Apttus_Config2__TaxBreakup__c();
                objTaxBreakup.Apttus_Config2__Sequence__c = 1;
                objTaxBreakup.Apttus_Config2__LineItemId__c = objTaxInput.Item.Id;
                objTaxBreakup.Apttus_Config2__TaxType__c = objTaxCode.Apttus_Config2__Code__c;
                objTaxBreakup.Apttus_Config2__TaxRate__c = objTaxCode.TaxRate__c;
                objTaxBreakup.Apttus_Config2__TaxAmount__c =
                    objTaxInput.TaxableAmount *
                    objTaxCode.TaxRate__c *
                    0.01;
                objTaxBreakup.Apttus_Config2__TaxAppliesTo__c = Constants.TaxAppliesTo.NetPrice;
                objTaxBreakup.Apttus_Config2__BreakupType__c = Constants.TaxBreakupType.Detail;

                objTaxResult.TaxBreakups.add(objTaxBreakup);
                objTaxResult.TaxAmount += objTaxBreakup.Apttus_Config2__TaxAmount__c;

                System.debug(LoggingLevel.ERROR, 'MSATAX : ' + objTaxBreakup);
            }

            listTaxResult.add(objTaxResult);
        }
        return listTaxResult;
    }
}