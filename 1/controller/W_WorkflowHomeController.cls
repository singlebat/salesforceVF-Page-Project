public class W_WorkflowHomeController {
    public List<W_WorkflowHomeConstant> dislist{get;set;}
    public List<W_WorkflowHomeConstant> dislist2{get;set;}
    public String baseUrl{get;set;}
    //連絡事項
    public Notice__c renraku{get;set;}
    
    public String AppropriateAppointedAppTable{get;set;}
    public String JoinAppFormPPDDownloadTable{get;set;}
    public String ShiftDutySystemApplTable{get;set;}
    public String FlexWorkPlanApplTable{get;set;}
    public String HomeWorkAppointedApplTable{get;set;}
    public String DonationApplicationTable{get;set;}
    public String PoliFoundPartyTicketPurchaseApplTable{get;set;}
    public String DuesApplicationTable{get;set;}
    public String LayoutChangeApplTable{get;set;}
    
	public String UndwriApprNumRecordMissSurvey{get;set;}
    public String BatchRevisionAppl{get;set;}
    
    public List<String> obTypes;
    
    public  W_WorkflowHomeController() {
        //初期化
        init();
        //現在の登録者
        String userid=UserInfo.getUserId();

        //自分が対応の要対応一覧をゲット
        dislist=W_WorkflowHomeBiz.doSyoninsya(userid,obTypes);

		//対応中のワークフロー一覧をゲット
        dislist2=W_WorkflowHomeBiz.doSinseisya(userid,obTypes);
    }

    //初期化
    public void  init(){
        AppropriateAppointedAppTable=W_WorkflowHomeConstant.AppropriateAppointedAppTable;
        JoinAppFormPPDDownloadTable=W_WorkflowHomeConstant.JoinAppFormPPDDownloadTable;
        ShiftDutySystemApplTable=W_WorkflowHomeConstant.ShiftDutySystemApplTable;
        FlexWorkPlanApplTable=W_WorkflowHomeConstant.FlexWorkPlanApplTable;
        HomeWorkAppointedApplTable=W_WorkflowHomeConstant.HomeWorkAppointedApplTable;
        DonationApplicationTable=W_WorkflowHomeConstant.DonationApplicationTable;
        PoliFoundPartyTicketPurchaseApplTable=W_WorkflowHomeConstant.PoliFoundPartyTicketPurchaseApplTable;
        DuesApplicationTable=W_WorkflowHomeConstant.DuesApplicationTable;
        LayoutChangeApplTable=W_WorkflowHomeConstant.LayoutChangeApplTable;
        UndwriApprNumRecordMissSurvey=W_WorkflowHomeConstant.UndwriApprNumRecordMissSurvey;
        BatchRevisionAppl=W_WorkflowHomeConstant.BatchRevisionAppl;
        baseUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/lightning/o/';
        
        //計上特認申請
        obTypes =new List<String>();
        obTypes.add(AppropriateAppointedAppTable);
        //加入申込票システム印字データ提供依頼
        obTypes.add(JoinAppFormPPDDownloadTable);
        //シフト勤務制導入申請
        obTypes.add(ShiftDutySystemApplTable);
        //フレックス勤務制度導入申請
        obTypes.add(FlexWorkPlanApplTable);      
        //在宅勤務特認申請
        obTypes.add(HomeWorkAppointedApplTable);         
        //寄付申請
        obTypes.add(DonationApplicationTable);         
        //政治資金パーティー券購入申請
        obTypes.add(PoliFoundPartyTicketPurchaseApplTable); 
        //会費申請
        obTypes.add(DuesApplicationTable);        
        //レイアウト変更申請
        obTypes.add(LayoutChangeApplTable); 
        
        
        List<Notice__c> renrakulist=[select id,content__c,LastModifiedDate  from Notice__c order by  LastModifiedDate desc limit 1];
        if(renrakulist!= null && renrakulist.size()!=0){
            renraku=renrakulist[0];
        }
    }   
    
}