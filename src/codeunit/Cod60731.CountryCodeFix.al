codeunit 60731 "Country Code Fix"
{
    trigger OnRun()
    var
        CRMAccountL: Record "CRM Account";
        Customer: Record Customer;
        CRMIntegrationRecordL: Record "CRM Integration Record";
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");

        Customer.SetRange("Coupled to Dataverse", true);
        if Customer.FindSet() then
            repeat
                CRMIntegrationRecordL.SetRange("Integration ID", Customer.SystemId);
                if CRMIntegrationRecordL.FindSet() then begin
                    CRMAccountL.Get(CRMIntegrationRecordL."CRM ID");
                    if Customer."Country/Region Code" <> CRMAccountL.Address1_Country then begin
                        Customer.validate("Country/Region Code", CRMAccountL.Address1_Country);
                        Customer.modify();
                    end;
                end;
            until Customer.next() = 0;
    end;
}