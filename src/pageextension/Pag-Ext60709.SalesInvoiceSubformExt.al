pageextension 60709 "Sales Invoice Subform Ext" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Type of Business"; Rec."Type of Business")
            {
                ApplicationArea = All;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    var
        myInt: Integer;
}