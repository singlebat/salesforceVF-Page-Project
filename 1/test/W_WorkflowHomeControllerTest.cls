@isTest
public class W_WorkflowHomeControllerTest {
    
    static testMethod void W_WorkflowHomeControllerTest() {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'システム管理者' LIMIT 1];
        User u=new User();
        u.Username='xxxxxxx@e.com';
        u.LastName='sss';
        u.Email='test1@exa.com';
        u.Alias='test1';
        u.CommunityNickname='aaaa';
        u.TimeZoneSidKey='Asia/Tokyo';
        u.LocaleSidKey='ja_JP';
        u.EmailEncodingKey='ISO-2022-JP';
        u.PhoneticSymbol__c='Cテンチョウ';
        u.ProfileId=profileId.id;
        u.LanguageLocaleKey='ja';        
        insert u;
        
        
        system.runAs(u){
            createDataAppropriate(u);
            createDataFlexWork(u);
            createDataJoinAppForm(u);
            createDataShiftDuty(u);
            createDataHomeWork(u);
            createDataDonation(u);
            createDataPoliFound(u);
            createDataDuesApp(u);
            createDataLayout(u);
            Test.startTest();
            
            W_WorkflowHomeController wtest= new W_WorkflowHomeController();       
            
            Test.stopTest();
        }
    }
    public static void createDataAppropriate(User u){
        List<AppropriateAppointedApp__c> alist=new List<AppropriateAppointedApp__c>();
        for(Integer i=0;i<40;i++){
            AppropriateAppointedApp__c a=new AppropriateAppointedApp__c();
            a.OwnerId=u.id;
            a.OrgCategory__c='営業課支社';
            a.Status__c='申請起案中';
            a.ApproverSalesAdminManager__c=u.id;
            a.ApproverSalesAdminStaff__c=u.id;
            a.Authorizer__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
   
    public static void createDataJoinAppForm(User u){
        List<JoinAppFormPPDDownload__c> alist=new List<JoinAppFormPPDDownload__c>();
        for(Integer i=0;i<40;i++){
            JoinAppFormPPDDownload__c a=new JoinAppFormPPDDownload__c();
            a.OwnerId=u.id;
            a.BranchNumber__c='12';
            a.PolNumRenewal__c='1234567890';
            a.PPDCode__c='123456';
            a.Approver__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }   
    
    public static void createDataShiftDuty(User u){
        List<ShiftDutySystemAppl__c> alist=new List<ShiftDutySystemAppl__c>();
        for(Integer i=0;i<40;i++){
            ShiftDutySystemAppl__c a=new ShiftDutySystemAppl__c();
            a.OwnerId=u.id;
            a.Approver__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }   
    
    public static void createDataFlexWork(User u){
        List<FlexWorkPlanAppl__c> alist=new List<FlexWorkPlanAppl__c>();
        for(Integer i=0;i<40;i++){
            FlexWorkPlanAppl__c a=new FlexWorkPlanAppl__c();
            a.OwnerId=u.id;
            a.FlexShiftC__c='F';
            a.Approver__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
    
    public static void createDataHomeWork(User u){
        List<HomeWorkAppointedAppl__c> alist=new List<HomeWorkAppointedAppl__c>();
        for(Integer i=0;i<40;i++){
            HomeWorkAppointedAppl__c a=new HomeWorkAppointedAppl__c();
            a.OwnerId=u.id;
            a.Approver__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
    
     public static void createDataDonation(User u){
        List<DonationApplication__c> alist=new List<DonationApplication__c>();
        for(Integer i=0;i<40;i++){
            DonationApplication__c a=new DonationApplication__c();
            a.OwnerId=u.id;
			a.PBMgrName__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
    
      public static void createDataPoliFound(User u){
        List<PoliFoundPartyTicketPurchaseAppl__c> alist=new List<PoliFoundPartyTicketPurchaseAppl__c>();
        for(Integer i=0;i<40;i++){
            PoliFoundPartyTicketPurchaseAppl__c a=new PoliFoundPartyTicketPurchaseAppl__c();
            a.OwnerId=u.id;
            a.PBMgrName__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
    
    
      public static void createDataDuesApp(User u){
        List<DuesApplication__c> alist=new List<DuesApplication__c>();
        for(Integer i=0;i<40;i++){
            DuesApplication__c a=new DuesApplication__c();
            a.OwnerId=u.id;
            a.PBMgrName__c=u.id;
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
     
    public static void createDataLayout(User u){
        List<LayoutChangeAppl__c> alist=new List<LayoutChangeAppl__c>();
        for(Integer i=0;i<40;i++){
            LayoutChangeAppl__c a=new LayoutChangeAppl__c();
            a.OwnerId=u.id;
            a.BlockGAStaff__c=u.id;
            a.Approver1OfFirDe__c=u.id;
            a.Approver2OfFirDe__c=u.id;
            //a.Approver1BSOfFirDe__c=u.id;
            a.GAHomeTransLayoutChange__c=true;
            a.ApprStatus__c='申請起案中';
            alist.add(a);
        }
        insert alist;

		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(alist[0].id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u.Id); 
        List<Id> param=new List<Id>();
        param.add(u.Id);
		req1.setNextApproverIds(param);     

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);       
                
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}