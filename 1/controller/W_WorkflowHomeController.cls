public class W_WorkflowHomeController {
    public List<W_WorkflowHomeConstant> dislist{get;set;}
    public List<W_WorkflowHomeConstant> dislist2{get;set;}
    public String username{get;set;}
    public String baseUrl{get;set;}
    
    public String AppropriateAppointedAppTable{get;set;}
    public String JoinAppFormPPDDownloadTable{get;set;}
    public String ShiftDutySystemApplTable{get;set;}
    public String FlexWorkPlanApplTable{get;set;}
    public String HomeWorkAppointedApplTable{get;set;}
    public String DonationApplicationTable{get;set;}
    public String PoliFoundPartyTicketPurchaseApplTable{get;set;}
    public String DuesApplicationTable{get;set;}
    public String LayoutChangeApplTable{get;set;}

    public String obTypes;
    
    public  W_WorkflowHomeController() {
        //初期化
        init();
        //現在の登録者
        String userid=UserInfo.getUserId();
        User u=[select name from User where id=:userid];
        username=u.name;
        String actid=' ActorId=\''+userid+'\'';
       
        //String actid=' ActorId=\''+'0050k000002jgYMAAY'+'\'';
        //String actid2='0050k000002SHqgAAG';
        
        List<ProcessInstance> Plist=W_ProcessInstanceHistoryDAO.getProcessInstance(actid,obTypes);
        //自分が対応の要対応一覧をゲット
        dislist=W_WorkflowHomeBiz.doSyoninsya(Plist);
		//対応中のワークフロー一覧をゲット
        dislist2=W_WorkflowHomeBiz.doSinseisya(userid);
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
        baseUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/lightning/o/';
        
        //計上特認申請
        obTypes='(\''+AppropriateAppointedAppTable+'\'';
        //加入申込票システム印字データ提供依頼
        obTypes=obTypes+',\''+JoinAppFormPPDDownloadTable+'\'';
        //シフト勤務制導入申請
        obTypes=obTypes+',\''+ShiftDutySystemApplTable+'\'';  
        //フレックス勤務制度導入申請
        obTypes=obTypes+',\''+FlexWorkPlanApplTable+'\'';        
        //在宅勤務特認申請
        obTypes=obTypes+',\''+HomeWorkAppointedApplTable+'\'';          
        //寄付申請
        obTypes=obTypes+',\''+DonationApplicationTable+'\'';          
        //政治資金パーティー券購入申請
        obTypes=obTypes+',\''+PoliFoundPartyTicketPurchaseApplTable+'\''; 
        //会費申請
        obTypes=obTypes+',\''+DuesApplicationTable+'\'';          
        //レイアウト変更申請
        obTypes=obTypes+',\''+LayoutChangeApplTable+'\')'; 
        
    }   
    
}