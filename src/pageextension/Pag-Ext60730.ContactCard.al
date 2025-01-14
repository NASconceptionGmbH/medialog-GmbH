pageextension 60730 "ContactCard" extends "Contact Card"
{
    layout
    {

    }

    actions
    {
        addafter(SalesQuotes)
        {

            action(Merkmale)
            {
                ApplicationArea = All;
                Caption = 'Merkmale';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                image = ContactPerson;
                RunObject = page "Contact Characteristics List";
                RunPageLink = "Contact No." = field("No.");
            }
        }

    }
}