reportextension 60700 "SalesOrderExt" extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Header)
        {
            column(ClerkName; ClerkName)
            {

            }
            column(ClerkPosition; ClerkPosition)
            {

            }
            column(ClerkEmail; ClerkEmail)
            {

            }
            column(ClerkPhone; ClerkPhone)
            {

            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin
                if SalespersonPurchaserL.Get(Header.Clerk) then begin
                    ClerkName := SalespersonPurchaserL.Name;
                    ClerkPosition := SalespersonPurchaserL."Job Title";
                    ClerkEmail := SalespersonPurchaserL."E-Mail";
                    ClerkPhone := SalespersonPurchaserL."Phone No.";
                end;
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    var
        ClerkName: text;
        ClerkPosition: Text;
        ClerkEmail: Text;
        ClerkPhone: Text;
}