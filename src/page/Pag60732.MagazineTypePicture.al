
page 60732 "Magazine Type Picture"
{
    Caption = 'Magazin Logo';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Magazine Type";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = all;
                ShowCaption = false;
            }
        }
    }



}

