global class TaxCallback implements Apttus_Config2.CustomClass.ITaxCallback2 {
    global List<Apttus_Config2.CustomClass.TaxResult> computeTaxMultiple(
        List<Apttus_Config2.CustomClass.TaxInput> listTaxInput
    ) {
        return TaxCallbackService.getTaxResult(listTaxInput);
    }

    global Apttus_Config2.CustomClass.TaxResult computeTax(
        Apttus_Config2.CustomClass.TaxInput objTaxInput
    ) {
        return computeTaxMultiple(new List<Apttus_Config2.CustomClass.TaxInput>{ objTaxInput })[0];
    }
}