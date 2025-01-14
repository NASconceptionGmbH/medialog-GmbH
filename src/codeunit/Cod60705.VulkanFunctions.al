codeunit 60705 "Vulkan Functions"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        IssueSetupL: Record "Issue Setup";
        IssueAdL: Record "Issue Ad";
        IssueAd2L: Record "Issue Ad";
        CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
        CustomerTypeL: Record "Customer Type";
        CustomerSpartentoCRML: Record "Customer Sparten CRM";
        CustomerCharacteristicsCRML: Record "Customer Characteristics CRM";
        ContactCharacteristicsCRML: Record "Contact Characteristics CRM";
        DateL: Date;
        ExcelIssueFunctionsL: Codeunit ExcelIssueFunctions;

    begin
        case Rec."Parameter String" of
            'MAILREMINDER':
                begin
                    IssueSetupL.Get();
                    IssueAdL.SetFilter("Print Documents Enddate", '>=%1', Today);
                    IssueAdL.SetRange("Invoice No.", '');
                    IssueAdL.SetRange("Print Documents", false);
                    IssueAdL.SetFilter(Email, '<>%1', '');
                    IF IssueAdL.FindSet() then
                        repeat
                            If IssueAdL."Last Reminder" = 0D then
                                DateL := CalcDate(IssueSetupL."Mail Reminder Dateformula", IssueAdL."Print Documents Enddate")
                            else
                                DateL := CalcDate(IssueSetupL."Mail Reminder Interval", IssueAdL."Last Reminder");
                            IF Today >= DateL then begin
                                IssueAd2L.SetRange("Sales Line No.", IssueAdL."Sales Line No.");
                                IssueAd2L.SetRange("Sales Order No.", IssueAdL."Sales Order No.");
                                IssueAd2L.FindFirst();
                                SendPrintDocumentReminder(IssueAd2L, 1);
                            end;
                        until IssueAdL.Next() = 0;
                end;
            'KUNDENARTEN':
                CustomCRMSynchronizationL.SynchronizeCustomerTypeRelation(CustomerTypeL, false);

            'SPARTEN':
                begin
                    CustomCRMSynchronizationL.SynchronizeSparteItemRelation('', false);
                    CustomCRMSynchronizationL.SynchronizeSparteToCustomerRelation(CustomerSpartentoCRML, false);
                end;
            'MERKMALE':
                begin
                    CustomCRMSynchronizationL.SynchronizeCharacteristicsItemRelation('', false);
                    CustomCRMSynchronizationL.SynchronizeCharacteristicsToCustomerRelation(CustomerCharacteristicsCRML, false);
                    CustomCRMSynchronizationL.SynchronizeCharacteristicsToContactRelation(ContactCharacteristicsCRML, false);
                end;
            'UPDATECRMIDS':
                CustomCRMSynchronizationL.UpdateGUIDSFromCRMIntegration();
            'UPDATEISSUES':
                if NOT Codeunit.Run(codeunit::ExcelIssueFunctions) then
                    ;
            'UPDATEALLCRMATTRIBUTES':
                UpdateAllCRMAttributes();
            'UPDATECRMINVOICEURLS':
                if codeunit.run(codeunit::"Update Invoice URLs CRM") then;
        end;
    end;

    procedure SendPrintDocumentReminder(Var IssueAdR: Record "Issue Ad"; Mode: Integer): Boolean
    var
        myInt: Integer;
        RecRefL: RecordRef;
        OutStrL: OutStream;
        CustomerL: Record Customer;
        Text0001: Label 'Ihr Auftrag %1 - Fehlende Druckunterlagen %2';
        Text0002: Label 'Your Order %1 - required ad material %2';
        EmailHeaderL: Text;
        ItemL: Record Item;
        EmailL: Codeunit Email;
        EmailMessageL: Codeunit "Email Message";
        TempBlobL: Codeunit "Temp Blob";
        InstrL: InStream;
        BodyText: Text;
        IssueAdMailRecord: Record "Issue Ad";
        EmailAccountL: Codeunit "Email Account";
    begin
        CustomerL.Get(IssueAdR."Sell-to Customer No.");
        ItemL.Get(IssueAdR."Item No.");
        IssueAdMailRecord.SetRange("Sales Order No.", IssueAdR."Sales Order No.");
        IssueAdMailRecord.SetRange("Sales Line No.", IssueAdR."Sales Line No.");
        IssueAdMailRecord.FindFirst();
        If IssueAdMailRecord.Email = '' then
            exit(false);

        if not EmailAccountL.ValidateEmailAddress(IssueAdMailRecord.Email) then
            exit(false);

        RecRefL.GetTable(IssueAdMailRecord);

        TempBlobL.CreateOutStream(OutStrL, TextEncoding::UTF8);
        Report.SaveAs(Report::"Print Documents Reminder", '', ReportFormat::Html, OutStrL, RecRefL);
        TempBlobL.CreateInStream(InstrL, TextEncoding::UTF8);
        InstrL.ReadText(BodyText);


        if CustomerL."Language Code" = 'ENU' then
            EmailHeaderL := Text0002
        else
            EmailHeaderL := Text0001;
        EmailMessageL.Create(IssueAdR.Email, StrSubstNo(EmailHeaderL, IssueAdR."Sales Order No.", ItemL."Magazine Type"), BodyText, true);
        case Mode of
            0:
                EmailL.OpenInEditorModally(EmailMessageL, Enum::"Email Scenario"::"Print Reminder");
            1:
                EmailL.Enqueue(EmailMessageL, Enum::"Email Scenario"::"Print Reminder");
        End;
        IssueAdR."Reminder Count" += 1;
        IssueAdR."Last Reminder" := Today;
        IssueAdR.Modify();
        Exit(true);
    end;

    procedure GetEarliestPublicationdDate(SalesHeaderR: Record "Sales Header"; ModifiedDate: Date; SourceNo: Code[20])
    var
        SalesLineL: Record "Sales Line";
        NewPostingDate: Date;
        ItemL: Record Item;
    begin
        NewPostingDate := ModifiedDate;
        SalesLineL.SetRange("Document Type", SalesHeaderR."Document Type");
        SalesLineL.SetRange("Document No.", SalesHeaderR."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetFilter("No.", '<>%1', SourceNo);
        IF SalesLineL.FindSet() then
            repeat
                IF SalesLineL."Outstanding Quantity" <> 0 then begin
                    ItemL.Get(SalesLineL."No.");
                    IF NewPostingDate = 0D then
                        NewPostingDate := ItemL."Publication Date"
                    else
                        IF NewPostingDate > ItemL."Publication Date" then
                            NewPostingDate := ItemL."Publication Date";
                end
            until SalesLineL.Next() = 0;
        If NewPostingDate <> 0D then begin
            SalesHeaderR.Validate("Posting Date", NewPostingDate);
            SalesHeaderR."Document Date" := NewPostingDate;
            SalesHeaderR.Modify(False);
        end;
    end;

    procedure UpdateAllCRMAttributes()
    var
        CustomerTypeL: Record "Customer Type";
        CustomerType2L: Record "Customer Type";
        ItemAttributeValueMappingl: Record "Item Attribute Value Mapping";
        ItemAttributeValueMapping2L: Record "Item Attribute Value Mapping";
    begin
        if CustomerTypeL.FindSet() then
            repeat
                if Codeunit.Run(codeunit::UpdateAllCustTypeCRM, CustomerTypeL) then begin
                    CustomerType2L.Get(CustomerTypeL."Customer No.", CustomerTypeL."Type of Business Code");
                    CustomerType2L.Synced := true;
                    CustomerType2L.modify();
                    Commit();
                end;
            until CustomerTypeL.next() = 0;

        ItemAttributeValueMappingl.SetRange("Table ID", 27);
        ItemAttributeValueMappingl.SetFilter("Item Attribute ID", '19');
        if ItemAttributeValueMappingl.FindSet() then
            repeat
                if codeunit.run(codeunit::UpdateAllSpartenCRM, ItemAttributeValueMappingl) then begin
                    ItemAttributeValueMapping2L.Get(ItemAttributeValueMappingl."Table ID", ItemAttributeValueMappingl."No.", ItemAttributeValueMappingl."Item Attribute ID");
                    ItemAttributeValueMapping2L.Synced := true;
                    ItemAttributeValueMapping2L.Modify();
                    Commit();
                end;
            until ItemAttributeValueMappingl.Next() = 0;

        CLEAR(ItemAttributeValueMappingl);
        clear(ItemAttributeValueMapping2L);
        ItemAttributeValueMappingl.SetRange("Table ID", 27);
        ItemAttributeValueMappingl.SetFilter("Item Attribute ID", '21|26|27|28');
        if ItemAttributeValueMappingl.FindSet() then
            repeat
                if codeunit.run(codeunit::UpdateAllCharacteristicsCRM, ItemAttributeValueMappingl) then begin
                    ItemAttributeValueMapping2L.Get(ItemAttributeValueMappingl."Table ID", ItemAttributeValueMappingl."No.", ItemAttributeValueMappingl."Item Attribute ID");
                    ItemAttributeValueMapping2L.Synced := true;
                    ItemAttributeValueMapping2L.Modify();
                    Commit();
                end;
            until ItemAttributeValueMappingl.Next() = 0
    end;
}