tableextension 60705 "CustomerExt" extends Customer
{
    fields
    {
        field(60700; "CRM GUID"; Guid)
        {
            Caption = 'CRM ID';
            DataClassification = ToBeClassified;
        }
        field(60701; "ID Location"; Text[100])
        {
            Caption = 'MyField';
            DataClassification = ToBeClassified;
        }


    }

}