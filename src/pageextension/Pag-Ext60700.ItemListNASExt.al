pageextension 60700 "ItemListNASExt" extends "Item List"
{
    layout
    {
        addafter(Type)
        {
            field(GTIN2; Rec.GTIN)
            {
                ApplicationArea = All;
            }
            field("Publication Date"; Rec."Publication Date")
            {
                ApplicationArea = All;
            }
            field("Sales (LCY)"; Rec."Sales (LCY)")
            {
                ApplicationArea = All;
            }


        }

    }

    actions
    {
    }
}