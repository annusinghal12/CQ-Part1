@isTest
global class CQPartHttpCalloutMock implements HttpCalloutMock {
    Integer statusCode;
    
    global CQPartHttpCalloutMock(Integer statusCode){
        this.statusCode = statusCode;
    }
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"_id":"629989816a50f02a0000b83e","Part Name":"Pressure Adapt","Total Quantity Shipped":12,"Part Number":"PA-001","Part Risk Level":3,"Part Description":"PA Description","SKU":"A","Related Parts":"619683d69402c24f000237e9; 629989816a50f02a0000b83e"},{"_id":"62998ecc6a50f02a0000b87d","Part Name":"Pressure Sensor","Total Quantity Shipped":100,"Part Description":"PRS Desciprtion","Part Risk Level":3,"Part Number":"PRS-001","SKU":"B","Related Parts":"619643769402c24f000229ec; 62998ecc6a50f02a0000b87d; 619643919402c24f000229ef"},{"_id":"619643919402c24f000229ef","Part Name":"Population Sensor","Total Quantity Shipped":125000,"Part Description":"PS Description","Part Risk Level":4,"Part Number":"PS-001","SKU":"B","Related Parts":"619643769402c24f000229ec; 62998ecc6a50f02a0000b87d; 619643919402c24f000229ef"},{"_id":"619683d69402c24f000237e9","Part Name":"Population Sensor","Total Quantity Shipped":350000,"Part Description":"Population Sensor Description","Part Risk Level":5,"Part Number":"Population Sensor","SKU":"A","Related Parts":"619683d69402c24f000237e9; 629989816a50f02a0000b83e"},{"_id":"619643769402c24f000229ec","Part Name":"Drill Gauge","Total Quantity Shipped":125000,"Part Description":"Drill Gauge Desc","Part Risk Level":2,"Part Number":"DG-001","SKU":"B","Related Parts":"619643769402c24f000229ec; 62998ecc6a50f02a0000b87d; 619643919402c24f000229ef"}]');
        response.setStatusCode(this.statusCode);
        return response;
    }
    
}