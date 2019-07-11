/***********************************************************
*
* File Name: W_ProcessInstanceHistoryDAO.cls
*
* Created: 2019/05/27
* Author: tian
************************************************************/
/**
 * プロセスから履歴を検索する共通クラス
 * Pending状態かつSobjectが該当する
 * @author tian
 */
public  with sharing class W_ProcessInstanceHistoryDAO extends BaseDao{
  public static List<ProcessInstance> getProcessInstance(List<String> actorIdList,List<String> obTypes,String flg,List<String> targetId){
        String soql='SELECT Id,TargetObject.type';
        soql=soql+' ,(SELECT';
        soql=soql+' Id';
        soql=soql+' ,ActorId';
        soql=soql+' ,Actor.name';
        soql=soql+' ,TargetObjectId,TargetObject.type';
        soql=soql+' FROM StepsAndWorkitems';
        if(flg=='承認'){
          soql=soql+' where  ActorId in :actorIdList';
          soql=soql+' and StepStatus=\'Pending\'';
        }else{
          //soql=soql+' where  createdById in :actorIdList';  
          soql=soql+' where StepStatus=\'Pending\'';
        }
        
      	soql=soql+' )';
        soql=soql+' FROM';
        soql=soql+' ProcessInstance';
        soql=soql+' where TargetObject.type in :obTypes';
        if(flg!='承認'){
      		soql=soql+' and TargetObjectId in :targetId';
        }      
      	soql=soql+' and status=\'Pending\'';
      	soql=soql+' ORDER BY CreatedDate';
      	soql=soql+' limit 30000';
        system.debug(soql);
        List<ProcessInstance> plist=Database.query(soql);
        return plist;
    }
    
}