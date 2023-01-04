
String instanceURl = URL.getSalesforceBaseUrl().toExternalForm();
List<Sobject> listSobjectToUpdate = new List<Sobject>();



for (Apttus__ComplySystemProperties__c objSetting : [
    SELECT Id, Apttus__InstanceUrl__c
    FROM Apttus__ComplySystemProperties__c
]) {
    objSetting.Apttus__InstanceUrl__c = instanceURl;
    listSobjectToUpdate.add(objSetting);
}
for (Apttus_Proposal__ProposalSystemProperties__c objSetting : [
    SELECT Id, Apttus_Proposal__InstanceUrl__c
    FROM Apttus_Proposal__ProposalSystemProperties__c
]) {
    objSetting.Apttus_Proposal__InstanceUrl__c = instanceURl;
    listSobjectToUpdate.add(objSetting);
}
for (Apttus_Config2__ConfigSystemProperties__c objSetting : [
    SELECT Id, Apttus_Config2__InstanceUrl__c
    FROM Apttus_Config2__ConfigSystemProperties__c
]) {
    objSetting.Apttus_Config2__InstanceUrl__c = instanceURl;
    listSobjectToUpdate.add(objSetting);
}
for (Apttus_Approval__ApprovalsSystemProperties__c objSetting : [
    SELECT Id, Apttus_Approval__InstanceUrl__c
    FROM Apttus_Approval__ApprovalsSystemProperties__c
]) {
    objSetting.Apttus_Approval__InstanceUrl__c = instanceURl;
    listSobjectToUpdate.add(objSetting);
}
for (Apttus_XApps__XAuthorForExcelSystemProperties__c objSetting : [
    SELECT Id, Apttus_XApps__InstanceUrl__c
    FROM Apttus_XApps__XAuthorForExcelSystemProperties__c
]) {
    objSetting.Apttus_XApps__InstanceUrl__c = instanceURl;
    listSobjectToUpdate.add(objSetting);
}
update listSobjectToUpdate;