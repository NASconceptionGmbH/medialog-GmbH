pageextension 60726 "Customer List" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }

    }
}