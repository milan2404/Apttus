public class ResetUserJob implements Database.Batchable<sObject>, Database.Stateful {
    public final Integer BATCH_SIZE = 1;
    public final String sandboxName;
    public final Set<Id> setUserId;

    public ResetUserJob(String sandboxName) {
        this.sandboxName = sandboxName;
        this.setUserId = new Set<Id>();
    }

    public Database.QueryLocator start(Database.BatchableContext objBatchableContext) {
        String query = 'SELECT Id FROM User ';
        query += ' WHERE FederationIdentifier = \'Reset\' ';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext objBatchableContext, List<sObject> listsObject) {
        List<SandboxUser__c> listSandboxUser = [
            SELECT Id, SanboxName__c, Email__c, UserName__c, FirstName__c, LastName__c
            FROM SandboxUser__c
            WHERE SanboxName__c = :sandboxName
        ];

        List<User> listUserToUpdate = new List<User>();
        List<User> listUser = (List<User>) listsObject;
        for (User objUser : listUser) {
            for (SandboxUser__c objSandboxUser : listSandboxUser) {
                objUser.Email = objSandboxUser.Email__c;
                objUser.FirstName = objSandboxUser.FirstName__c;
                objUser.LastName = objSandboxUser.LastName__c;
                objUser.Alias = objUser.FirstName.left(1) + objUser.LastName.left(3);
            }
            listUserToUpdate.add(objUser);
            setUserId.add(objUser.Id);
        }
        update listUserToUpdate;

        listUserToUpdate = new List<User>();
        for (User objUser : listUser) {
            for (SandboxUser__c objSandboxUser : listSandboxUser) {
                objUser.Username = objSandboxUser.UserName__c + '.' + sandboxName;
            }
            listUserToUpdate.add(objUser);
            setUserId.add(objUser.Id);
        }
        update listUserToUpdate;
    }

    public void finish(Database.BatchableContext BC) {
        ResetPasswordJob objBatch = new ResetPasswordJob(setUserId);
        ID batchprocessid = Database.executeBatch(objBatch, objBatch.BATCH_SIZE);
    }
}