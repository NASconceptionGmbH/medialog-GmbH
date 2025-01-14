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

                "SiteID 1" := 'vulkanverlag.sharepoint.com,a8dd98dd-c337-4caa-901d-36466d949ea5,751fc366-0580-415e-8d34-7ee7190589c0';
                Modify()
            end;
        }
        dataitem(CRMCustomSyncSetup; CRMCustomSyncSetup)
        {
            trigger OnAfterGetRecord()
            begin
                if EnvironmentInformation.IsProduction() then
                    CurrReport.Skip();

                "CRM URL" := 'https://vulkanverlagtest.crm4.dynamics.com/';
                "API URL" := 'https://vulkanverlagtest.api.crm4.dynamics.com/api/data/v9.2/';
                "Sharepoint Doc Location GUID" := '50d666d3-6ce5-eb11-bacb-000d3ab7e4ce';
                DriveID := 'b!3ZjdqDfDqkyQHTZGbZSepWbDH3WABV5BjTR-5xkFicCPtZoUV65cS7m14tZdfwDo';
                modify();

            end;
        }
    }

    var
        EnvironmentInformation: Codeunit "Environment Information";
}