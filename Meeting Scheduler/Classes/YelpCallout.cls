public class YelpCallout {
    public static HttpResponse getYelpCallout(string s) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.yelp.com/v3'+s);
        request.setMethod('GET');
        request.setHeader('authorization', 'bearer hIyzeG3EmDScnxJ7TCpC4LBjxT5gRK1b8oqax1M22Hw1SuL-q63WqKZ07F9dbhNtKnxiBS2NLeOI03iVCLG8Yg2nXHodNo5JeLltvZDxHFV5zY3vjyworBiKs9U1XnYx');
        HttpResponse response = http.send(request);
        return response;
    }
    
    public static list <Object> getBusinesses(HttpResponse response){
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> Businesses = (List<Object>) results.get('businesses');
        List<Object> names = new List<string>();
        //if(businesses !=null){
        //    for (integer i=0; i<businesses.size();i++){
        //        Map<String, Object> business = (Map<String, Object>) businesses[i];
        //        names.add(business.get('name'));
        //    }
        //}
        return Businesses;
    }
    
    public static list <Object> getBusinessSearch(string location){
        HttpResponse response = getYelpCallout('/businesses/search?location='+location);
        return getBusinesses(response);
    }
    public static list <Object> getPhoneSearch(string phone){
        HttpResponse response = getYelpCallout('/businesses/search/phone?phone='+phone);
        return getBusinesses(response);
    }
    public static list <Object> getTransactionSearch(string location){
        HttpResponse response = getYelpCallout('/transactions/delivery/search?location='+location);
        return getBusinesses(response);
    }
    public static Object getBusinessDetails(string id){
        HttpResponse response = getYelpCallout('/businesses/'+id);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        object name = results.get('name');
        return name;
    }
    public static list <Object> getBusinessReviews(string id){
        HttpResponse response = getYelpCallout('/businesses/'+id+'/reviews');
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> reviews = (List<Object>) results.get('reviews');
        List<Object> r = new List<string>();
        if(reviews !=null){
            for (integer i=0; i<reviews.size();i++){
                Map<String, Object> review = (Map<String, Object>) reviews[i];
                r.add(review.get('text'));
            }
        }
        return r;
    }
    public static List <Object> getAutocomplete(string word){
        HttpResponse response = getYelpCallout('/autocomplete?text='+word);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> autocomp = new List<string>();
        List<Object> categories = (List<Object>) results.get('categories');
        for (integer i=0; i<categories.size();i++){
            Map<String, Object> category = (Map<String, Object>) categories[i];
            autocomp.add(category.get('title'));
        }
        List<Object> terms = (List<Object>) results.get('terms');
        for (integer i=0; i<terms.size();i++){
            Map<String, Object> term = (Map<String, Object>) terms[i];
            autocomp.add(term.get('text'));
        }
        List<Object> businesses = (List<Object>) results.get('businesses');
        for (integer i=0; i<businesses.size();i++){
            Map<String, Object> Name = (Map<String, Object>) businesses[i];
            if (name.get('text')!=null){
                autocomp.add(name.get('text'));
            }
            else autocomp.add(name.get('name'));
        }
        return autocomp;
    }  
    
}