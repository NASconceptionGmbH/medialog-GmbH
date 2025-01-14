pageextension 60723 "PostedSalesShipment" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
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