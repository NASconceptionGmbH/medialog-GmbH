pageextension 60702 "Item Variant Ext." extends "Item Variants"
{
    layout
    {
        addafter(Description)
        {
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            field("Gen. Product Posting Group"; Rec."Gen. Product Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
    }

    actions
    {

        // Add changes to page actions here
    }

    var
        myInt: Integer;
}