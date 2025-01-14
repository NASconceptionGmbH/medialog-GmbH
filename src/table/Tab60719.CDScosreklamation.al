table 60719 "CDS cos_reklamation"
{
    ExternalName = 'cos_reklamation';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; cos_reklamationId; GUID)
        {
            ExternalName = 'cos_reklamationid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Eindeutiger Bezeichner für Entitätsinstanzen';
            Caption = 'Reklamation';
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
            Description = 'Status von Reklamation';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(26; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Grund für den Status von Reklamation';
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
        field(34; cos_abonnement; GUID)
        {
            ExternalName = 'cos_abonnement';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Abonnement';
            TableRelation = "CDS cos_abonnement".cos_abonnementId;
        }
        field(35; cos_aboytp; Option)
        {
            ExternalName = 'cos_aboytp';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abotyp';
            InitValue = " ";
            OptionMembers = " ",Jahresabo,Halbjahresabo;
            OptionOrdinalValues = -1, 181510000, 181510001;
        }
        field(37; cos_account; GUID)
        {
            ExternalName = 'cos_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Firma';
            TableRelation = "CRM Account".AccountId;
        }
        field(39; cos_cancellationdate; Date)
        {
            ExternalName = 'cos_cancellationdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Kündigungsdatum';
        }
        field(40; cos_contact; GUID)
        {
            ExternalName = 'cos_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Kontakt';
            TableRelation = "CRM Contact".ContactId;
        }
        field(41; cos_order; GUID)
        {
            ExternalName = 'cos_order';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Auftrag';
            TableRelation = "CRM Salesorder".SalesOrderId;
        }
        field(42; cos_OrderID; Text[100])
        {
            ExternalName = 'cos_orderid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Auftrags-ID';
        }
        field(43; cos_abonnementName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_abonnement".cos_name where(cos_abonnementId = field(cos_abonnement)));
            ExternalName = 'cos_abonnementname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
    }
    keys
    {
        key(PK; cos_reklamationId)
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