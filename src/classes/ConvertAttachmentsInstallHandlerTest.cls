/**
 * Developed by Doug Ayers (douglascayers.com)
 */
@isTest
private class ConvertAttachmentsInstallHandlerTest {

    @isTest
    static void test_new_install() {

        Test.startTest();

        Test.testInstall( new ConvertAttachmentsInstallHandler(), null );

        Test.stopTest();

        Convert_Attachments_to_Files_Settings__c settings = Convert_Attachments_to_Files_Settings__c.getOrgDefaults();

        System.assert( String.isNotBlank( settings.id ), 'id should not be blank' );
        System.assertEquals( false, settings.Convert_in_Near_Real_Time__c );
        System.assertEquals( false, settings.Delete_Attachment_Once_Converted__c );

    }

    @isTest
    static void test_upgrade() {

        Convert_Attachments_to_Files_Settings__c preSettings = Convert_Attachments_to_Files_Settings__c.getOrgDefaults();
        preSettings.Convert_in_Near_Real_Time__c = true;
        preSettings.Delete_Attachment_Once_Converted__c = true;

        upsert preSettings;

        Test.startTest();

        Test.testInstall( new ConvertAttachmentsInstallHandler(), new Version( 1, 0 ) );

        Test.stopTest();

        Convert_Attachments_to_Files_Settings__c postSettings = Convert_Attachments_to_Files_Settings__c.getOrgDefaults();

        System.assertEquals( preSettings.id, postSettings.id );
        System.assertEquals( preSettings.Convert_in_Near_Real_Time__c, postSettings.Convert_in_Near_Real_Time__c );
        System.assertEquals( preSettings.Delete_Attachment_Once_Converted__c, postSettings.Delete_Attachment_Once_Converted__c );

    }

}