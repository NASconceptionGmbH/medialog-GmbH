page 60703 "Magazine Type Setup"
{
    Caption = 'Magazin Typ Einrichtung';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Magazine Type";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}