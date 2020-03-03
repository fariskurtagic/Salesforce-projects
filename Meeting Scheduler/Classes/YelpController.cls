public with sharing class YelpController {
	@AuraEnabled
    public static List<Object> getBusinesses(string business) {
        List<Object> Bsearch = YelpCallout.getbusinessSearch(business);
        return Bsearch;
    }
}