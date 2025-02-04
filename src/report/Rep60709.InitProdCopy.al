report 60709 "InitProdCopy"
{
    Caption = 'Init Prod Copy';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(JobQueueEntries; "Job Queue Entry")
        {
            trigger OnAfterGetRecord()
            var
                EnvironmentInformationL: Codeunit "Environment Information";
            begin
                if EnvironmentInformation.IsProduction() then
                    CurrReport.Skip();

                Delete();
            end;
        }
        dataitem("SharePoint Setup"; "SharePoint Setup")
        {
            trigger OnAfterGetRecord()
            begin
                if EnvironmentInformation.IsProduction() then
                    CurrReport.Skip();

                "SiteID 1" := 'e9635501-382a-41f0-b2a8-5f8de586b8df';
                Modify()
            end;
        }
        dataitem(CRMCustomSyncSetup; CRMCustomSyncSetup)
        {
            trigger OnAfterGetRecord()
            begin
                if EnvironmentInformation.IsProduction() then
                    CurrReport.Skip();

                // "CRM URL" := 'https://vulkanverlagtest.crm4.dynamics.com/';
                // "API URL" := 'https://vulkanverlagtest.api.crm4.dynamics.com/api/data/v9.2/';
                // "Sharepoint Doc Location GUID" := '50d666d3-6ce5-eb11-bacb-000d3ab7e4ce';
                // DriveID := 'b!3ZjdqDfDqkyQHTZGbZSepWbDH3WABV5BjTR-5xkFicCPtZoUV65cS7m14tZdfwDo';
                // modify();

            end;
        }
    }

    var
        EnvironmentInformation: Codeunit "Environment Information";
}