@isTest
public class Testsolvevaibhav {
    public static User u;
    public static PermissionSet ps;
    @testSetup
    public static void setup() {
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        system.debug(p);
        
        ps = [SELECT Id FROM PermissionSet WHERE Name='CQ_Admin_Extended_Permissions'];
        system.debug(ps);
        
        u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                     EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                     LocaleSidKey='en_US', ProfileId = p.Id,
                     TimeZoneSidKey='America/Los_Angeles', UserName='testpermissionsetuserAstreait@testorg.com');
        insert u;
        system.debug('user' + u);
        system.debug(' system.debug(UserInfo.getUserId()) '+UserInfo.getUserId());
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = u.Id,
            PermissionSetId = ps.Id
        );
        insert psa; 
    }
    
    @isTest
    public static void testsolveInsertion(){
        User u = [select Id,Name from User where UserName='testpermissionsetuserAstreait@testorg.com'];
        System.runAs(u) {
            Case newCase = new Case();
            newCase.Subject = 'Example Case Subject';
            newCase.Description = 'Example Case Description';
            newCase.Status = 'New'; 
            newCase.Origin = 'Web'; 
            newCase.Type='Problem';
            insert newCase;
            
            
            
            List<compliancequest__SQX_Nonconformance__c> creatednon = [SELECT Id FROM compliancequest__SQX_Nonconformance__c WHERE Related_to_Case__c = :newCase.Id];
            System.assertEquals(1, creatednon.size());
            
        }
        
    }
        @isTest
        public static void testsolveFalied() {
            
            User u = [select Id,Name from User where UserName='testpermissionsetuserAstreait@testorg.com'];
            System.runAs(u) {
                Case newCase = new Case();
                newCase.Subject = 'Example Case Subject';
                newCase.Description = 'Example Case Description';
                newCase.Status = 'New'; 
                newCase.Origin = 'Web'; 
                newCase.Type='Question';
                insert newCase;
                
                
                
                List<compliancequest__SQX_Nonconformance__c> creatednon = [SELECT Id FROM compliancequest__SQX_Nonconformance__c WHERE Related_to_Case__c = :newCase.Id];
                System.assertEquals(0, creatednon.size());
                
                
            }
        }
            
            @isTest
            public static void testsolveUpdate() {
                
                User u = [select Id,Name from User where UserName='testpermissionsetuserAstreait@testorg.com'];
                System.runAs(u) {
                    Case newCase = new Case();
                    newCase.Subject = 'Example Case Subject';
                    newCase.Description = 'Example Case Description';
                    newCase.Status = 'New'; 
                    newCase.Origin = 'Web'; 
                    newCase.Type='Question';
                    
                    insert newCase;
                    
                    
                    
                    List<compliancequest__SQX_Nonconformance__c> creatednon1 = [SELECT Id FROM compliancequest__SQX_Nonconformance__c WHERE Related_to_Case__c = :newCase.Id];
                    System.assertEquals(0, creatednon1.size());
                    newCase.Type = 'Problem';
                    update newcase;
                    
                    List<compliancequest__SQX_Nonconformance__c> creatednon = [SELECT Id FROM compliancequest__SQX_Nonconformance__c WHERE Related_to_Case__c = :newCase.Id];
                    System.assertEquals(1, creatednon.size());
                    
                }  
                }
            }