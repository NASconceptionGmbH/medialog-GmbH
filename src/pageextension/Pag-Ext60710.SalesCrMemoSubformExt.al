pageextension 60710 "Sales Cr. Memo Subform Ext" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Description)
        {
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