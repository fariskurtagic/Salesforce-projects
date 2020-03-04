public class WarehouseCalloutServiceMock implements HttpCalloutMock{
    // implement http mock callout
    public HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"_id":"55d66226726b611100aaf749","replacement":true,"quantity":75,"name":"Ball Valve 8 cm","maintenanceperiod":0,"lifespan":0,"cost":42,"sku":"100011"}]');
        response.setStatusCode(200);
        return response; 
    }
}