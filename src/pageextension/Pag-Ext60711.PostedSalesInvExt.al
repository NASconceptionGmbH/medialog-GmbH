pageextension 60711 "PostedSalesInvExt" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Ship-to Code")
        {
            field("Ship-To Customer No."; Rec."Ship-To Customer No.")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addfirst(processing)

        {
            action("Test Invoice CRM")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomCRMSynchronization: Codeunit CustomCRMSynchronization;
                begin
                    //   CustomCRMSynchronization.SynchronizeInvoices(Rec);
                end;

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