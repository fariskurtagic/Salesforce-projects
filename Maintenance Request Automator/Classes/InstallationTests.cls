// This class can be safely deleted from your org. 
// It was only used to ensure 100% test coverage 
// for the managed package installation 

@IsTest
public class InstallationTests {
    @IsTest
    public static void testMaintenanceRequest(){
        
        List<Case> testCases = new List<Case>();
        for(Integer i=0; i<150; i++){
            testCases.add(new Case(status='New', type='Repair', origin = 'Phone',
                                   subject='Closed, Repair'));
        }
        for(Integer i=0; i<150; i++){
            testCases.add(new Case(status='New', type='Routine Maintenance', origin = 'Phone',
                                   subject='Closed, Routine Maintenance'));
        }
        
        insert testCases;
        
        for(Case c: testCases){
            c.status = 'Closed';
        }
        
        update testCases;
        
        List<Case> newCases = [Select status from Case where status='New'];
        List<Case> closedCases = [Select status from Case where status='Closed'];
        
        System.assertEquals(300, newCases.size());
        System.assertEquals(300, closedCases.size());
        
    }
}