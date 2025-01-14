pageextension 60720 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("Purchaser Code")
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
            }
            field("Commission Salesperson"; Rec."Commission Salesperson")
            {
                ApplicationArea = All;
            }
            field("Commission Salesperson 2"; Rec."Commission Salesperson 2")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}