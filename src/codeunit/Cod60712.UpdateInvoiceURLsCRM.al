codeunit 60717 "Update Invoice URLs CRM"
{
    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        UpdateInvoiceURLs();
    end;

    local procedure UpdateInvoiceURLs()
    var
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CustomerL: Record CUstomer;
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        CRMInvoice: Record "CRM Invoice";
        CRMInvoice2: Record "CRM Invoice";
        ZeroGuid: Guid;
        dummybreakpoint: text;
        CompanyNameL: Text;
    begin
        CompanyNameL := CompanyName();
        CRMInvoice.SetFilter(InvoiceNumber, '<>%1', '');
        CRMInvoice.Setfilter(StateCode, '%1|%2', CRMInvoice.StateCode::Active, CRMInvoice.StateCode::Canceled);
        CRMInvoice.setfilter(new_urlsaveprocessed, '<>%1', true);
        if CRMInvoice.FindSet() then
            repeat
                if SalesInvoiceHeaderL.get(CRMInvoice.InvoiceNumber) then begin
                    if CRMInvoice2.Get(CRMInvoice.InvoiceId) then begin
                        CRMInvoice2.new_bcrechnungslink := GetUrl(ClientType::Web, CompanyNameL, Objecttype::page, page::"Posted Sales Invoice", SalesInvoiceHeaderL);
                        CRMInvoice2.new_buchungsdatum := SalesInvoiceHeaderL."Posting Date";
                        CRMInvoice2.new_urlsaveprocessed := true;
                        if CRMInvoice2.modify() then;
                    end;
                end else begin
                    if CRMInvoice2.Get(CRMInvoice.InvoiceId) then begin
                        CRMInvoice2.new_urlsaveprocessed := true;
                        if CRMInvoice2.modify() then;
                    end;
                end;
            until CRMInvoice.Next() = 0
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

