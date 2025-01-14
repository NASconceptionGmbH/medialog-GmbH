table 60718 "CDS cos_adresse"
{
    ExternalName = 'cos_adresse';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; cos_adresseId; GUID)
        {
            ExternalName = 'cos_adresseid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Eindeutiger Bezeichner für Entitätsinstanzen';
            Caption = 'Adresse';
        }
        field(2; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Datum und Uhrzeit der Erstellung des Datensatzes.';
            Caption = 'Erstellt am';
        }
        field(3; CreatedBy; GUID)
        {
            ExternalName = 'createdby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutiger Bezeichner des Benutzers, der den Datensatz erstellt hat.';
            Caption = 'Erstellt von';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(4; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Datum und Uhrzeit der Änderung des Datensatzes.';
            Caption = 'Geändert am';
        }
        field(5; ModifiedBy; GUID)
        {
            ExternalName = 'modifiedby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutiger Bezeichner des Benutzers, der den Datensatz geändert hat.';
            Caption = 'Geändert von';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(6; CreatedOnBehalfBy; GUID)
        {
            ExternalName = 'createdonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutiger Bezeichner des stellvertretenden Benutzers, der den Datensatz erstellt hat.';
            Caption = 'Erstellt von (Stellvertreter)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(7; ModifiedOnBehalfBy; GUID)
        {
            ExternalName = 'modifiedonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutiger Bezeichner des stellvertretenden Benutzers, der den Datensatz geändert hat.';
            Caption = 'Geändert von (Stellvertreter)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(16; OwnerId; GUID)
        {
            ExternalName = 'ownerid';
            ExternalType = 'Owner';
            Description = 'Besitzer-ID';
            Caption = 'Besitzer';
        }
        field(21; OwningBusinessUnit; GUID)
        {
            ExternalName = 'owningbusinessunit';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutiger Bezeichner der Unternehmenseinheit, die im Besitz des Datensatzes ist.';
            Caption = 'Besitzer (Unternehmenseinheit)';
            TableRelation = "CRM Businessunit".BusinessUnitId;
        }
        field(22; OwningUser; GUID)
        {
            ExternalName = 'owninguser';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutiger Bezeichner des Benutzers, der im Besitz des Datensatzes ist.';
            Caption = 'Besitzer (Benutzer)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(23; OwningTeam; GUID)
        {
            ExternalName = 'owningteam';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Eindeutige Kennung für das Team, das für den Datensatz zuständig ist.';
            Caption = 'Besitzer (Team)';
            TableRelation = "CRM Team".TeamId;
        }
        field(24; statecode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Status von Adresse';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(26; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Grund für den Status von Adresse';
            Caption = 'Statusgrund';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
            OptionOrdinalValues = -1, 1, 2;
        }
        field(28; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Versionsnummer';
            Caption = 'Versionsnummer';
        }
        field(29; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Sequenznummer des Imports, mit dem der Datensatz erstellt wurde.';
            Caption = 'Importsequenznummer';
        }
        field(30; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Datum und Uhrzeit der Migration des Datensatzes.';
            Caption = 'Datensatz erstellt am';
        }
        field(31; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'Nur zur internen Verwendung.';
            Caption = 'Versionsnummer der Zeitzonenregel';
        }
        field(32; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Zeitzonencode, der bei Erstellung des Datensatzes verwendet wurde.';
            Caption = 'Zeitzonencode für die UTC-Konvertierung';
        }
        field(33; cos_name; Text[850])
        {
            ExternalName = 'cos_name';
            ExternalType = 'String';
            Description = 'Der Name der angepassten Entität.';
            Caption = 'Name';
        }
        field(34; cos_additionaladdress; Text[100])
        {
            ExternalName = 'cos_additionaladdress';
            ExternalType = 'String';
            Description = '';
            Caption = 'Adresszusatz';
        }
        field(35; cos_city; Text[80])
        {
            ExternalName = 'cos_city';
            ExternalType = 'String';
            Description = '';
            Caption = 'Ort';
        }
        field(36; cos_compositeaddress; Text[250])
        {
            ExternalName = 'cos_compositeaddress';
            ExternalType = 'String';
            Description = '';
            Caption = 'Gesamte Adresse';
        }
        field(38; cos_countrycode; Text[100])
        {
            ExternalName = 'cos_countrycode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Landescode';
        }
        field(39; cos_housenumber; Text[5])
        {
            ExternalName = 'cos_housenumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'Hausnummer';
        }
        field(40; cos_NielsenGebiet; Text[100])
        {
            ExternalName = 'cos_nielsengebiet';
            ExternalType = 'String';
            Description = '';
            Caption = 'Nielsen Gebiet';
        }
        field(41; cos_postalcode; Text[21])
        {
            ExternalName = 'cos_postalcode';
            ExternalType = 'String';
            Description = '';
            Caption = 'PLZ';
        }
        field(42; cos_postbox; Text[100])
        {
            ExternalName = 'cos_postbox';
            ExternalType = 'String';
            Description = '';
            Caption = 'Postfach';
        }
        field(43; cos_postboxplz; Text[100])
        {
            ExternalName = 'cos_postboxplz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Postfach PLZ';
        }
        field(44; cos_street2; Text[100])
        {
            ExternalName = 'cos_street2';
            ExternalType = 'String';
            Description = '';
            Caption = 'Straße 2';
        }
        field(45; cos_street3; Text[100])
        {
            ExternalName = 'cos_street3';
            ExternalType = 'String';
            Description = '';
            Caption = 'Straße 3';
        }
        field(49; cos_shipttoaddress; Boolean)
        {
            ExternalName = 'cos_shipttoaddress';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Lieferadresse';
        }
        field(51; cos_mailingaddress; Boolean)
        {
            ExternalName = 'cos_mailingaddress';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Briefadresse';
        }
        field(53; cos_visitaddress; Boolean)
        {
            ExternalName = 'cos_visitaddress';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Besuchsadresse';
        }
        field(55; cos_dataimport; Text[100])
        {
            ExternalName = 'cos_dataimport';
            ExternalType = 'String';
            Description = '';
            Caption = 'Datenimport';
        }
        field(56; cos_street; Text[108])
        {
            ExternalName = 'cos_street';
            ExternalType = 'String';
            Description = '';
            Caption = 'Straße / Postfach';
        }
        field(57; cos_uebertragname; Text[100])
        {
            ExternalName = 'cos_uebertragname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Übertrag name';
        }
        field(58; new_Updated; Boolean)
        {
            ExternalName = 'new_updated';
            ExternalType = 'Boolean';
            Description = 'Field can be deleted after the Flow updates all Adresses';
            Caption = 'Updated';
        }
    }
    keys
    {
        key(PK; cos_adresseId)
        {
            Clustered = true;
        }
        key(Name; cos_name)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; cos_name)
        {
        }
    }
}