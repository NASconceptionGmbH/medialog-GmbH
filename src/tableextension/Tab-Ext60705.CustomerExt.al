tableextension 60705 "CustomerExt" extends Customer
{
    fields
    {
        field(60700; "CRM GUID"; Guid)
        {
            Caption = 'CRM ID';
            DataClassification = ToBeClassified;
        }

    }

}