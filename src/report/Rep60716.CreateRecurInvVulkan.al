report 60716 "Create Recur. Inv. Vulkan"
{
    AdditionalSearchTerms = 'repeat sales';
    ApplicationArea = Basic, Suite;
    Caption = 'Wiederkehrende Verkaufsrechnung Vulkan';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Standard Customer Sales Code"; "Standard Customer Sales Code")
        {
            RequestFilterFields = "Customer No.", "Code", "Magazine Type";
            DataItemTableView = sorting("Customer No.", Code) order(ascending);

            trigger OnAfterGetRecord()
            begin

                Window.Update(1, 10000 * Counter div TotalCount);
                if PreviousCustNo <> "Standard Customer Sales Code"."Customer No." then begin
                    Counter += 1;
                    IsInvoiceExist(PostingDate, "Standard Customer Sales Code"); // CR-920
                    CreateSalesInvoice2(OrderDate, PostingDate, "Standard Customer Sales Code");
                    PreviousCustNo := "Standard Customer Sales Code"."Customer No.";
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Valid From Date", '%1|<=%2', 0D, OrderDate);
                SetFilter("Valid To date", '%1|>=%2', 0D, OrderDate);
                SetRange(Blocked, false);

                TotalCount := Count;
                Window.Open(ProgressMsg);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(OrderDate; OrderDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Auftragsdatum';
                    ToolTip = 'Specifies the date that will be entered in the Document Date field on the sales invoices that are created by using the batch job.';
                }
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Buchungsdatum';
                    ToolTip = 'Specifies the date that will be entered in the Posting Date field on the sales invoices that are created by using the batch job.';
                }
                field(CommentLine; CommentLine)
                {
                    ApplicationArea = All;
                    Caption = 'Bemerkungszeile';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Window.Close;
        Message(NoOfInvoicesMsg, Counter);
    end;

    trigger OnPreReport()
    begin
        if (OrderDate = 0D) or (PostingDate = 0D) then
            Error(MissingDatesErr);
    end;

    procedure CreateSalesInvoice2(OrderDate: Date; PostingDate: Date; StandardCustomerSalesCodeV: Record "Standard Customer Sales Code")
    var
        SalesHeader: Record "Sales Header";
        SalesLineL, SalesLine2L : Record "Sales Line";
        StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
    begin
        StandardCustomerSalesCodeV.TestField(Blocked, false);
        SalesHeader.Init();
        SalesHeader."No." := '';
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", StandardCustomerSalesCodeV."Customer No.");
        SalesHeader.Validate("Order Date", OrderDate);
        SalesHeader.Validate("Posting Date", PostingDate);
        SalesHeader.Validate("Document Date", OrderDate);
        SalesHeader.Validate("Salesperson Code", StandardCustomerSalesCodeV."Salesperson Code");
        SalesHeader.Validate("Commission Salesperson", StandardCustomerSalesCodeV.Commission);
        SalesHeader.Validate("Salesperson Code 2", StandardCustomerSalesCodeV."Salesperson Code 2");
        SalesHeader.Validate("Commission Salesperson 2", StandardCustomerSalesCodeV."Commission 2");
        SalesHeader.Validate("Shortcut Dimension 1 Code", StandardCustomerSalesCodeV."Global Dimension 1 Code"); // CR-920
        SalesHeader."Automated Sales Order" := true;
        if StandardCustomerSalesCodeV."Payment Method Code" <> '' then
            SalesHeader.Validate("Payment Method Code", StandardCustomerSalesCodeV."Payment Method Code");
        if StandardCustomerSalesCodeV."Payment Terms Code" <> '' then
            SalesHeader.Validate("Payment Terms Code", StandardCustomerSalesCodeV."Payment Terms Code");
        if StandardCustomerSalesCodeV."Direct Debit Mandate ID" <> '' then
            SalesHeader.Validate("Direct Debit Mandate ID", StandardCustomerSalesCodeV."Direct Debit Mandate ID");
        SalesHeader.Modify();

        clear(StandardCustomerSalesCodeL);
        StandardCustomerSalesCodeL := "Standard Customer Sales Code";
        StandardCustomerSalesCodeL.CopyFilters("Standard Customer Sales Code");
        StandardCustomerSalesCodeL.SetRange("Customer No.", "Standard Customer Sales Code"."Customer No.");
        if StandardCustomerSalesCodeL.FindSet() then
            repeat
                StandardCustomerSalesCodeV.ApplyStdCodesToSalesLines(SalesHeader, StandardCustomerSalesCodeL);
            until StandardCustomerSalesCodeL.next() = 0;
        SalesLineL.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineL.SetRange("Document No.", SalesHeader."No.");
        IF CommentLine <> '' then
            IF SalesLineL.FindLast() then begin
                SalesLine2L.Init();
                SalesLine2L."Document Type" := SalesHeader."Document Type";
                SalesLine2L."Document No." := SalesHeader."No.";
                SalesLine2L."Line No." := SalesLineL."Line No." + 10000;
                SalesLine2L.Type := SalesLine2L.Type::" ";
                SalesLine2L.Description := CommentLine;
                SalesLine2L.Insert();
            end
    end;
    // CR-920
    local procedure IsInvoiceExist(PostingDate: Date; StandardCustomerSalesCodeV: Record "Standard Customer Sales Code")
    var
        SalesHeader: Record "Sales Header";
        ErrorTxt: Label 'Sales invoice already exist for customer %1 for posting date %2';
    begin
        SalesHeader.SetRange("Sell-to Customer No.", StandardCustomerSalesCodeV."Customer No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("Posting Date", PostingDate);
        if SalesHeader.FindFirst() then
            Error(ErrorTxt, SalesHeader."Sell-to Customer Name", SalesHeader."Posting Date");
    end;

    var
        Window: Dialog;
        PostingDate: Date;
        OrderDate: Date;
        MissingDatesErr: Label 'Es muss sowohl ein Auftragsdatum als auch ein Buchungsdatum eingegeben werden.';
        TotalCount: Integer;
        Counter: Integer;
        ProgressMsg: Label 'Rechnungenerstellen #1##################';
        NoOfInvoicesMsg: Label '%1 Rechnungen wurden erstellt.';
        CommentLine: Text;
        PreviousCustNo: Code[20];
}

