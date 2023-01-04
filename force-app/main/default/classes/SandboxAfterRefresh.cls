global class SandboxAfterRefresh implements SandboxPostCopy {
    private static final String TimeZoneSidKey = 'Asia/Kolkata';
    private static final String LocaleSidKey = 'en_IN';
    private static final String EmailEncodingKey = 'UTF-8';
    private static final String LanguageLocaleKey = 'en_US';
    global void runApexClass(SandboxContext context) {
        System.debug(LoggingLevel.ERROR, 'MSA organizationId : ' + context.organizationId());
        System.debug(LoggingLevel.ERROR, 'MSA sandboxId : ' + context.sandboxId());
        System.debug(LoggingLevel.ERROR, 'MSA SandBoxname : ' + context.sandboxName());

        updateInstaceURL();
        String sandboxName = context.sandboxName();

        Profile objProfile = [
            SELECT Id, Name
            FROM Profile
            WHERE Name = 'System Administrator'
            LIMIT 1
        ];

        List<User> listUserToInsert = new List<User>();
        for (SandboxUser__c objSandboxUser : [
            SELECT Id, SanboxName__c, Email__c, UserName__c, FirstName__c, LastName__c
            FROM SandboxUser__c
            WHERE SanboxName__c = :sandboxName
        ]) {
            User objUser = new User();
            objUser.ProfileId = objProfile.Id;
            objUser.Email = objSandboxUser.Email__c;
            objUser.Username = objSandboxUser.UserName__c + '.' + sandboxName;
            objUser.FirstName = objSandboxUser.FirstName__c;
            objUser.LastName = objSandboxUser.LastName__c;
            objUser.Alias =
                objSandboxUser.FirstName__c.left(1) + objSandboxUser.LastName__c.left(3);
            objUser.TimeZoneSidKey = TimeZoneSidKey;
            objUser.LocaleSidKey = LocaleSidKey;
            objUser.EmailEncodingKey = EmailEncodingKey;
            objUser.LanguageLocaleKey = LanguageLocaleKey;
            insert objUser;
        }
        insert listUserToInsert;

        Set<Id> setUserId = new Set<Id>();
        for (User objUser : listUserToInsert) {
            System.resetPassword(objUser.Id, true);
            setUserId.add(objUser.Id);
        }

        ResetPasswordJob objBatch = new ResetPasswordJob(setUserId);
        Database.executeBatch(objBatch, objBatch.BATCH_SIZE);
    }

    private static void updateInstaceURL() {
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
    }
}