/***********************************************************
*
* File Name: W_WorkflowHomeDAO.cls
*
* Created: 2019/05/27
* Author: tian
************************************************************/
/**
 * Workflowホームページデータ取得共通クラス
 * @author tian
 */
public  with sharing class W_WorkflowHomeDAO extends BaseDao{
 	public  static List<AppropriateAppointedApp__c> returnSoqlAppropriateApp(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        //申請部署
        result=result+' CreatedBy.Department,';
        //申請日
        result=result+' ApplicationDate__c,';
        //ステータス
        result=result+' Status__c';
        result=result+' from '+W_WorkflowHomeConstant.AppropriateAppointedAppTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where OwnerId=\''+ids+'\'';
        }
        result=result+ ' and Status__c not in (\'完了\',\'差し戻し\')';
        system.debug(result);
     	return Database.query(result);
    }
   
    public static List<JoinAppFormPPDDownload__c> returnSoqlJoinAppForm(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        //申請日
        result=result+' ApplicationDate__c,';
        result=result+' ApprovalStatus__c,';
        result=result+' CreatedBy.Department';
        result=result+' from '+W_WorkflowHomeConstant.JoinAppFormPPDDownloadTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where CreatedById=\''+ids+'\'';
        }
        result=result+ ' and ApprovalStatus__c not in (\'完了\',\'差戻し\')';
        return Database.query(result);
    }
     
    public static List<ShiftDutySystemAppl__c>  returnSoqlShiftDuty(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' CreatedBy.Department,';
        result=result+' ApplicationMonth__c,';
        result=result+' ApprovalStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.ShiftDutySystemApplTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where CreatedById=\''+ids+'\'';
        }            
        result=result+ ' and ApprovalStatus__c not in (\'完了\',\'差戻し\',\'取り消し\')';
        return Database.query(result);
    }

    public static List<FlexWorkPlanAppl__c> returnSoqlFlexWork(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApplicationMonth__c,';
        result=result+' CreatedBy.Department,';
        result=result+' ApprovalStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.FlexWorkPlanApplTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where CreatedById=\''+ids+'\'';
        }
        result=result+ ' and ApprovalStatus__c not in (\'完了\',\'差戻し\',\'取り消し\')';
        return Database.query(result);
       
    }
    
    public static List<HomeWorkAppointedAppl__c> returnSoqlHomeWork(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' CreatedBy.Department,';
        result=result+' ApplicationDate__c,';
        result=result+' ApprovalStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.HomeWorkAppointedApplTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where CreatedById=\''+ids+'\'';
        }
        result=result+ ' and ApprovalStatus__c not in (\'完了\',\'差戻し\',\'取り消し\')';
        return Database.query(result);
      
    }

    public static List<DonationApplication__c> returnSoqlDonation(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApprStatus__c,';
        result=result+' CreatedBy.Department,';
        result=result+' ApplDate__c';
        result=result+' from '+W_WorkflowHomeConstant.DonationApplicationTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where ApplName__c=\''+ids+'\'';
        }
        result=result+ ' and ApprStatus__c not in (\'完了\',\'差戻し\')';
        return Database.query(result);
    }
    
    public static List<PoliFoundPartyTicketPurchaseAppl__c> returnSoqlPoliFoundParty(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' CreatedBy.Department,';
        result=result+' ApplDate__c,';
        result=result+' ApprStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.PoliFoundPartyTicketPurchaseApplTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where Applicant__c=\''+ids+'\'';
        }  
        result=result+ ' and ApprStatus__c not in (\'完了\',\'差戻し\')';
        return Database.query(result); 
    }
      
    public static List<DuesApplication__c> returnSoqlDuesApp(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' CreatedBy.Department,';
        result=result+' ApplyingDate__c,';
        result=result+' ApprStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.DuesApplicationTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where Applicant__c=\''+ids+'\'';
        }
        result=result+ ' and ApprStatus__c not in (\'完了\',\'差戻し\')';
		return Database.query(result); 
    }
    
    public static List<LayoutChangeAppl__c> returnSoqlLayoutChange(String ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' CreatedBy.Department,';
        result=result+' ApplicationDate__c,';
        result=result+' ApprStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.LayoutChangeApplTable;
        if(flag=='1'){
            result=result+ ' where id in ('+ids.substring(0,ids.length()-1)+')';
        }else{
            result=result+ ' where ApplicantStaff__c=\''+ids+'\'';
        }   
        result=result+ ' and ApprStatus__c not in (\'完了\',\'差戻し\')';
		return Database.query(result); 
    }
}