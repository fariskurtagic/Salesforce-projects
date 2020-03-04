trigger MaintenanceRequest on Case (before update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    List<Case> mRequests = new List<Case>();
    for (case c : Trigger.new){
        if(c.status == 'Closed' && (c.type == 'Repair' || c.type == 'Routine Maintenance')){
            mRequests.add(c);
        }
    }
    // List <case> rms = [SELECT Type, vehicle__c, Equipment__c, subject, Date_Reported__c, 
    //                    (Select id, Maintenance_Cycle__c FROM Product) 
    //                    FROM Case WHERE Id IN :Trigger.New];
    if (mRequests.size() > 0){
        MaintenanceRequestHelper.updateWorkOrders(mRequests);
    }
}