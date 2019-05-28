/***********************************************************
*
* File Name: W_ProcessInstanceHistoryDAO.cls
*
* Created: 2019/05/27
* Author: tian
************************************************************/
/**
 * プロセスから履歴を検索する共通クラス
 * @author tian
 */
public  with sharing class W_ProcessInstanceHistoryDAO extends BaseDao{
  public static List<ProcessInstance> getProcessInstance(String actid,String obTypes){
        String soql='SELECT Id,TargetObject.type';
        soql=soql+' ,(SELECT';
        soql=soql+' Id';
        soql=soql+' ,ActorId';
        soql=soql+' ,Actor.name';
        soql=soql+' ,TargetObjectId,TargetObject.type';
        soql=soql+' FROM StepsAndWorkitems';
        soql=soql+' where '+actid;
        soql=soql+' ORDER BY CreatedDate DESC )';
        soql=soql+' FROM';
        soql=soql+' ProcessInstance';
        soql=soql+' where TargetObject.type in '+obTypes;
      	soql=soql+' and status=\'Pending\'';
      	soql=soql+' limit 30000';
        system.debug(soql);
        List<ProcessInstance> plist=Database.query(soql);
        system.debug(plist);
        return plist;
    }
}