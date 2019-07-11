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
    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
 	public  static List<AppropriationSpecialApprovalApp__c> returnSoqlAppropriateApp(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        //申請部署
        result=result+' ApplicationDDCode__r.SectionAbbreviatedName_Kanji__c,';
        //申請日
        result=result+' ApplicationDate__c,';
        //ステータス
        result=result+' Status__c';
        result=result+' from '+W_WorkflowHomeConstant.AppropriateAppointedAppTable;
        if(flag=='申請'){
            result=result+ ' where OwnerId=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }

        result=result+ ' and Status__c  in (\'申請起案中\'';
        result=result+ ',\'申請確認中（営業K）\'';
        result=result+ ',\'申請確認中（商品担当）\'';
        result=result+ ',\'申請確認中（商品K）\'';
        result=result+ ',\'回答起案中（営事担当）\'';
        result=result+ ',\'回答確認中（営事K）\'';
        result=result+ ',\'センター送付中（営業担当）\'';
        result=result+ ',\'計上確定中（事務S）\'';
        result=result+ ',\'要再考\',\'取り下げ\')';
        system.debug(result);
     	return Database.query(result);
    }
   
    public static List<JoinAppFormPPDDownload__c> returnSoqlJoinAppForm(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        //申請日
        result=result+' ApplicationDate__c,';
        result=result+' ApprovalStatus__c,';
        //result=result+' CreatedBy.Department';
        result=result+' SectionCode__r.SectionAbbreviatedName_Kanji__c';
        
        result=result+' from '+W_WorkflowHomeConstant.JoinAppFormPPDDownloadTable;
        if(flag=='申請'){
            result=result+ ' where CreatedById=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }
        
        result=result+ ' and ApprovalStatus__c  in (\'取り下げ\',\'課支社内承認待ち\',\'差戻し\'';
        result=result+ ',\'データ取得エラー\',\'承認済み(RPA対応待ち)\',\'申請起案中\')';
        return Database.query(result);
    }
    
    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ 
    public static List<ShiftDutySystemAppl__c>  returnSoqlShiftDuty(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApplDivisionCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApplicationMonth__c,';
        result=result+' ApprovalStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.ShiftDutySystemApplTable;
        if(flag=='申請'){
            result=result+ ' where CreatedById=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }            

        result=result+ ' and ApprovalStatus__c  in (\'起案取消\',\'差し戻し\'';
        result=result+ ',\'承認待ち\',\'申請待ち\')';
        return Database.query(result);
    }

    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
    public static List<FlexWorkPlanAppl__c> returnSoqlFlexWork(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApplicationMonth__c,';
        //result=result+' CreatedBy.Department,';
        result=result+' ApplDivDDCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApprovalStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.FlexWorkPlanApplTable;
        if(flag=='申請'){
            result=result+ ' where CreatedById=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }

        result=result+ ' and ApprovalStatus__c  in (\'起案取消\',\'差し戻し\'';
        result=result+ ',\'承認待ち\',\'申請待ち\')';
        return Database.query(result);
       
    }
    
    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
    public static List<HomeWorkAppointedAppl__c> returnSoqlHomeWork(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' DepartmentDivisionCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApplicationDate__c,';
        result=result+' ApprovalStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.HomeWorkAppointedApplTable;
        if(flag=='申請'){
            result=result+ ' where CreatedById=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }
        result=result+ ' and ApprovalStatus__c  in (\'起案取消\',\'差し戻し\'';
        result=result+ ',\'承認待ち\',\'申請待ち\')';
        return Database.query(result);
      
    }

    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
    public static List<DonationApplication__c> returnSoqlDonation(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApprStatus__c,';
        result=result+' ApplDDCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApplName__r.name,';
        result=result+' ApplDate__c';
        result=result+' from '+W_WorkflowHomeConstant.DonationApplicationTable;
        if(flag=='申請'){
            result=result+ ' where ApplName__c=\''+ids[0]+'\'';
        }else{
           result=result+ ' where id in :ids'; 
        }
        result=result+ ' and ApprStatus__c  in (\'領収書受領結果承認待ち\',\'経費計上内容承認待ち\'';
        result=result+ ',\'経費計上待ち\',\'総務部長承認待ち\',\'差し戻し\'';
        result=result+ ',\'総務課長承認待ち\',\'寄付選考会議承認待ち\',\'総務担当承認待ち\'';
        result=result+ ',\'部支店長承認待ち\',\'連名部署承認待ち\',\'申請起案中\')';
        return Database.query(result);
    }
     
    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
    public static List<PoliFoundPartyTicketPurchaseAppl__c> returnSoqlPoliFoundParty(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApplDDCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApplDate__c,';
        result=result+' Applicant__r.name,';
        result=result+' ApprStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.PoliFoundPartyTicketPurchaseApplTable;
        if(flag=='申請'){
            result=result+ ' where Applicant__c=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }  
        result=result+ ' and ApprStatus__c  in (\'経費計上内容承認待ち\',\'経費計上待ち\'';
        result=result+ ',\'総務課長承認待ち\',\'総務担当承認待ち\'';
        result=result+ ',\'部支店長承認待ち\',\'差し戻し\'';
        result=result+ ',\'連名部署承認待ち\',\'申請起案中\')';
        return Database.query(result); 
    }
     
    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
    public static List<DuesApplication__c> returnSoqlDuesApp(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApplDDCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApplyingDate__c,';
        result=result+' Applicant__r.name,';
        result=result+' ApprStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.DuesApplicationTable;
        if(flag=='申請'){
            result=result+ ' where Applicant__c=\''+ids[0]+'\'';
        }else{
            result=result+ ' where id in :ids';
        }
        result=result+ ' and ApprStatus__c  in (\'内容変更の為、取り下げ\',\'経費計上内容承認待ち\'';
        result=result+ ',\'経費計上待ち\',\'総務部長承認待ち\',\'差し戻し\'';
        result=result+ ',\'総務課長承認待ち\',\'総務担当承認待ち\',\'部支店長承認待ち\'';
        result=result+ ',\'連名部署承認待ち\',\'申請起案中\')';

		return Database.query(result); 
    }
    
    //flag=='1'登録者が承認者の場合のSOQLを実行するフラグ
    //flag!='1'登録者が申請者の場合のSOQLを実行するフラグ
    /*public static List<LayoutChangeAppl__c> returnSoqlLayoutChange(List<String> ids,String flag){
        String result='';
        result=result+'SELECT Id,';
        result=result+' ApplDivsionCode__r.SectionAbbreviatedName_Kanji__c,';
        result=result+' ApplicationDate__c,';
        result=result+' ApprStatus__c';
        result=result+' from '+W_WorkflowHomeConstant.LayoutChangeApplTable;
        if(flag=='1'){
            result=result+ ' where id in :ids';
        }else{
            result=result+ ' where ApplicantStaff__c=\''+ids[0]+'\'';
        }   
        result=result+ ' and ApprStatus__c  in (\'工事実施確認待ち\',\'実施決定判断③総務部不動産ファシリティ担当B承認待ち\'';
        result=result+ ',\'実施決定判断②総務部ファシリティチームK承認待ち\',\'実施決定判断①ビジネスサポートオフィス第一部承認待ち\'';
        result=result+ ',\'レイアウト確定\',\'レイアウト案検討中\',\'レイアウト図面作成\',\'差し戻し\'';
        result=result+ ',\'変更申請可否判断④総務部不動産ファシリティ担当B承認待ち\',\'変更申請可否判断③総務部ファシリティチームK承認待ち\'';
        result=result+ ',\'変更申請可否判断②ビジネスサポートオフィス第一部承認待ち\',\'変更申請可否判断①ブロック総務Ｂ・Ｋ承認待ち\',\'申請起案中\')';
        return Database.query(result); 
    }*/
}