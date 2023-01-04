public class ResetPasswordJob implements Database.Batchable<sObject>, Database.Stateful {
    public final Integer BATCH_SIZE = 1;
    public final Set<Id> setUserId;
    public ResetPasswordJob(Set<Id> setUserId) {
        this.setUserId = setUserId;
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.ERROR, 'MSA 001 : in Start ');
        String query = 'SELECT Id FROM USER ';
        query += ' WHERE Id IN :setUserId ';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> listUser) {
        System.debug(LoggingLevel.ERROR, 'MSA 001 : in execute ');
        for (sObject obUser : listUser) {
            System.debug(LoggingLevel.ERROR, 'MSA 001 : in execute obUser : ' + obUser);
            System.resetPassword(obUser.Id, true);
        }
    }

    public void finish(Database.BatchableContext BC) {
    }
}