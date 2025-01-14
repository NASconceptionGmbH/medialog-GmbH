table 60703 "SharePoint Setup"
{
    DataClassification = OrganizationIdentifiableInformation;
    fields
    {
        field(1; "SiteID 1"; Text[250])
        {
            Caption = 'Site ID 1', comment = 'DEU="Seiten ID 1"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; "HighestFolder"; Text[250])
        {
            Caption = 'Highest Folder', comment = 'DEU="Höchster Ordner"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "TenantID"; Text[250])
        {
            Caption = 'Tenant ID', comment = 'DEU="Tenant ID"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(4; "MaximalTiefe"; Integer)
        {
            Caption = 'Max depth', comment = 'DEU="Maximal Tiefe"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = 2;
        }
        field(5; "CreateLinkEnabled"; Boolean)
        {
            Caption = 'Edit Items in Live', comment = 'DEU="Items im Live editieren"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = true;
        }

        field(14; "InBearbeitung"; Boolean)
        {
            Caption = 'Processing', comment = 'DEU="In Bearbeitung"';
            InitValue = true;
            DataClassification = OrganizationIdentifiableInformation;
        }

        /*  field(18; EnableCustomDocumentSelec; Boolean)
          {
              Caption = 'Enable Custom Doc.Type Selection', comment = 'DEU="Ben. def. Dokumententypauswahl"';
              DataClassification = OrganizationIdentifiableInformation;
          }
          field(19; AutoSaveDocuments; Boolean)
          {
              Caption = 'Auto Save', comment = 'DEU="Auto. Speicherung der Dokumente"';
              DataClassification = OrganizationIdentifiableInformation;
  
    }*/
        field(100; "PK"; Code[5])
        {
            Caption = 'ID';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(20; "SalesLine"; Text[250])
        {
            Caption = 'Sales Line';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = 'Sales Line';
        }

        field(50; DocumentsLanguage; Integer)
        {
            Caption = 'Document Language ID';
            DataClassification = OrganizationIdentifiableInformation;
            initValue = 0;
        }
        field(110; "ColumnDescription"; Text[100])
        {
            Caption = 'Artikelbeschreibung Spalte';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = 'Artikelbeschreibung';
        }
        field(111; "Client ID"; Text[50])
        {
            Caption = 'Client ID';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(112; "Client Secret"; Text[100])
        {
            Caption = 'Client Secret';
            ExtendedDatatype = Masked;
            DataClassification = OrganizationIdentifiableInformation;
        }


    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }

}