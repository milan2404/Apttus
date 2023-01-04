public class TriggerDispatcher {
    public static void Run(ITriggerHandler handler) {
        if (handler.IsDisabled()) {
            return;
        }

        switch on Trigger.operationType {
            when BEFORE_INSERT {
                handler.BeforeInsert(Trigger.new);
            }
            when AFTER_INSERT {
                handler.AfterInsert(Trigger.newMap);
            }
            when BEFORE_UPDATE {
                handler.BeforeUpdate(Trigger.newMap, Trigger.oldMap);
            }
            when AFTER_UPDATE {
                handler.AfterUpdate(Trigger.newMap, Trigger.oldMap);
            }
            when BEFORE_DELETE {
                handler.BeforeDelete(Trigger.oldMap);
            }
            when AFTER_DELETE {
                handler.AfterDelete(Trigger.oldMap);
            }
            when AFTER_UNDELETE {
                handler.AfterUndelete(Trigger.oldMap);
            }
        }
    }
}