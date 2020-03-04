public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');    
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            List<object> results = (List<object>) JSON.deserializeUntyped(response.getBody());
            Map<String,Object> Equipment = new Map<String,Object>();
            List<product2> Equipments = new List<product2>();
            for ( integer i=0; i<results.size(); i++){
                Equipment = (Map<String,Object>)results[i];
                equipments.add(new Product2(name=(String)Equipment.get('name'),
                                            Replacement_Part__c=(Boolean)Equipment.get('replacement'),
                                            Cost__c=(Decimal)Equipment.get('cost'),
                                            Current_Inventory__c=(Integer)Equipment.get('quantity'),
                                            Lifespan_Months__c=(Integer)Equipment.get('lifespan'),
                                            Maintenance_Cycle__c=(Integer)Equipment.get('maintenanceperiod'),
                                            Warehouse_SKU__c=(String)Equipment.get('sku')));
            }
            upsert equipments Warehouse_SKU__c;
        }
    }
}