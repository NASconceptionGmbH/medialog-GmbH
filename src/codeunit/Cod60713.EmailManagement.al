codeunit 60713 "Email Management"
{
    /*
        [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeGetEmailAddress', '', true, true)]
        local procedure OnBeforeGetEmailAddress(RecordVariant: Variant; CustNo: Code[20]; var EmailAddress: Text[250]; var IsHandled: Boolean)
        var
            RecordRefL: RecordRef;
            FieldRefL: FieldRef;
            SalesInvoiceHeaderL: Record "Sales Invoice Header";
            ContactL: Record Contact;

        begin

            RecordRefL.GetTable(RecordVariant);
            if not RecordRefL.IsEmpty() then begin
                if RecordRefL.Number = 112 then begin
                    FieldRefL := RecordRefL.Field(3);
                    SalesInvoiceHeaderL.Get(FieldRefL.Value);

                    if SalesInvoiceHeaderL."Sell-to Contact" <> '' then begin

                        if ContactL.Get(SalesInvoiceHeaderL."Sell-to Contact No.") then begin
                            if ContactL."E-Mail" <> '' then begin
                                EmailAddress := ContactL."E-Mail";
                                IsHandled := true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', false, false)]
    local procedure AddBcc(var TempEmailItem: Record "Email Item" temporary; var IsFromPostedDoc: Boolean; var PostedDocNo: Code[20]; var HideDialog: Boolean; var ReportUsage: Integer; var EmailSentSuccesfully: Boolean; var IsHandled: Boolean; EmailDocName: Text[250]; SenderUserID: Code[50]; EmailScenario: Enum "Email Scenario")
    var
        myInt: Integer;
    begin
        Clear(BccEmail);
        if IsFromPostedDoc then begin
            BccEmail := GetBccMailAddress(PostedDocNo);
        end;
        if BccEmail <> '' then begin
            TempEmailItem.Validate("Send BCC", BccEmail);
        end;
    end;

    local procedure GetBccMailAddress(DocNo: Code[20]): Text
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        CustNo: Code[20];
        CompanyInformationL: Record "Company Information";
    begin
        if DocNo = '' then
            exit('');
        CompanyInformationL.get();
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", DocNo);
        if not SalesInvoiceHeader.IsEmpty then
            exit(CompanyInformationL."Bcc Mail Address");
        SalesCrMemoHeader.Reset();
        SalesCrMemoHeader.SetRange("No.", DocNo);
        if not SalesCrMemoHeader.IsEmpty then
            exit(CompanyInformationL."Bcc Mail Address");
        exit('');
    end;

    var
        BccEmail: Text[80];
}