codeunit 60712 "Fill Empty BC No in CRM"
{
    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        UpdateCRMBCNos();
    end;

    local procedure UpdateCRMBCNos()
    var
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CustomerL: Record CUstomer;
        CRMAccountL: Record "CRM Account";
        CRMAccount2L: Record "CRM Account";
        ZeroGuid: Guid;
    begin
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
// report 60718 "UpdateEmptyBCNos"
// {
//     Caption = 'Fill Empty BC No in CRM';
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Crm account"; "CRM Account")
//         {
//             trigger OnPreDataItem()
//             begin
//                 "Crm account".SetFilter(new_bccustomerno, '=%1', '');
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 CRMIntegrationRecordL: Record "CRM Integration Record";
//                 CustomerL: Record CUstomer;
//                 CRMAccountL: Record "CRM Account";
//             begin
//                 CRMIntegrationRecordL.SetRange("Table ID", 18);
//                 CRMIntegrationRecordL.SetRange("CRM ID", "Crm account".AccountId);
//                 CRMIntegrationRecordL.SetFilter("Integration ID", '<>%1', '');
//                 if CRMIntegrationRecordL.FindFirst() then begin
//                     CustomerL.SetRange(SystemId, CRMIntegrationRecordL."Integration ID");
//                     if CustomerL.FindFirst() then begin
//                         CRMAccountL.get("Crm account".AccountId);
//                         CRMAccountL.new_bccustomerno := CustomerL."No.";
//                         CRMAccountL.modify();
//                     end;
//                 end;
//             end;
//         }
//     }
//     // trigger OnInitReport()
//     // begin
//     //     Codeunit.Run(Codeunit::"CRM Integration Management");
//     // end;

//     trigger OnPreReport()
//     begin
//         Codeunit.Run(Codeunit::"CRM Integration Management");
//     end;



// }

