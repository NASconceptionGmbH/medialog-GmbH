page 60721 "Total Customer Revenue"
{
    APIGroup = 'crmapi';
    APIPublisher = 'nasconception';
    APIVersion = 'v1.0';
    Caption = 'totalCustomerRevenue';
    DelayedInsert = true;
    EntityName = 'totalrevenue';
    EntitySetName = 'totalrevenues';
    PageType = API;


    SourceTable = Customer;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';

                }
                field(crmGUID; Rec."CRM GUID")
                {
                    Caption = 'CRM ID';
                }
                field("totalRevenue"; TotalAmountG)
                {
                    Caption = 'Total Revenue';

                }
            }

        }
    }

    trigger OnOpenPage()
    var

    begin

    end;

    trigger OnAfterGetRecord()
    var
        CustLedgerEntryL: Record "Cust. Ledger Entry";
    begin
        // this works because we call the webservice always filtered for one record
        CustLedgerEntryL.Reset();
        CustLedgerEntryL.SetFilter("Customer No.", Rec."No.");
        if CustLedgerEntryL.FindSet() then begin
            repeat
                CustLedgerEntryL.CalcFields(Amount);
                TotalAmountG += CustLedgerEntryL.Amount;
            until CustLedgerEntryL.Next() = 0;
        end;

    end;

    var
        TotalAmountG: Decimal;
}
