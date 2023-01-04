public abstract class AssetLineItemTriggerService {
    public static void updateAssetNumber(List<Apttus_Config2__AssetLineItem__c> listAssetLineItem) {
        for (Apttus_Config2__AssetLineItem__c objAssetLineItem : listAssetLineItem) {
            objAssetLineItem.Apttus_Config2__AssetNumber__c = objAssetLineItem.AutoNumber__c;
        }
    }
}