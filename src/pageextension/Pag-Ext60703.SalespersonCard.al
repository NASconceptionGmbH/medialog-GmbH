pageextension 60703 "Salesperson Card" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter(General)
        {
            part(Issues; "Item Issue Subform Salesperson")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger
    OnAfterGetCurrRecord()
    var
    begin
        CurrPage.Issues.Page.GetLines(Rec.Code);
        // CurrPage.Update();
    end;

    var
        myInt: Integer;
}