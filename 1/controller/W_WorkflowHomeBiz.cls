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
     public static Map<String ,String>  nameMap;
     public static List<W_WorkflowHomeConstant> doSyoninsya(List<ProcessInstance> plist){
        List<W_WorkflowHomeConstant> dlist=new List<W_WorkflowHomeConstant>();
        List<W_WorkflowHomeConstant> tempdlist=new List<W_WorkflowHomeConstant>();
        String flag='1';
        String AppropriateAppid='';
        String JoinAppFormid='';        
        String ShiftDutyid='';
        String FlexWorkid='';
        String HomeWorkid='';
        String Donationid='';
        String PoliFoundPartyid='';
        String DuesAppid='';
        String LayoutChangeid='';
        nameMap=new Map<String ,String>();
        for(ProcessInstance p:plist){
            for (ProcessInstanceHistory sw : p.StepsAndWorkitems) {
                nameMap.put(sw.TargetObjectId, sw.Actor.name);
                //idType.put(sw.TargetObjectId,sw.TargetObject.type);
                if(sw.TargetObject.type=='AppropriateAppointedApp__c'){
                    AppropriateAppid=AppropriateAppid+'\''+sw.TargetObjectId+'\',';
                }
                if(sw.TargetObject.type=='JoinAppFormPPDDownload__c'){
                    JoinAppFormid=JoinAppFormid+'\''+sw.TargetObjectId+'\',';
                }
                if(sw.TargetObject.type=='ShiftDutySystemAppl__c'){
                    ShiftDutyid=ShiftDutyid+'\''+sw.TargetObjectId+'\',';
                }
                if(sw.TargetObject.type=='FlexWorkPlanAppl__c'){
                    FlexWorkid=FlexWorkid+'\''+sw.TargetObjectId+'\',';
                }
                if(sw.TargetObject.type=='HomeWorkAppointedAppl__c'){
                    HomeWorkid=HomeWorkid+'\''+sw.TargetObjectId+'\',';
                }
                if(sw.TargetObject.type=='DonationApplication__c'){
                    Donationid=Donationid+'\''+sw.TargetObjectId+'\',';                    
                }
                if(sw.TargetObject.type=='PoliFoundPartyTicketPurchaseAppl__c'){
                    PoliFoundPartyid=PoliFoundPartyid+'\''+sw.TargetObjectId+'\',';     
                }
                if(sw.TargetObject.type=='DuesApplication__c'){
                    DuesAppid=DuesAppid+'\''+sw.TargetObjectId+'\',';
                }
                if(sw.TargetObject.type=='LayoutChangeAppl__c'){
                    LayoutChangeid=LayoutChangeid+'\''+sw.TargetObjectId+'\',';
                }
            }
        }
        if(AppropriateAppid!=''){
            DoSoqlAppropriateApp(nameMap,dlist,AppropriateAppid,flag);  
        }        
        if(JoinAppFormid!=''){
            DoSoqlJoinAppForm(nameMap,dlist,JoinAppFormid,flag);     
        }    
        if(ShiftDutyid!=''){
            DoSoqlShiftDuty(nameMap,dlist,ShiftDutyid,flag);
        }    
        if(FlexWorkid!=''){
            DoSoqlFlexWork(nameMap,dlist,FlexWorkid,flag);
        }    
        if(HomeWorkid!=''){
            DoSoqlHomeWork(nameMap,dlist,HomeWorkid,flag);
        }    
        if(Donationid!=''){
            DoSoqlDonation(nameMap,dlist,Donationid,flag);
        }    
        if(PoliFoundPartyid!=''){
            DoSoqlPoliFoundParty(nameMap,dlist,PoliFoundPartyid,flag);
        }    
        if(DuesAppid!=''){
            DoSoqlDuesApp(nameMap,dlist,DuesAppid,flag);
        }    
        if(LayoutChangeid!=''){
            DoSoqlLayoutChange(nameMap,dlist,LayoutChangeid,flag);
        }   
        //表示行数最大限は３０
        if(dlist!=null &&dlist.size()>30){
            for(Integer i=0;i<30;i++){
                tempdlist.add(dlist[i]);
            }
        }else{
            tempdlist=dlist;
        }
        system.debug(tempdlist);
        return tempdlist;
    }   
     public static List<W_WorkflowHomeConstant> doSinseisya(String actid2){
        List<W_WorkflowHomeConstant> templist2= new List<W_WorkflowHomeConstant>();
        List<W_WorkflowHomeConstant> templist= new List<W_WorkflowHomeConstant>();
        String flag='2';
        W_WorkflowHomeConstant newWork=new W_WorkflowHomeConstant();
        DoSoqlAppropriateApp(nameMap,templist,actid2,flag);
        DoSoqlJoinAppForm(nameMap,templist,actid2,flag);
        DoSoqlShiftDuty(nameMap,templist,actid2,flag);
        DoSoqlFlexWork(nameMap,templist,actid2,flag);
        DoSoqlHomeWork(nameMap,templist,actid2,flag);
        DoSoqlDonation(nameMap,templist,actid2,flag);
        DoSoqlPoliFoundParty(nameMap,templist,actid2,flag);
        DoSoqlDuesApp(nameMap,templist,actid2,flag);
        DoSoqlLayoutChange(nameMap,templist,actid2,flag);
        
        //表示行数最大限は３０
        if(templist!=null &&templist.size()>30){
            for(Integer i=0;i<30;i++){
                templist2.add(templist[i]);
            }
        }else{
            templist2=templist;
        }
        system.debug(templist2);
        return templist2;
    }
    public  static void DoSoqlAppropriateApp(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<AppropriateAppointedApp__c> returnSoqlAppropriateApp= W_WorkflowHomeDAO.returnSoqlAppropriateApp(ids,flag);
        for(AppropriateAppointedApp__c a:returnSoqlAppropriateApp){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseibu=a.CreatedBy.Department;
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseimei=SObjectType.AppropriateAppointedApp__c.getLabel();
            
            Date d=a.ApplicationDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.Status__c;                
            dis.admit=nameMap.get(a.id);
            system.debug(dis.admit);
            dislist.add(dis);
        }
    }
    public  static void DoSoqlJoinAppForm(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<JoinAppFormPPDDownload__c> returnSoqlJoinAppForm= W_WorkflowHomeDAO.returnSoqlJoinAppForm(ids,flag);
        for(JoinAppFormPPDDownload__c a:returnSoqlJoinAppForm){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.JoinAppFormPPDDownload__c.getLabel();
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseibu=a.CreatedBy.Department;
            Date d=a.ApplicationDate__c;
            if(d!=null){
                dis.sinseibi= d.year()+'/'+d.month()+'/'+d.day();
            }
            dis.sinseistatus=a.ApprovalStatus__c;        
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public  static void DoSoqlShiftDuty(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<ShiftDutySystemAppl__c> returnSoqlShiftDuty= W_WorkflowHomeDAO.returnSoqlShiftDuty(ids,flag);
        for(ShiftDutySystemAppl__c a:returnSoqlShiftDuty){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.ShiftDutySystemAppl__c.getLabel();
            dis.sinseibu=a.CreatedBy.Department;
            dis.sinseibi=a.ApplicationMonth__c;
            //申請日がないです
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseistatus=a.ApprovalStatus__c;           
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    public  static void DoSoqlFlexWork(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<FlexWorkPlanAppl__c> returnSoqlFlexWork= W_WorkflowHomeDAO.returnSoqlFlexWork(ids,flag);
        for(FlexWorkPlanAppl__c a:returnSoqlFlexWork){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.FlexWorkPlanAppl__c.getLabel();
            dis.sinseibu=a.CreatedBy.Department;
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseibi=a.ApplicationMonth__c;
            //申請日がないです
            dis.sinseistatus=a.ApprovalStatus__c;       
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
    
    public  static void DoSoqlHomeWork(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<HomeWorkAppointedAppl__c> returnSoqlHomeWork= W_WorkflowHomeDAO.returnSoqlHomeWork(ids,flag);
        for(HomeWorkAppointedAppl__c a:returnSoqlHomeWork){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.HomeWorkAppointedAppl__c.getLabel();
            dis.sinseibu=a.CreatedBy.Department;
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
    public  static void DoSoqlDonation(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<DonationApplication__c> returnSoqlDonation= W_WorkflowHomeDAO.returnSoqlDonation(ids,flag);
        for(DonationApplication__c a:returnSoqlDonation){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.DonationApplication__c.getLabel();
            dis.sinseibu=a.CreatedBy.Department;
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
    public  static void DoSoqlPoliFoundParty(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<PoliFoundPartyTicketPurchaseAppl__c> returnSoqlPoliFoundParty= W_WorkflowHomeDAO.returnSoqlPoliFoundParty(ids,flag);
        for(PoliFoundPartyTicketPurchaseAppl__c a:returnSoqlPoliFoundParty){
             W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseibu=a.CreatedBy.Department;
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

    public  static void DoSoqlDuesApp(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<DuesApplication__c> returnSoqlDuesApp= W_WorkflowHomeDAO.returnSoqlDuesApp(ids,flag);
        for(DuesApplication__c a:returnSoqlDuesApp){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseibu=a.CreatedBy.Department;
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
    
    public  static void DoSoqlLayoutChange(Map<String ,String>  nameMap,List<W_WorkflowHomeConstant> dislist,String ids,String flag){
        List<LayoutChangeAppl__c> returnSoqlLayoutChange= W_WorkflowHomeDAO.returnSoqlLayoutChange(ids,flag);
        for(LayoutChangeAppl__c a:returnSoqlLayoutChange){
            W_WorkflowHomeConstant dis=new W_WorkflowHomeConstant();
            dis.sinseimei=SObjectType.LayoutChangeAppl__c.getLabel();
            dis.sinseibu=a.CreatedBy.Department;
            if(a.ApplicationDate__c!=null){
                String temp=a.ApplicationDate__c;
                temp=temp.replace('年', '/');
                temp=temp.replace('月', '/');
                temp=temp.replace('日', '/');
                dis.sinseibi=temp;
            }
            dis.sinseiId=URL.getSalesforceBaseUrl().toExternalForm()+'/'+a.id;
            dis.sinseistatus=a.ApprStatus__c;             
            dis.admit=nameMap.get(a.id);
            dislist.add(dis);
        }
    }
        
}