tableextension 60726 "Contact" extends Contact
{
    fields
    {
        field(60700; "CRM GUID"; Guid)
        {
            Caption = 'CRM ID';
            DataClassification = ToBeClassified;
        }
        field(60701; "id location"; text[100])
        {
            Caption = 'id location';
            DataClassification = ToBeClassified;
        }
        field(60702; "id juristic person"; text[100])
        {
            Caption = 'id juristic person';
            DataClassification = ToBeClassified;
        }


    }

}