pageextension 60706 "CustomerCardExt" extends "Customer Card"
{
    layout
    {

    }

    actions
    {
        addafter(Dimensions)
        {
            action(CustomerTypes)
            {
                ApplicationArea = All;
                Caption = 'Kundenarten';
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                image = CustomerList;
                RunObject = page "Customer Type List";
                RunPageLink = "Customer No." = field("No.");
            }
            action(Sparten)
            {
                ApplicationArea = All;
                Caption = 'Sparten';
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                image = CustomerList;
                RunObject = page "Customer Sparten List";
                RunPageLink = "Customer No." = field("No.");
            }
            action(Merkmale)
            {
                ApplicationArea = All;
                Caption = 'Merkmale';
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                image = CustomerList;
                RunObject = page "Customer Characteristics List";
                RunPageLink = "Customer No." = field("No.");
            }
        }

    }
}