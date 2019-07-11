@isTest
public class W_WorkflowHomeControllerTest {
    private final static string USERPROFILE_NAME_WFINTERANL = 'WF社内ユーザ';
    static testMethod void W_WorkflowHomeControllerTest() {
        // WF社内ユーザ
        //W_CommonObjectSharingTestDataFactory.createUserUsingProfileName(USERPROFILE_NAME_WFINTERANL,'testuser001','sCd001');
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
		u.TitleCode__c='40';        
        u.SectionCode__c='test00';
        u.ManagementType__c='1';
        insert u;
        DepartmentMaster__c de=new DepartmentMaster__c();
        
        de.SectionCode__c='test00';
        insert de;


        //SELECT Id, UserOrGroupId,Group.type,Group.id,Group.DeveloperName FROM GroupMember where UserOrGroupId 
        
        Notice__c no=new Notice__c();
        no.content__c='test123';
        insert no;
        
        system.runAs(u){
            createDataAppropriate(u,de);
            createDataFlexWork(u);
            createDataJoinAppForm(u,de);
            createDataShiftDuty(u);
            createDataHomeWork(u);
            createDataDonation(u);
            createDataPoliFound(u);
            createDataDuesApp(u);
            //createDataLayout(u);
            Test.startTest();
            Group grp = new Group();
            grp.Name = 'Technology Partner Content';
            insert grp;
            GroupMember grpMem1 = new GroupMember();
            grpMem1.UserOrGroupId = u.id;
            grpMem1.GroupId = grp.Id;
            Insert grpMem1;
            Group grp2 = new Group();
            grp2.Name = 'Technology Partner Content';
            grp2.DeveloperName='WQ_test';
            grp2.type='Queue';
            insert grp2;
            GroupMember grpMem2 = new GroupMember();
            grpMem2.UserOrGroupId = grp.id;
            grpMem2.GroupId = grp2.Id;
            Insert grpMem2;
            W_WorkflowHomeController wtest= new W_WorkflowHomeController();       
            
            Test.stopTest();
        }
    }
    public static void createDataAppropriate(User u,DepartmentMaster__c de){
        List<AppropriationSpecialApprovalApp__c> alist=new List<AppropriationSpecialApprovalApp__c>();
        for(Integer i=0;i<40;i++){
            AppropriationSpecialApprovalApp__c a=new AppropriationSpecialApprovalApp__c();
            a.OwnerId=u.id;
            a.OrgCategory__c='営業課支社';
            a.Status__c='申請起案中';
            a.AppropriationDate__c='2019/08';
            a.ApplicationDDCode__c=de.id;
            a.SalesAdminstaff1_DD__c=de.id;
            a.SalesAdminstaff1__c=u.id;
            a.ConfirmedDate__c=date.today();
            a.BranchOfficeMgr1__c=u.id;
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
   
    public static void createDataJoinAppForm(User u,DepartmentMaster__c de){
        List<JoinAppFormPPDDownload__c> alist=new List<JoinAppFormPPDDownload__c>();
        for(Integer i=0;i<40;i++){
            JoinAppFormPPDDownload__c a=new JoinAppFormPPDDownload__c();
            a.OwnerId=u.id;
            a.BranchNumber__c='12';
            a.PolNumRenewal__c='1234567890';
            a.PPDCode__c='123456';
            a.SectionCode__c=de.id;
            a.Approver__c=u.id;
            a.Approver2__c=u.id;
            a.Approver3__c=u.id;
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
     
   /* public static void createDataLayout(User u){
        List<LayoutChangeAppl__c> alist=new List<LayoutChangeAppl__c>();
        for(Integer i=0;i<40;i++){
            LayoutChangeAppl__c a=new LayoutChangeAppl__c();
            a.OwnerId=u.id;
            a.GAHomeTransLayoutChange__c=true;
            a.ApprStatus__c='申請起案中';
            alist.add(a);
        }
        insert alist;
		system.debug(alist);
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
                
    }*/
    
    
}