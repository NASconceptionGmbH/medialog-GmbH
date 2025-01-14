codeunit 60724 "Clear BC Customer No. Sales"
{
    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        ClearBCCustNoSales();
    end;

    local procedure ClearBCCustNoSales()
    var
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CustomerL: Record CUstomer;
        CRMAccountL: Record "CRM Account";
        CRMAccount2L: Record "CRM Account";
        ZeroGuid: Guid;
    begin
        CRMIntegrationRecordL.SetRange("Table ID", 18);
        if CRMIntegrationRecordL.FindSet() then
            repeat
                if CRMAccountL.get(CRMIntegrationRecordL."CRM ID") then
                    if CustomerL.GetBySystemId(CRMIntegrationRecordL."Integration ID") then
                        if CustomerL."No." <> CRMAccountL.new_bccustomerno then begin
                            CRMAccountL.new_bccustomerno := '';
                            CRMAccountL.modify();
                        end;
            until CRMIntegrationRecordL.next() = 0;
    end;
}