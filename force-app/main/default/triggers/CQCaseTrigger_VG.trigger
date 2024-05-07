trigger CQCaseTrigger_VG on Case (After insert,After update) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            CQCaseTrigger_VaibhavGoyalHandler.solve(Trigger.newMap,Trigger.oldMap);
        }
    }
}