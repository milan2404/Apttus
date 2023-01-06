global with sharing class AssetLineItemFilterCallback implements Apttus_Config2.CustomClass.IAssetLineItemCallback3 {
    // Apttus_Config2__ProductType__c
    public static final String PRODUCT_TYPE_WALLET = 'Wallet';

    // System properties
    public static final String PROP_SYSTEM_PROPERTIES = 'System Properties';

    //WalletFlow Field Value from Billing System Properties
    private String walletFlowCustomFieldValues;

    /**
     * Method to initialize variables and thereby start the callback.
     **/
    global void start(
        Apttus_Config2.ProductConfiguration configuration,
        String assetSearchFilter,
        List<String> assetSearchScope
    ) {
        Apttus_Billing__BillingSystemProperties__c prop = Apttus_Billing__BillingSystemProperties__c.getInstance(
            PROP_SYSTEM_PROPERTIES
        );
        walletFlowCustomFieldValues = prop.Apttus_Billing__WalletFlow__c;
    }

    /**
     * Method to get query filter.
     **/
    global String getQueryFilter(ID accountId) {
        return '';
    }

    /**
     * Method to get string expression to put along with where clause to filter asset line items.
     **/
    global String getFilterExpr(Apttus_Config2.CustomClass.ActionParams params) {
        String conditionExpression = '';

        if (params.Flow == walletFlowCustomFieldValues) {
            conditionExpression = 'Apttus_Config2__AccountId__c = \'' + params.AccountId + '\' ';
            conditionExpression +=
                ' AND Apttus_Config2__ProductType__c = \'' +
                PRODUCT_TYPE_WALLET +
                '\'';
            conditionExpression += ' AND Apttus_Config2__EndDate__c >= Today';
        } else {
            conditionExpression = 'Apttus_Config2__AccountId__c = \'' + params.AccountId + '\' ';
            conditionExpression +=
                ' AND Apttus_Config2__ProductType__c != \'' +
                PRODUCT_TYPE_WALLET +
                '\'';
        }
        return conditionExpression;
    }

    /**
     * Methog to get list of scopes to search asset.
     **/
    global List<String> getAssetSearchScope() {
        return new List<String>();
    }

    /**
     * Method to perform finalization before ending callback execution.
     **/
    global void finish() {
    }

    global Boolean validateAssetTermination(
        Set<ID> assetIds,
        Set<ID> accountIds,
        Date effectiveDate
    ) {
        return true;
    }
}