pageextension 60725 "StandardSalesCodes" extends "Standard Sales Codes"
{
    layout
    {
        // Add changes to page layout here
        addafter("Currency Code")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;
            }
            field(CustomerName; GetCustomerName())
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Magazine Type"; Rec."Magazine Type")
            {
                ApplicationArea = all;
            }
            field("First Item No."; Rec."First Item No.")
            {
                ApplicationArea = all;
            }
            field("Line Description"; Rec."Line Description")
            {
                ApplicationArea = all;
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = all;
            }
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = all;
            }
        }
    }


    local procedure GetCustomerName(): text[100]
    var
        CustomerL: record Customer;
    begin
        Rec.CalcFields("Customer No.");
        if CustomerL.Get(Rec."Customer No.") then
            exit(CustomerL.Name);

        exit('');
    end;
}