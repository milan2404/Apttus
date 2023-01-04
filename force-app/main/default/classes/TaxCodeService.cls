public abstract class TaxCodeService {
    public static List<Apttus_Config2__TaxCode__c> listTaxCode {
        get {
            if (listTaxCode == null) {
                listTaxCode = [
                    SELECT Id, Name, Apttus_Config2__Code__c, Taxrate__c
                    FROM Apttus_Config2__TaxCode__c
                    LIMIT :Constants.SOQL.RowLimit
                ];
            }
            return listTaxCode;
        }
        private set;
    }

    public static Map<Id, Apttus_Config2__TaxCode__c> mapTaxCode {
        get {
            if (mapTaxCode == null) {
                mapTaxCode = new Map<Id, Apttus_Config2__TaxCode__c>(listTaxCode);
            }
            return mapTaxCode;
        }
        private set;
    }
}