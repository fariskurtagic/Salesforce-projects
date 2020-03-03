@isTest
private class YelpCalloutTest {
    private static void setup(String txtfile){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(txtfile);
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
    }
	@isTest static void searchTest(){
        
        setup('YelpCalloutSearchMock');
        
        //TEST BUSINESS SEARCHES
        List<Object> Bsearch = YelpCallout.getbusinessSearch('San Francisco');
        List<Object> Psearch = YelpCallout.getPhoneSearch('+14152520800');
        List<Object> Tsearch = YelpCallout.getTransactionSearch('San Francisco');
        
        System.assertEquals(1, Bsearch.size());
        System.assertEquals(1, Psearch.size());
        System.assertEquals(1, Tsearch.size());
    }
    
    @isTest static void detailsTest(){
        
        setup('YelpCalloutDetailsMock');
        
        //TEST BUSINESS DETAILS
        object name = YelpCallout.getBusinessDetails('E8RJkjfdcwgtyoPMjQ_Olg');    
        System.assertEquals('Gary Danko', name);
    }
    
    @isTest static void reviewsTest(){
        
        setup('YelpCalloutReviewsMock');
        
        //TEST BUSINESS REVIEWS
        List<Object> reviews = YelpCallout.getBusinessReviews('xAG4O7l-t1ubbwVAlPnDKg');
        System.assertEquals(3, reviews.size());
    }
    
    @isTest static void autocompleteTest(){
        
        setup('YelpCalloutAutocompleteMock');
        
        //TEST AUTOCOMPLETE
        List<Object> autocomp = YelpCallout.getAutocomplete('del');
        System.assertEquals(7, autocomp.size());
    }
    
}