public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(list <case> rms) {
        // TODO: Complete the method to update workorders
        List<Case> newWorkOrders = new List<Case>();
        for(Case c: rms){
            newWorkOrders.add(new Case(vehicle__c = c.vehicle__c, 
                                       equipment__c = c.Equipment__c,
                                       type= 'Routine Maintenance',
                                       date_reported__c = date.today(),
                                       subject = 'Auto Generated Routine Maintenance',
                                       origin = c.origin,
                                       accountid = c.AccountId,
                                       contactid = c.ContactId)); 
        }
        if(newWorkOrders.size()>0){
            insert newWorkOrders;
        }        
    }        
    
}