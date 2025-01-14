pageextension 60724 "Sales Quote" extends "Sales Quote"
{
    layout
    {
        addbefore("Salesperson Code")
        {
            field(Clerk; Rec.Clerk)
            {
                ApplicationArea = All;
            }

        }
        addafter(ShippingOptions)
        {
            field("Ship-To Customer No."; Rec."Ship-To Customer No.")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    ShipToOptions := ShipToOptions::"Custom Address";
                end;
            }
        }
        addafter("Ship-to Name")
        {
            field("Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
            }
        }
        modify(SellToEmail)
        {
            Editable = true;
        }

    }
}