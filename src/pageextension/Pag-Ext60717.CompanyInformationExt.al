pageextension 60717 "CompanyInformationExt" extends "Company Information"
{
    layout
    {
        addafter("E-Mail")
        {
            field("Bcc Mail Address"; Rec."Bcc Mail Address") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}