pageextension 60713 "Posted Sales Inv. List" extends "Posted Sales Invoices"
{
    PromotedActionCategories = ',,,,,,,Versandadressen,Versandadressen';
    layout
    {


        addafter("Sell-to Customer Name")

        {
            field("Document Sending Profile"; Rec."Document Sending Profile")
            {
                ApplicationArea = All;
            }
            field("No_Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
            }

        }
        // Add changes to page layout here
    }
    actions
    {
        addafter(Statistics)
        {
            action("Shipping Addresses")
            {
                ApplicationArea = All;
                Image = Addresses;
                Caption = 'Versandadressen';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = page "Shipping Addresses";
                RunPageLink = "Sales Order No." = field("Order No.");
            }
        }
        addafter(Print)
        {
            action("Print Shipping Adresses")
            {
                ApplicationArea = All;
                Image = Print;
                Caption = 'Liefer Adressen drucken';

                trigger OnAction()
                var
                    ShippingAdressesL: Report "Shipping Adresses";
                    SalesInvHeaderL: Record "Sales Invoice Header";
                begin
                    SalesInvHeaderL := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeaderL);
                    ShippingAdressesL.SetTableView(SalesInvHeaderL);
                    ShippingAdressesL.Run();
                end;
            }
        }
    }
}