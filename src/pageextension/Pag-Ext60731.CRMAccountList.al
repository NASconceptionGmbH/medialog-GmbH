pageextension 60731 "CRM Account List" extends "CRM Account List"
{
    layout
    {

    }

    actions
    {
        addlast(processing)

        {
            action(UpdateBCNo)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    CRMIntegrationRecordL: Record "CRM Integration Record";
                    CustomerL: Record CUstomer;
                    CRMAccountL: Record "CRM Account";
                    CRMAccount2L: Record "CRM Account";
                    ZeroGuid: Guid;
                begin
                    CRMAccountL.SetRange(AccountId, Rec.AccountId);
                    CRMAccountL.SetFilter(new_bccustomerno, '=%1', '');
                    if CRMAccountL.FindSet() then
                        repeat
                            CRMIntegrationRecordL.Reset();
                            CRMIntegrationRecordL.SetRange("Table ID", 18);
                            CRMIntegrationRecordL.SetRange("CRM ID", CRMAccountL.AccountId);
                            CRMIntegrationRecordL.SetFilter("Integration ID", '<>%1', ZeroGuid);
                            if CRMIntegrationRecordL.FindFirst() then begin
                                CustomerL.Reset();
                                CustomerL.SetRange(SystemId, CRMIntegrationRecordL."Integration ID");
                                if CustomerL.FindFirst() then begin
                                    if CRMAccount2L.get(CRMAccountL.AccountId) then begin
                                        CRMAccount2L.new_bccustomerno := CustomerL."No.";
                                        CRMAccount2L.modify();
                                    end;
                                end;
                            end;

                        until CRMAccountL.Next() = 0;
                end;
            }
        }
    }
}