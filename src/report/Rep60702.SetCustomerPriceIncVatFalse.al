report 60702 "Set Customer PriceIncVatFalse"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Debitoren Preise Inkl. MwSt Nein';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Prices Including VAT";
            trigger
            OnAfterGetRecord()
            begin
                Validate("Prices Including VAT", false);
                Modify();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}