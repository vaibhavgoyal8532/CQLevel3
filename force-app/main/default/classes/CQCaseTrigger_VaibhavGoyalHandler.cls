public class CQCaseTrigger_VaibhavGoyalHandler {
    public static void solve(Map<Id,Case>newMap , Map<Id,Case>oldMap){
      set<Id> caseIds = new set<Id>();
        List<compliancequest__SQX_Nonconformance__c> CQnonList = new List<compliancequest__SQX_Nonconformance__c>();
	 List<compliancequest__SQX_Nonconformance__c>nonList = [select Id,Related_to_Case__c from compliancequest__SQX_Nonconformance__c where Related_to_Case__c In:newMap.keyset()];
        for(compliancequest__SQX_Nonconformance__c n:nonList){
            caseIds.add(n.Related_to_Case__c);
        }
       


        for(Id key:newMap.keyset()){
            Case c = newMap.get(key);
            if(c.Type == 'Problem'  && (Trigger.IsInsert || (Trigger.isUpdate))){
                if(!caseIds.contains(c.Id)){
                compliancequest__SQX_Nonconformance__c non = new compliancequest__SQX_Nonconformance__c();
                non.compliancequest__Type__c = 'Customer';
                non.compliancequest__Type_Of_Issue__c = 'Product';
                non.compliancequest__Occurrence_Date__c = Date.Today();
                non.compliancequest__NC_Title__c = 'vaibhavCQ';
                non.compliancequest__Type_Of_Issue__c = 'Product';
                non.Related_to_Case__c = key; 
                caseIds.add(non.Related_to_Case__c);
                CQnonList.add(non);
                }
            }

        }
        if(!CQnonList.isEmpty())
            insert CQnonList;
        
        }
       
        
       
     

}