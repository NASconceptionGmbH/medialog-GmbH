page 60708 "Item Issue Subform Salesperson"
{

    Caption = 'Anzeigen';
    PageType = ListPart;
    SourceTable = "Issue Ad";
    DelayedInsert = true;
    AutoSplitKey = true;
    InsertAllowed = false;
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission %"; Rec."Commission %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Customer No."; Rec."Ship-to Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Motive; Rec.Motive)
                {
                    ToolTip = 'Specifies the value of the Motive field';
                    ApplicationArea = All;
                }
                field(Placement; Rec.Placement)
                {
                    ToolTip = 'Specifies the value of the Placement field';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Print Documents"; Rec."Print Documents")
                {
                    ToolTip = 'Specifies the value of the Print Documents field';
                    ApplicationArea = All;
                }
                field("Print Documents Enddate"; Rec."Print Documents Enddate")
                {
                    ToolTip = 'Specifies the value of the Print Documents Enddate field';
                    ApplicationArea = All;
                }
                field("Reminder Count"; Rec."Reminder Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Reminder"; Rec."Last Reminder")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ToolTip = 'Specifies the value of the Confirmation Date field';
                    ApplicationArea = All;

                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ToolTip = 'Specifies the value of the Sales Person Code field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Excel)
            {
                ApplicationArea = All;
                Image = Excel;
                trigger OnAction()
                var
                    ItemIssueAdL: Page "Item Issue Ad";
                begin
                    ItemIssueAdL.SetTableView(Rec);
                    ItemIssueAdL.RunModal();
                end;
            }
            action(SalesInvoiceList)
            {
                ApplicationArea = All;
                Image = Invoice;
                Caption = 'Geb. Verkaufsrechnungen';
                trigger
                OnAction()
                var
                    FilterText: Text;
                    IssueAdL: Record "Issue Ad";
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                    SalesInvoiceListL: Page "Posted Sales Invoices";

                begin
                    IssueAdL.SetRange("Item No.", Rec."Item No.");
                    IF IssueAdL.FindSet() then
                        repeat
                            If IssueAdL."Invoice No." <> '' then
                                FilterText += IssueAdL."Invoice No." + '|';
                        until IssueAdL.Next() = 0;
                    FilterText := CopyStr(FilterText, 1, STRLEN(FilterText) - 1);
                    SalesInvoiceHeaderL.SetFilter("No.", FilterText);
                    SalesInvoiceListL.SetTableView(SalesInvoiceHeaderL);
                    SalesInvoiceListL.RunModal();
                end;
            }
        }
    }
    procedure GetLines(SalesPerson: Code[20])
    var
        IssueAdL: Record "Issue Ad";
    begin
        Rec.DeleteAll();
        IssueAdL.SetRange("Sales Person Code", SalesPerson);
        IF IssueAdL.FindSet() then
            repeat
                Rec.Init();
                Rec.TransferFields(IssueAdL);
                Rec."Sales Order No." := IssueAdL."Sales Order No.";
                Rec."Sales Line No." := IssueAdL."Sales Line No.";
                IF Rec.Insert() then
                    ;
            Until IssueAdL.Next() = 0;
        IssueAdL.Reset();
        IssueAdL.SetRange("Salesperson 2", SalesPerson);
        If IssueAdL.FindSet() then
            repeat
                Rec.TransferFields(IssueAdL);
                Rec."Sales Order No." := IssueAdL."Sales Order No.";
                Rec."Sales Line No." := IssueAdL."Sales Line No.";
                Rec."Commission Amount" := IssueAdL."Commission Amount 2";
                Rec."Commission %" := IssueAdL."Commission 2 %";
                IF Rec.Insert() then
                    ;
            Until IssueAdL.Next() = 0;
        CurrPage.Update(false);
    end;
}
