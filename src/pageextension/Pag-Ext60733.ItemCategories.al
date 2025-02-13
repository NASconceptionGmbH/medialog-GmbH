pageextension 60733 "Item Categories" extends "Item Categories"
{
    layout
    {
        addlast(Control1)
        {
            field("Allow Startdate"; Rec."Allow Startdate")
            {
                ApplicationArea = All;
            }
        }
    }
}