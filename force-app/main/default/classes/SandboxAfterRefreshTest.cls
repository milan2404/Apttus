@isTest
private class SandboxAfterRefreshTest {
    @isTest
    static void testSandboxAfterRefresh() {
        

        List<Organization> org = ([SELECT Id FROM Organization LIMIT 1]);

        Test.startTest();
        Test.testSandboxPostCopyScript(
            new SandboxAfterRefresh(),
            org[0].Id,
            org[0].Id,
            '002'
        );
        Test.stopTest();
    }
}