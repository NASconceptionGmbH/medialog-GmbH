page 60700 "Item Issue Ad"
{

    Caption = 'Artikel Anzeigen';
    PageType = List;
    SourceTable = "Issue Ad";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Item No."; Rec."Item No.")
                {

                    ToolTip = 'Specifies the value of the Item No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field';
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field';
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field';
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field';
                    ApplicationArea = All;
                }
                field("Ship-to Customer No."; Rec."Ship-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Lieferung an Debitor Nr. field';
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;

                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ToolTip = 'Specifies the value of the Sales Person Code field';
                    ApplicationArea = All;
                }
                field("Commission %"; "Commission %")
                {
                    ApplicationArea = All;
                }
                field("Commission Amount"; "Commission Amount")
                {
                    ApplicationArea = All;
                }
                field(Clerk; Rec.Clerk)
                {
                    ApplicationArea = All;
                }

                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
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
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field';
                    ApplicationArea = All;
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ToolTip = 'Specifies the value of the Confirmation Date field';
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field';
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field';
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field';
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field';
                    ApplicationArea = All;
                }
                field("Credit Memo No."; "Credit Memo No.")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

}
