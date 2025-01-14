table 60715 "CRMCustomSyncSetup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Tenant ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "CRM URL"; Text[100])
        {
            Caption = 'CRM Url';
            DataClassification = ToBeClassified;
        }
        field(4; "Client ID"; Text[100])
        {
            Caption = 'Client ID';
            DataClassification = ToBeClassified;
        }
        field(5; "Secret ID"; Text[100])
        {
            Caption = 'Secret ID';
            DataClassification = ToBeClassified;
        }
        field(6; "Access Token"; Text[2048])
        {
            Caption = 'Access Token';
            DataClassification = ToBeClassified;
        }
        field(7; "Token URL"; Text[100])
        {
            Caption = 'Token URL';
            DataClassification = ToBeClassified;
        }
        field(8; "API URL"; Text[100])
        {
            Caption = 'API URL';
            DataClassification = ToBeClassified;
        }
        field(10; LastTokenUpdate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Sharepoint Doc Location GUID"; GUID)
        {
            Caption = 'Sharepoint Doc Location GUID';
            DataClassification = ToBeClassified;
        }
        field(12; "DriveID"; Text[300])
        {
            Caption = 'DriveID';
            DataClassification = ToBeClassified;
        }




    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}