@isTest
public class CQPartRestCalloutTest {
    @testSetup static void setupData() {
        
        Id profileId = [Select Id From Profile Where Name = 'System Administrator'].Id;
        User user = new User();
        user.ProfileID = profileId;
        user.EmailEncodingKey = 'ISO-8859-1';
        user.LanguageLocaleKey = 'en_US';
        user.TimeZoneSidKey = 'America/New_York';
        user.LocaleSidKey = 'en_US';
        user.FirstName = 'Test';
        user.LastName = 'Admin User';
        user.Username = 'test1@admin1.com';
        user.CommunityNickname = 'testUser123';
        user.Alias = 't1';
        user.Email = 'no@email.com';
        user.IsActive = true;
        insert user;
        
        User user2 = new User();
        user2.ProfileID = profileId;
        user2.EmailEncodingKey = 'ISO-8859-1';
        user2.LanguageLocaleKey = 'en_US';
        user2.TimeZoneSidKey = 'America/New_York';
        user2.LocaleSidKey = 'en_US';
        user2.FirstName = 'Test';
        user2.LastName = 'Integration User';
        user2.Username = 'test1@integrationadmin1.com';
        user2.CommunityNickname = 'testUser124';
        user2.Alias = 't2';
        user2.Email = 'no2@email.com';
        user2.IsActive = true;
        insert user2;
        
        System.runAs(user){
            PermissionSet permset = [SELECT Id FROM PermissionSet WHERE Name = 'Integration_Admin'];
            insert new PermissionSetAssignment(AssigneeId=user2.Id, PermissionSetId=permset.Id);
        
            Account account1 = new Account();
            account1.Name = 'High Volume';
            insert account1;
            Account account2 = new Account();
            account2.Name = 'Low Volume';
            insert account2;
        }
    }
    
    @isTest
    static void testSystemAdminCallout() {
        User us = [select id from user where Name = 'Test Admin User'];
        System.runAs(us){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CQPartHttpCalloutMock(200));
        Boolean response = CQPartRestCallout.cqRestAPICallout();
        Assert.areEqual(true, response);
        Test.stopTest();
        }
    }
    
    @isTest
    static void testIntegrationUserCallout() {
        User us = [select id from user where Name = 'Test Integration User'];
        System.runAs(us){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CQPartHttpCalloutMock(200));
        Boolean response = CQPartRestCallout.cqRestAPICallout();
        Assert.areEqual(true, response);
        Test.stopTest();
        }
    }
    
    @isTest
    static void testSystemAdminNegativeCallout() {
        User us = [select id from user where Name = 'Test Admin User'];
        System.runAs(us){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CQPartHttpCalloutMock(400));
        Boolean response = CQPartRestCallout.cqRestAPICallout();
        Assert.areEqual(false, response);
        Test.stopTest();
        }
    }
    
    @isTest
    static void testIntegrationUserNegativeCallout() {
        User us = [select id from user where Name = 'Test Integration User'];
        System.runAs(us){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CQPartHttpCalloutMock(400));
        Boolean response = CQPartRestCallout.cqRestAPICallout();
        Assert.areEqual(false, response);
        Test.stopTest();
        }
    }
}