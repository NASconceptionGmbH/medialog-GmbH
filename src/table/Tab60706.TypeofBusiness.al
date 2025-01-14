table 60706 "Type of Business"
{
    Caption = 'Type of Business';
    DataClassification = ToBeClassified;
    LookupPageId = "Type of Business List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50; "CRM GUID"; Guid)
        {
            Caption = 'CRM GUID';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}
