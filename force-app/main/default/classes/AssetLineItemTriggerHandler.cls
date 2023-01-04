public class AssetLineItemTriggerHandler implements ITriggerHandler {
    public Boolean IsDisabled() {
        return false;
    }

    public void BeforeInsert(List<Apttus_Config2__AssetLineItem__c> listAssetLineItemNew) {
    }

    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        AssetLineItemTriggerService.updateAssetNumber(newItems.values());
    }

    public void BeforeDelete(Map<Id, SObject> oldItems) {
    }

    public void AfterInsert(Map<Id, SObject> newItems) {
    }

    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
    }

    public void AfterDelete(Map<Id, SObject> oldItems) {
    }

    public void AfterUndelete(Map<Id, SObject> oldItems) {
    }
}