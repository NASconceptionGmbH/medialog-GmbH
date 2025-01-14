tableextension 60716 "CompanyInformationExt" extends "Company Information"
{
    fields
    {
        field(50100; "Bcc Mail Address"; Text[80])
        {
            Caption = 'Bcc Mail Address';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if Rec."Bcc Mail Address" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses(Rec."Bcc Mail Address");
            end;
        }
    }

    var
        myInt: Integer;
}