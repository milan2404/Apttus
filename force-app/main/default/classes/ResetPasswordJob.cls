public class ResetPasswordJob implements Database.Batchable<sObject>, Database.Stateful {
    public final Integer BATCH_SIZE = 1;
    public final Set<Id> setUserId;
    public ResetPasswordJob(Set<Id> setUserId) {
        this.setUserId = setUserId;
    }

    public Database.QueryLocator start(Database.BatchableContext objBatchableContext) {
        String query = 'SELECT Id FROM USER ';
        query += ' WHERE Id IN :setUserId ';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext objBatchableContext, List<sObject> listUser) {
        for (sObject objUser : listUser) {
            System.resetPassword(objUser.Id, true);
        }
    }

    public void finish(Database.BatchableContext objBatchableContext) {
    }
}