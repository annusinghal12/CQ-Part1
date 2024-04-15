public class CQPartRestCallout {
	
    @AuraEnabled
    public static boolean cqRestAPICallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:CQ_Parts_API');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<SQX_Part__c> cqPartList = new List<SQX_Part__c>();
            Map<String, Account> accountMap = new Map<String, Account>();
            for(Account acc : [select id, name from Account where Name IN ('High Volume','Low Volume')]){
                accountMap.put(acc.Name, acc);
            }
            for(Object resultObj : results){
                Map<String, Object> result = (Map<String, Object>)resultObj;
                SQX_Part__c cqPart = new SQX_Part__c();
                cqPart.Name = (String)result.get('Part Name');
                cqPart.Active__c = true;
                cqPart.Part_Number__c = (String)result.get('_id');
                Integer totalQuantityShipped =  (Integer)result.get('Total Quantity Shipped');
                if(totalQuantityShipped < 99){
                    cqPart.Related_Account__c = accountMap.get('High Volume').id;
                }else{
                    cqPart.Related_Account__c = accountMap.get('Low Volume').id;
                }
                cqPartList.add(cqPart);
            }
            //system.debug('cqPartList>>'+ cqPartList);
            Database.upsert(cqPartList,SQX_Part__c.Part_Number__c,false);
            return true;
        }
        return false;
    }
}