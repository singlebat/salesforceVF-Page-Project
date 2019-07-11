/***********************************************************
*
* File Name: W_WorkflowHomeBiz.cls
*
* Created: 2019/05/27
* Author: tian
************************************************************/
/**
* WorkflowHome表示用データを取得するクラス
* @author tian
*/
public class W_WorkflowHomeBiz {
    /**
* userid:現在ユーザーID
*/
    public static List<String> getSyounin(String userid){
        //承認履歴の取得条件です、割当先の集合
        List<String> ActorList=new List<String>();
        //必ず登録者が入っています
        ActorList.add(userid);
        //目的なキューをゲットする
        List<String> tempgroupList=new List<String>();
        List<GroupMember> tempqum=[SELECT Group.DeveloperName FROM GroupMember WHERE  Group.type='Queue' and Group.DeveloperName like 'WQ_%'];
        //目的なキューが存在する場合だけ実行する
        if(tempqum!=null && tempqum.size()!=0){
            List<String> tempQueueList=new List<String>();
            for(GroupMember grp:tempqum){
                //表示ラベルを保存
                tempQueueList.add(grp.Group.DeveloperName);
            }
            //system.debug(tempQueueList);    
            //現在の登録者が所属するグループをゲット
            List<GroupMember> tempgroMemList=[SELECT Id, UserOrGroupId,Group.type,Group.id,Group.DeveloperName FROM GroupMember where UserOrGroupId =:userid];
            if(tempgroMemList!=null && tempgroMemList.size()!=0){
                for(GroupMember gro:tempgroMemList){
                    //もしこのグループがキューの場合、キューを追加する
                    if(gro.Group.type=='Queue'&& tempQueueList.contains(gro.Group.DeveloperName)){
                        ActorList.add(gro.Group.id);
                    }else if(gro.Group.type=='Regular'){
                        //現在ユーザーが所属されるグループ
                        tempgroupList.add(gro.Group.id);
                    }
                }
            }
            system.debug(ActorList);
            //Queueの場合,ユーザーが所属するグループで再検索
            if(tempgroupList!=null && tempgroupList.size()!=0){
                List<GroupMember> tempgroMemList2=[SELECT Group.Name,Group.id,Group.type,Group.DeveloperName, UserOrGroupId FROM GroupMember WHERE  Group.type='Queue' and UserOrGroupId in:tempgroupList];
                if(tempgroMemList2!=null && tempgroMemList2.size()!=0){
                    for(GroupMember gro:tempgroMemList2){
                        if(tempQueueList.contains(gro.Group.DeveloperName)){
                            ActorList.add(gro.Group.id);
                        }
                    }
                }
            }
        }
        return ActorList;
    }
    //自分が承認者の場合
    public static List<W_WorkflowHomeConstant> doSyoninsya(String userid,List<String> obTypes){
        //承認履歴の情報をゲット
        List<String> ActorList=getSyounin(userid);
        List<ProcessInstance> Plist=W_ProcessInstanceHistoryDAO.getProcessInstance(ActorList,obTypes,'承認',null);
        system.debug(Plist);
        
        List<W_WorkflowHomeConstant> dlist=new List<W_WorkflowHomeConstant>();
        List<W_WorkflowHomeConstant> tempdlist=new List<W_WorkflowHomeConstant>();

        List<String> AppropriateAppid=new List<String>();
        List<String> JoinAppFormid=new List<String>();        
        List<String> ShiftDutyid=new List<String>();
        List<String> FlexWorkid=new List<String>();
        List<String> HomeWorkid=new List<String>();
        List<String> Donationid=new List<String>();
        List<String> PoliFoundPartyid=new List<String>();
        List<String> DuesAppid=new List<String>();
        List<String> LayoutChangeid=new List<String>();
        Map<String ,String> nameMap=new Map<String ,String>();
        //承認者が重複かどうかの確認用マップ
        Map<String ,List<String>> tempNameMap=new Map<String ,List<String>>();
        for(ProcessInstance p:plist){
            for (ProcessInstanceHistory sw : p.StepsAndWorkitems) {
                //stepの中に、承認者が自分あるいは自分が所属するグループ
                //はじめの時、レコードが一承認者しかない場合
                nameMap.put(sw.TargetObjectId, sw.Actor.name);
                
                if(sw.TargetObject.type==W_WorkflowHomeConstant.AppropriateAppointedAppTable){
                    AppropriateAppid.add(sw.TargetObjectId);
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.JoinAppFormPPDDownloadTable){
                    JoinAppFormid.add(sw.TargetObjectId);
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.ShiftDutySystemApplTable){
                    ShiftDutyid.add(sw.TargetObjectId);
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.FlexWorkPlanApplTable){
                    FlexWorkid.add(sw.TargetObjectId);
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.HomeWorkAppointedApplTable){
                    HomeWorkid.add(sw.TargetObjectId);
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.DonationApplicationTable){
                    Donationid.add(sw.TargetObjectId);                    
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.PoliFoundPartyTicketPurchaseApplTable){
                    PoliFoundPartyid.add(sw.TargetObjectId);     
                }
                if(sw.TargetObject.type==W_WorkflowHomeConstant.DuesApplicationTable){
                    DuesAppid.add(sw.TargetObjectId);
                }
                /*if(sw.TargetObject.type==W_WorkflowHomeConstant.LayoutChangeApplTable){
                    LayoutChangeid.add(sw.TargetObjectId);
                }*/
            }
        }
        

        if(AppropriateAppid!=null&&AppropriateAppid.size()!=0){
            DoSoqlAppropriateApp(nameMap,dlist,AppropriateAppid,null);  
        }
        if(JoinAppFormid!=null&&JoinAppFormid.size()!=0){
            DoSoqlJoinAppForm(nameMap,dlist,JoinAppFormid,null);     
        }    
        if(ShiftDutyid!=null&&ShiftDutyid.size()!=0){
            DoSoqlShiftDuty(nameMap,dlist,ShiftDutyid,null);
        }    
        if(FlexWorkid!=null&&FlexWorkid.size()!=0){
            DoSoqlFlexWork(nameMap,dlist,FlexWorkid,null);
        }    
        if(HomeWorkid!=null&&HomeWorkid.size()!=0){
            DoSoqlHomeWork(nameMap,dlist,HomeWorkid,null);
        }    
        if(Donationid!=null&&Donationid.size()!=0){
            DoSoqlDonation(nameMap,dlist,Donationid,null);
        }    
        if(PoliFoundPartyid!=null&&PoliFoundPartyid.size()!=0){
            DoSoqlPoliFoundParty(nameMap,dlist,PoliFoundPartyid,null);
        }    
        if(DuesAppid!=null&&DuesAppid.size()!=0){
            DoSoqlDuesApp(nameMap,dlist,DuesAppid,null);
        }    
        //system.debug(LayoutChangeid);
        /*if(LayoutChangeid!=null&&LayoutChangeid.size()!=0){
            DoSoqlLayoutChange(nameMap,dlist,LayoutChangeid,flag);
            for(Integer i=0;i<dlist.size();i++){
            system.debug(dlist[i]);
            }
        } */  
        //表示行数最大限は３０
        if(dlist!=null &&dlist.size()>30){
            for(Integer i=0;i<30;i++){
                tempdlist.add(dlist[i]);
            }
        }else{
            tempdlist=dlist;
        }
        //申請日が古いやつを前置き
        W_WorkflowHomeConstant temp=new W_WorkflowHomeConstant();
        List<W_WorkflowHomeConstant> tempdlistNUll=new List<W_WorkflowHomeConstant>();
        //一回目の時は、NULLとNULL以外のやつを分ける
        for(Integer i=0;i<tempdlist.size();i++){
            if(tempdlist[i].sinseibi==null){
                    tempdlistNUll.add(tempdlist[i]);
                    tempdlist.remove(i);
                	//romoveしたあと、tempdlistの数が一項減った、loop中のiはリストのインデックスと一致するため
                	i = (i == 0 ? 0 : i - 1);
            }  
        }
        //NULL以外に場合、順番並び
        for(Integer i=0;i<tempdlist.size();i++){
            for(Integer j=0;j<tempdlist.size()-i-1;j++){
                if(setStringToDateFormat(tempdlist[j].sinseibi)> setStringToDateFormat(tempdlist[j+1].sinseibi)) {
                    temp=tempdlist[j];
                    tempdlist[j]=tempdlist[j+1];
                    tempdlist[j+1]=temp;
                }
            }
        }
        //また、NULLのやつを最後に追加
        for(W_WorkflowHomeConstant wc:tempdlistNUll){
            tempdlist.add(wc);
        }
        return tempdlist;
    }   
    private static Date setStringToDateFormat(String myDate) {
        Integer myIntYear;
        Integer myIntMonth;
        Integer myIntDate;
        String[] myDateOnly = myDate.split('/');
        //year
        myIntYear = integer.valueOf(myDateOnly[0]);
        //month
        myIntMonth = integer.valueOf(myDateOnly[1]);
        //day
        if(myDateOnly.size()==2){
            myIntDate=1;
        }else{
            myIntDate = integer.valueOf(myDateOnly[2]);
        }
       Date d = Date.newInstance(myIntYear, myIntMonth, myIntDate);
       return d;
	}
    //自分が申請者の場合
    public static List<W_WorkflowHomeConstant> doSinseisya(String actid2,List<String> obTypes){
        List<String> targetIdList=new List<String>();
        //各DAOを実行する
        //登録者が申請者の場合のSOQLを実行するフラグ
        String flag='申請';
        List<String> actlist=new List<String>();
        actlist.add(actid2);
        List<DuesApplication__c> returnSoqlDuesApp= W_WorkflowHomeDAO.returnSoqlDuesApp(actlist,flag);
        for(DuesApplication__c due:returnSoqlDuesApp){
            targetIdList.add(due.id);
        }
        system.debug('targetIdList'+targetIdList);
        List<PoliFoundPartyTicketPurchaseAppl__c> returnSoqlPoliFoundParty= W_WorkflowHomeDAO.returnSoqlPoliFoundParty(actlist,flag);
        for(PoliFoundPartyTicketPurchaseAppl__c pol:returnSoqlPoliFoundParty){
            targetIdList.add(pol.id);
        }
        List<DonationApplication__c> returnSoqlDonation= W_WorkflowHomeDAO.returnSoqlDonation(actlist,flag);
        for(DonationApplication__c don:returnSoqlDonation){
            targetIdList.add(don.id);
        }
        List<HomeWorkAppointedAppl__c> returnSoqlHomeWork= W_WorkflowHomeDAO.returnSoqlHomeWork(actlist,flag);
        for(HomeWorkAppointedAppl__c hom:returnSoqlHomeWork){
            targetIdList.add(hom.id);
        }
        List<FlexWorkPlanAppl__c> returnSoqlFlexWork= W_WorkflowHomeDAO.returnSoqlFlexWork(actlist,flag);
        for(FlexWorkPlanAppl__c fle:returnSoqlFlexWork){
            targetIdList.add(fle.id);
        }
        List<ShiftDutySystemAppl__c> returnSoqlShiftDuty= W_WorkflowHomeDAO.returnSoqlShiftDuty(actlist,flag);
        for(ShiftDutySystemAppl__c shi:returnSoqlShiftDuty){
            targetIdList.add(shi.id);
        }
        List<JoinAppFormPPDDownload__c> returnSoqlJoinAppForm= W_WorkflowHomeDAO.returnSoqlJoinAppForm(actlist,flag);
        for(JoinAppFormPPDDownload__c joi:returnSoqlJoinAppForm){
            targetIdList.add(joi.id);
        }
        List<AppropriationSpecialApprovalApp__c> returnSoqlAppropriateApp= W_WorkflowHomeDAO.returnSoqlAppropriateApp(actlist,flag);
        for(AppropriationSpecialApprovalApp__c app:returnSoqlAppropriateApp){
            targetIdList.add(app.id);
        }
        
        List<ProcessInstance> PlistSinsei=W_ProcessInstanceHistoryDAO.getProcessInstance(actlist,obTypes,'申請',targetIdList);        
        system.debug('PlistSinsei'+PlistSinsei);
        
        Map<String ,String> nameMap=new Map<String ,String>();
        //承認者が重複かどうかの確認用マップ
        Map<String ,List<String>> tempNameMap=new Map<String ,List<String>>();
        for(ProcessInstance p:PlistSinsei){
            for (ProcessInstanceHistory sw : p.StepsAndWorkitems) {
                //stepの中に、同じレコードでも、複数の承認者存在の場合、区別しなければならない
                if(nameMap.containsKey(sw.TargetObjectId)){
                    String name=nameMap.get(sw.TargetObjectId);
                    List<String> tempnamelist=tempNameMap.get(sw.TargetObjectId);
                    //承認者は並列に表示する
                    if(!tempnamelist.contains(sw.ActorId)){
                        name =name +'<br/>'+sw.Actor.name;
                        nameMap.put(sw.TargetObjectId, name);  
                        tempnamelist.add(sw.ActorId);
                        tempNameMap.put(sw.TargetObjectId, tempnamelist);
                    }
                }else{
                    //はじめの時、レコードが一承認者しかない場合
                    nameMap.put(sw.TargetObjectId, sw.Actor.name);
                    List<String> namelist=new List<String>();
                    namelist.add(sw.ActorId);
                    tempNameMap.put(sw.TargetObjectId, namelist);
                }
            }
        }
        
        List<W_WorkflowHomeConstant> templist2= new List<W_WorkflowHomeConstant>();
        List<W_WorkflowHomeConstant> templist= new List<W_WorkflowHomeConstant>();
 
        DoSoqlAppropriateApp(nameMap,templist,actlist,returnSoqlAppropriateApp);
        DoSoqlJoinAppForm(nameMap,templist,actlist,returnSoqlJoinAppForm);
        DoSoqlShiftDuty(nameMap,templist,actlist,returnSoqlShiftDuty);
        DoSoqlFlexWork(nameMap,templist,actlist,returnSoqlFlexWork);
        DoSoqlHomeWork(nameMap,templist,actlist,returnSoqlHomeWork);
        DoSoqlDonation(nameMap,templist,actlist,returnSoqlDonation);
        DoSoqlPoliFoundParty(nameMap,templist,actlist,returnSoqlPoliFoundParty);
        DoSoqlDuesApp(nameMap,templist,actlist,returnSoqlDuesApp);
        //DoSoqlLayoutChange(nameMap,templist,actlist,flag);
        
        //表示行数最大限は３０
        if(templist!=null &&templist.size()>30){
            for(Integer i=0;i<30;i++){
                templist2.add(templist[i]);
            }
        }else{
            templist2=templist;
        }
        //申請日が最新のやつを前置き
        W_WorkflowHomeConstant temp=new W_WorkflowHomeConstant();
        List<W_WorkflowHomeConstant> tempdlistNUll=new List<W_WorkflowHomeConstant>();

        //一回目の時は、NULLとNULL以外のやつを分ける
        for(Integer i=0;i<templist2.size();i++){
            if(templist2[i].sinseibi==null){
                    tempdlistNUll.add(templist2[i]);
                    templist2.remove(i);
                	//romoveしたあと、tempdlistの数が一項減った、loop中のiはリストのインデックスと一致するため
                	i = (i == 0 ? 0 : i - 1);
            }  
        }
        for(Integer i=0;i<templist2.size();i++){
             system.debug(templist2[i].sinseibi);
        }
        //NULL以外に場合、順番並び
        for(Integer i=0;i<templist2.size();i++){
            system.debug(templist2[i].sinseibi);
            for(Integer j=0;j<templist2.size()-i-1;j++){
                if(setStringToDateFormat(templist2[j].sinseibi)> setStringToDateFormat(templist2[j+1].sinseibi)) {
                    temp=templist2[j];
                    templist2[j]=templist2[j+1];
                    templist2[j+1]=temp;
                }
            }
        }
        //また、NULLのやつを最後に追加
        for(W_WorkflowHomeConstant wc:tempdlistNUll){
            templist2.add(wc);
        }        
        
        system.debug(templist2);
        return templist2;
    }
    public static  void DoSoqlAppropriateApp(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<AppropriationSpecialApprovalApp__c> returnSoqlAppropriateApp){
        if(returnSoqlAppropriateApp==null){
            returnSoqlAppropriateApp= W_WorkflowHomeDAO.returnSoqlAppropriateApp(ids,'');
        }
        for(AppropriationSpecialApprovalApp__c a:returnSoqlAppropriateApp){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            //申請部署
            dis.sinseibu=a.ApplicationDDCode__r.SectionAbbreviatedName_Kanji__c;
            //遷移リンク
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseimei=SObjectType.AppropriationSpecialApprovalApp__c.getLabel();
            //申請日
            Date d=a.ApplicationDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.Status__c;                
            //承認者
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public  static void DoSoqlJoinAppForm(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<JoinAppFormPPDDownload__c> returnSoqlJoinAppForm){
        if(returnSoqlJoinAppForm==null){
            returnSoqlJoinAppForm= W_WorkflowHomeDAO.returnSoqlJoinAppForm(ids,'');
        }
        for(JoinAppFormPPDDownload__c a:returnSoqlJoinAppForm){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.JoinAppFormPPDDownload__c.getLabel();
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseibu=a.SectionCode__r.SectionAbbreviatedName_Kanji__c;
            Date d=a.ApplicationDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.ApprovalStatus__c;        
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public static  void DoSoqlShiftDuty(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<ShiftDutySystemAppl__c> returnSoqlShiftDuty){
        if(returnSoqlShiftDuty==null){
            returnSoqlShiftDuty= W_WorkflowHomeDAO.returnSoqlShiftDuty(ids,'');
        }
        for(ShiftDutySystemAppl__c a:returnSoqlShiftDuty){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.ShiftDutySystemAppl__c.getLabel();
            //申請部署
            dis.sinseibu=a.ApplDivisionCode__r.SectionAbbreviatedName_Kanji__c;
            dis.sinseibi=a.ApplicationMonth__c;
            //申請日がないです
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseistatus=a.ApprovalStatus__c;           
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public static  void DoSoqlFlexWork(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<FlexWorkPlanAppl__c> returnSoqlFlexWork){
        if(returnSoqlFlexWork==null){
            returnSoqlFlexWork= W_WorkflowHomeDAO.returnSoqlFlexWork(ids,'');
        }
        for(FlexWorkPlanAppl__c a:returnSoqlFlexWork){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.FlexWorkPlanAppl__c.getLabel();
            //dis.sinseibu=a.CreatedBy.Department;
            dis.sinseibu=a.ApplDivDDCode__r.SectionAbbreviatedName_Kanji__c;
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseibi=a.ApplicationMonth__c;
            //申請日がないです
            dis.sinseistatus=a.ApprovalStatus__c;       
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    
    public static void DoSoqlHomeWork(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<HomeWorkAppointedAppl__c> returnSoqlHomeWork){
        if(returnSoqlHomeWork==null){
            returnSoqlHomeWork= W_WorkflowHomeDAO.returnSoqlHomeWork(ids,'');
        }
        for(HomeWorkAppointedAppl__c a:returnSoqlHomeWork){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.HomeWorkAppointedAppl__c.getLabel();
            //dis.sinseibu=a.CreatedBy.Department;
            //申請部署
            dis.sinseibu=a.DepartmentDivisionCode__r.SectionAbbreviatedName_Kanji__c;
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            Date d=a.ApplicationDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.ApprovalStatus__c;      
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public static  void DoSoqlDonation(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<DonationApplication__c> returnSoqlDonation){
        if(returnSoqlDonation==null){
            returnSoqlDonation= W_WorkflowHomeDAO.returnSoqlDonation(ids,'');
        }
        for(DonationApplication__c a:returnSoqlDonation){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.DonationApplication__c.getLabel();
            dis.sinseibu=a.ApplDDCode__r.SectionAbbreviatedName_Kanji__c;
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            Date d=a.ApplDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.ApprStatus__c;        
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public  static void DoSoqlPoliFoundParty(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<PoliFoundPartyTicketPurchaseAppl__c> returnSoqlPoliFoundParty){
        if(returnSoqlPoliFoundParty==null){
            returnSoqlPoliFoundParty= W_WorkflowHomeDAO.returnSoqlPoliFoundParty(ids,'');
        }
        for(PoliFoundPartyTicketPurchaseAppl__c a:returnSoqlPoliFoundParty){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseibu=a.ApplDDCode__r.SectionAbbreviatedName_Kanji__c;
            dis.sinseimei=SObjectType.PoliFoundPartyTicketPurchaseAppl__c.getLabel();
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            Date d=a.ApplDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.ApprStatus__c;      
            dis.admit=nameMap.get(a.id);

            dislist.add(dis);
        }
    }
    
    public static  void DoSoqlDuesApp(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,List<DuesApplication__c> returnSoqlDuesApp){
        if(returnSoqlDuesApp==null){
            returnSoqlDuesApp= W_WorkflowHomeDAO.returnSoqlDuesApp(ids,'');
        }
        for(DuesApplication__c a:returnSoqlDuesApp){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseibu=a.ApplDDCode__r.SectionAbbreviatedName_Kanji__c;
            dis.sinseimei=SObjectType.DuesApplication__c.getLabel();
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            Date d=a.ApplyingDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.ApprStatus__c;
            dis.admit=nameMap.get(a.id);
 
            dislist.add(dis);
        }
    }
    
    /*public static  void DoSoqlLayoutChange(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,List<String> ids,String flag){
    List<LayoutChangeAppl__c> returnSoqlLayoutChange= W_WorkflowHomeDAO.returnSoqlLayoutChange(ids,flag);
    system.debug(returnSoqlLayoutChange);
    for(LayoutChangeAppl__c a:returnSoqlLayoutChange){
    W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
    dis.sinseimei=SObjectType.LayoutChangeAppl__c.getLabel();
    dis.sinseibu=a.ApplDivsionCode__r.SectionAbbreviatedName_Kanji__c;
    if(a.ApplicationDate__c!=null){
    String temp=a.ApplicationDate__c;
    temp=temp.replace('年', '/');
    temp=temp.replace('月', '/');
    temp=temp.replace('日', '');
    dis.sinseibi=temp;
    }
    dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
    dis.sinseistatus=a.ApprStatus__c;             
    dis.admit=nameMap.get(a.id);
    dislist.add(dis);
    }
    system.debug(dislist);
    }*/
    
}