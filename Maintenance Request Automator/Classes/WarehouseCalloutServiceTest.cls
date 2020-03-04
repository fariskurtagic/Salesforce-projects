@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
    @isTest 
    static  void testGetCallout(){ 
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        test.stopTest();
        System.assertEquals(1, [Select id from Product2].size());

    }
    
    public static String CRON_EXP = '1 0 0 15 3 ? 2020';
    @istest
    static void testScheduledJob() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        test.startTest();    
        System.schedule('ScheduledApexTest', CRON_EXP, 
                        new WarehouseSyncSchedule());   
        test.stopTest();
        System.assertEquals(1, [Select id from Product2].size());
    }
}