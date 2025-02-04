codeunit 60742 PostCodeCityFix
{
    Permissions = tabledata "Sales Invoice Header" = rimd;

    trigger OnRun()
    var
        CustomerL: Record Customer;
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CRMAccountL: Record "CRM Account";

        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");

        CustomerL.SetRange("Coupled to Dataverse", true);
        CustomerL.SetFilter("Country/Region Code", '<>DE');
        CustomerL.SetRange(City, '');
        if CustomerL.FindSet(true) then
            repeat
                CRMIntegrationRecordL.SetRange("Table ID", Database::Customer);
                CRMIntegrationRecordL.SetRange("Integration ID", CustomerL.SystemId);
                if CRMIntegrationRecordL.findfirst() then begin
                    CRMAccountL.GetBySystemId(CRMIntegrationRecordL."CRM ID");
                    CustomerL.City := CRMAccountL.Address1_City;
                    CustomerL."Post Code" := CRMAccountL.Address1_PostalCode;
                    CustomerL.modify();
                end;
            until CustomerL.Next() = 0;


        clear(CustomerL);
        SalesInvoiceHeaderL.SetRange("Sell-to City", '');
        if SalesInvoiceHeaderL.FindSet(true) then
            repeat
                CustomerL.get(SalesInvoiceHeaderL."Sell-to Customer No.");
                SalesInvoiceHeaderL."Sell-to City" := CUstomerL.City;
                SalesInvoiceHeaderL."Sell-to Post Code" := CustomerL."Post Code";
                SalesInvoiceHeaderL.modify();
            until SalesInvoiceHeaderL.next() = 0;
    end;
}