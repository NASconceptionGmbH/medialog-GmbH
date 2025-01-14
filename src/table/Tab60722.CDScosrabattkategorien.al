table 60722 "CDS cos_rabattkategorien"
{
    ExternalName = 'cos_rabattkategorien';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; cos_rabattkategorienId; GUID)
        {
            ExternalName = 'cos_rabattkategorienid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Eindeutiger Bezeichner für Entitätsinstanzen';
            Caption = 'Rabattkategorie';
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
            Description = 'Status von Rabattkategorie';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(26; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Grund für den Status von Rabattkategorie';
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
        field(33; cos_name; Text[100])
        {
            ExternalName = 'cos_name';
            ExternalType = 'String';
            Description = 'Der Name der angepassten Entität.';
            Caption = 'Name';
        }
        field(35; cos_rabatt; Decimal)
        {
            ExternalName = 'cos_rabatt';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Rabatt';
        }
    }
    keys
    {
        key(PK; cos_rabattkategorienId)
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