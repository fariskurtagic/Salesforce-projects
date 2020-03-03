({
    handleClick: function(component, event, helper) {
        var input = component.find('businessSearch').get('v.value');
        var action = component.get("c.getBusinesses");
        action.setParams({ "business" : input });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var yelpResponse = JSON.stringify(response.getReturnValue());
                var businesses = JSON.parse(yelpResponse);
                var mapMarkers = [];
                for(var i=0; i<businesses.length; i ++){
                    var marker = {
                        'location': {
                            Latitude: businesses[i].coordinates.latitude,
                            Longitude: businesses[i].coordinates.longitude
                        },
                        'icon': 'custom:custom65',
                        'title': businesses[i].name,
                        'description' : (JSON.parse(JSON.stringify(businesses[i].categories)))[0].title,
                    };
                    mapMarkers.push( marker );
                }
                component.set( 'v.mapMarkers', mapMarkers );
            }
            else {
                alert("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    onSuccess: function(component,event,helper){
        //Show Success message on upsertion of record
        var resultToast = $A.get("e.force:showToast");
        resultToast.setParams({
            "title": "Success!",
            "message": "Record Saved Successfully"
        });
        resultToast.fire();
        
        $A.get("e.force:closeQuickAction").fire();
    },
    
    init: function (cmp, event, helper) {
        cmp.set('v.mapMarkers', [
            {
                location: {
                    City: '',
                    Country: ''
                },
                
                icon: 'custom:custom65',
                title: 'Search'
            },
        ]);
    },
})