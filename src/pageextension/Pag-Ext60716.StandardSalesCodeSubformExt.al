pageextension 60716 "StandardSalesCodeSubform Ext" extends "Standard Sales Code Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            field("Line Discount %"; "Line Discount %")
            {
                ApplicationArea = All;
            }
            field("Type of Business"; Rec."Type of Business")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
