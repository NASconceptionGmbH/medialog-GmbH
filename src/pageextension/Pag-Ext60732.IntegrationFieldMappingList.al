pageextension 60732 "Integration Field Mapping List" extends "Integration Field Mapping List"
{
    layout
    {

    }

    actions
    {
        addlast(Processing)
        {
            action(DeleteLine)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.delete();
                end;
            }
        }
    }
}