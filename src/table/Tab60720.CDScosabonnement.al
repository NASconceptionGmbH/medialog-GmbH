table 60720 "CDS cos_abonnement"
{
    ExternalName = 'cos_abonnement';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; cos_abonnementId; GUID)
        {
            ExternalName = 'cos_abonnementid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Eindeutiger Bezeichner für Entitätsinstanzen';
            Caption = 'AbonnementID';
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
            Description = 'Status von Abonnement';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(26; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Grund für den Status von Abonnement';
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
        field(34; cos_AbonnementsContactsId; GUID)
        {
            ExternalName = 'cos_abonnementscontactsid';
            ExternalType = 'Lookup';
            Description = 'Eindeutiger Bezeichner für Kontakt, zugeordnet zu Abonnement.';
            Caption = 'Abonnements Contact Id';
            TableRelation = "CRM Contact".ContactId;
        }
        field(35; cos_AbonnementsId; GUID)
        {
            ExternalName = 'cos_abonnementsid';
            ExternalType = 'Lookup';
            Description = 'Eindeutiger Bezeichner für Firma, zugeordnet zu Abonnement.';
            Caption = 'Abonnements Account Id';
            TableRelation = "CRM Account".AccountId;
        }
        field(36; cos_Abostatus; Option)
        {
            ExternalName = 'cos_abostatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abostatus';
            InitValue = " ";
            OptionMembers = " ",Inaktiv,"AktivOhneTerminkündigung","AktivMitTerminkündigung",InaktivInTerminzugang;
            OptionOrdinalValues = -1, 181510000, 181510001, 181510002, 181510003;
        }
        field(38; cos_abotyp; Option)
        {
            ExternalName = 'cos_abotyp';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abo-Typ Old';
            InitValue = " ";
            OptionMembers = " ",Freiabo,"Buchhandelsabo10%","Buchhandelsabo15%","Buchhandelsabo10%+Individualrabatt20%","Buchhandelsabo10%+Mitgliedsrabatt30%","Buchhandelsabo15%+Mitgliedsrabatt30%","Individualrabatt10%","Individualrabatt20%","Individualrabatt25%","Individualrabatt28%","Individualrabatt35%","Individualrabatt40%","Mitgliedsrabatt30%","Mitgliedsrabatt37%","Studentenabo50%",Normalabo,"Prämienabo",Halbjahresabo;
            OptionOrdinalValues = -1, 181510000, 181510002, 181510005, 181510017, 181510006, 181510016, 181510007, 181510008, 181510009, 181510010, 181510011, 181510012, 181510013, 181510014, 181510015, 181510003, 181510001, 181510004;
        }
        field(40; cos_account; GUID)
        {
            ExternalName = 'cos_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Firma';
            TableRelation = "CRM Account".AccountId;
        }
        field(41; cos_Adresse; GUID)
        {
            ExternalName = 'cos_adresse';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Adresse';
            TableRelation = "CDS cos_adresse".cos_adresseId;
        }
        field(42; cos_BasicProduct; GUID)
        {
            ExternalName = 'cos_basicproduct';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Basic Produkt';
            TableRelation = "CRM Product".ProductId;
        }
        field(43; cos_billtoaddress; GUID)
        {
            ExternalName = 'cos_billtoaddress';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Rechnungsadresse';
            TableRelation = "CDS cos_adresse".cos_adresseId;
        }
        field(44; cos_characteristics; GUID)
        {
            ExternalName = 'cos_characteristics';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Merkmal';
            TableRelation = "CDS cos_characteristic".cos_characteristicId;
        }
        field(45; cos_contact; GUID)
        {
            ExternalName = 'cos_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Kontakt';
            TableRelation = "CRM Contact".ContactId;
        }
        field(46; cos_dateofentry; Date)
        {
            ExternalName = 'cos_dateofentry';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Erfassungsdatum';
        }
        field(47; cos_deliveryend; Text[100])
        {
            ExternalName = 'cos_deliveryend';
            ExternalType = 'String';
            Description = '';
            Caption = 'Lieferende';
        }
        field(48; cos_dismissal; Date)
        {
            ExternalName = 'cos_dismissal';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Kündigung zum';
        }
        field(49; cos_end; Date)
        {
            ExternalName = 'cos_end';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Laufzeit Ende';
        }
        field(50; cos_endofdeliveryyear; Text[100])
        {
            ExternalName = 'cos_endofdeliveryyear';
            ExternalType = 'String';
            Description = '';
            Caption = 'Lieferende (Jahr)';
        }
        field(51; cos_LEdateofentry; Date)
        {
            ExternalName = 'cos_ledateofentry';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Letzte Auslieferung';
        }
        field(52; cos_order; GUID)
        {
            ExternalName = 'cos_order';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Auftrag';
            TableRelation = "CRM Salesorder".SalesOrderId;
        }
        field(53; cos_orderdate; Date)
        {
            ExternalName = 'cos_orderdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Bestelldatum';
        }
        field(54; cos_OrderID; Text[100])
        {
            ExternalName = 'cos_orderid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Auftrags-ID';
        }
        field(55; cos_reasonfordismissal; Option)
        {
            ExternalName = 'cos_reasonfordismissal';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Kündigungsgrund';
            InitValue = " ";
            OptionMembers = " ",NichtBelegt,AbonnentIstVerstorben,AndererGrund,AnnahmeVerweigert,AnnahmeVerweigertKeineMahnung,AustrittAusVerbandOderVerein,AutomLENachAnzahlGelieferterFolgen,BefristetBeiBestellungMitErinnerungsschreiben,BefristetBeiBestellungOhneErinnerungsschreiben,EmpfaengerwechselDurchKunden,FachinfosAnderweitigBeschafft,Freiabo,FristgerechterWiderruferNO,FZSInhaltlichNichtRelevant,FZSWirdNichtRegelmaessigGelesen,FZSZuTeuer,InterneUmbestellungDurchKunden,InternerTitelwechselDurchKunden,InternerTitelwechselDurchVerlag,ZuVielWerbung,KulanzfallMitBegruendung,KundeBekommtZuVieleGleichartigeFZS,KundeInInkasso,KundeInInsolvenz,KundeIstAnderweitigTaetig,KundeNichtMehrTaetig,KundeStelltBetriebOderBerufstaetigkeitEin,LiefereinstellungNichtzahler,LiefereinstellungNichtzahlerNormalAbo,NichtZuErmitteln,OhneAngabeEinesGrundes,PPVerschoben,StandardLieferendegrund,TiteleinstellungDurchVerlag,UmstellungABOZuABOS,UnbekanntVerzogen,VerbandOderVereinKuendigtSammelbezugsvereinbarung,VerspaeteterWiderruferNOMRechnungsstorno,Verstorben;
            OptionOrdinalValues = -1, 181510037, 181510033, 181510022, 181510031, 181510010, 181510021, 181510003, 181510011, 181510000, 181510015, 181510019, 181510007, 181510001, 181510032, 181510017, 181510018, 181510012, 181510013, 181510016, 181510025, 181510028, 181510030, 181510023, 181510029, 181510027, 181510009, 181510026, 181510024, 181510008, 181510014, 181510005, 181510036, 181510002, 181510006, 181510035, 181510020, 181510038, 181510034, 181510004;
        }
        field(57; cos_Reklamation; GUID)
        {
            ExternalName = 'cos_reklamation';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Reklamation';
            TableRelation = "CDS cos_reklamation".cos_reklamationId;
        }
        field(58; cos_shiptoaddress; GUID)
        {
            ExternalName = 'cos_shiptoaddress';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lieferadresse';
            TableRelation = "CDS cos_adresse".cos_adresseId;
        }
        field(59; cos_sparte; GUID)
        {
            ExternalName = 'cos_sparte';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Sparte';
            TableRelation = "CDS cos_sparten".cos_spartenId;
        }
        field(60; cos_start; Date)
        {
            ExternalName = 'cos_start';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Laufzeit Start';
        }
        field(61; cos_startofdelivery; Text[100])
        {
            ExternalName = 'cos_startofdelivery';
            ExternalType = 'String';
            Description = '';
            Caption = 'Lieferbeginn';
        }
        field(62; cos_startofdeliveryyear; Text[100])
        {
            ExternalName = 'cos_startofdeliveryyear';
            ExternalType = 'String';
            Description = '';
            Caption = 'Lieferbeginn (Jahr)';
        }
        field(63; cos_status; Option)
        {
            ExternalName = 'cos_status';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Zustand';
            InitValue = " ";
            OptionMembers = " ",Reklamation;
            OptionOrdinalValues = -1, 181510002;
        }
        field(65; cos_typeofcustomer; GUID)
        {
            ExternalName = 'cos_typeofcustomer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Kundenart';
            TableRelation = "CDS cos_typeofcustomer".cos_typeofcustomerId;
        }
        field(70; cos_ReklamationName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_reklamation".cos_name where(cos_reklamationId = field(cos_Reklamation)));
            ExternalName = 'cos_reklamationname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(71; cos_billtoaddressName; Text[850])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_adresse".cos_name where(cos_adresseId = field(cos_billtoaddress)));
            ExternalName = 'cos_billtoaddressname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(72; cos_shiptoaddressName; Text[850])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_adresse".cos_name where(cos_adresseId = field(cos_shiptoaddress)));
            ExternalName = 'cos_shiptoaddressname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(77; cos_AdresseName; Text[850])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_adresse".cos_name where(cos_adresseId = field(cos_Adresse)));
            ExternalName = 'cos_adressename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(78; cos_characteristicsName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_characteristic".cos_name where(cos_characteristicId = field(cos_characteristics)));
            ExternalName = 'cos_characteristicsname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(79; cos_typeofcustomerName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_typeofcustomer".cos_name where(cos_typeofcustomerId = field(cos_typeofcustomer)));
            ExternalName = 'cos_typeofcustomername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(82; cos_sparteName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS cos_sparten".cos_name where(cos_spartenId = field(cos_sparte)));
            ExternalName = 'cos_spartename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(83; cos_commentdismissal; BLOB)
        {
            ExternalName = 'cos_commentdismissal';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Kommentar Kündigung';
            Subtype = Memo;
        }
        field(84; cos_dataimport; Text[100])
        {
            ExternalName = 'cos_dataimport';
            ExternalType = 'String';
            Description = '';
            Caption = 'Datenimport';
        }
        field(85; cos_shiptocontact; GUID)
        {
            ExternalName = 'cos_shiptocontact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lieferung an Kontakt';
            TableRelation = "CRM Contact".ContactId;
        }
        field(88; cos_orderbycontact; GUID)
        {
            ExternalName = 'cos_orderbycontact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Bestellt durch Kontakt';
            TableRelation = "CRM Contact".ContactId;
        }
        field(91; cos_dateofcancellation; Date)
        {
            ExternalName = 'cos_dateofcancellation';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Kündigungsdatum';
        }
        field(94; cos_Anrede; Text[100])
        {
            ExternalName = 'cos_anrede';
            ExternalType = 'String';
            Description = '';
            Caption = 'Anrede';
        }
        field(95; cos_Vorname; Text[100])
        {
            ExternalName = 'cos_vorname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Vorname';
        }
        field(96; cos_Nachname; Text[100])
        {
            ExternalName = 'cos_nachname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Nachname';
        }
        field(97; cos_Strae; Text[100])
        {
            ExternalName = 'cos_strae';
            ExternalType = 'String';
            Description = '';
            Caption = 'Straße';
        }
        field(98; cos_PLZ; Text[100])
        {
            ExternalName = 'cos_plz';
            ExternalType = 'String';
            Description = '';
            Caption = 'PLZ';
        }
        field(99; cos_Ort; Text[100])
        {
            ExternalName = 'cos_ort';
            ExternalType = 'String';
            Description = '';
            Caption = 'Ort';
        }
        field(100; cos_Laendercode; Text[100])
        {
            ExternalName = 'cos_laendercode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Ländercode';
        }
        field(101; cos_Menge; Text[100])
        {
            ExternalName = 'cos_menge';
            ExternalType = 'String';
            Description = '';
            Caption = 'Menge';
        }
        field(102; cos_Strasse2; Text[100])
        {
            ExternalName = 'cos_strasse2';
            ExternalType = 'String';
            Description = '';
            Caption = 'Straße 2';
        }
        field(103; cos_Adresszusatz; Text[100])
        {
            ExternalName = 'cos_adresszusatz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Adresszusatz';
        }
        field(104; cos_salutation; Option)
        {
            ExternalName = 'cos_salutation';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Anrede';
            InitValue = " ";
            OptionMembers = " ",Baron,Botschafter,Botschafterin,Familie,Frau,FrauGeneralkonsulin,"FrauGeneralsekretärin","FrauGeschäftssekretärinA",FrauKonsulin,HerrGeneralkonsul,"HerrGeneralsekretär",HerrGesandter,"HerrGeschäftssekretärA","HerrStatssekretär",Herrn,"Herrn/Frau",Konsul,Rechtsanwalt;
            OptionOrdinalValues = -1, 181510000, 181510001, 181510002, 181510003, 181510004, 181510005, 181510006, 181510007, 181510008, 181510009, 181510010, 181510011, 181510012, 181510013, 181510014, 181510015, 181510016, 181510017;
        }
        field(106; cos_grossinvoiceamount; Decimal)
        {
            ExternalName = 'cos_grossinvoiceamount';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Faktursummer (brutto)';
        }
        field(107; cos_abo_typ; Option)
        {
            ExternalName = 'cos_abo_typ';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abo-Typ Übertrag';
            InitValue = " ";
            OptionMembers = " ","EPaper/Scifo",MitgliedsaboNAMUR,"Buchhandelsabo10%+Individualrabatt10%","Buchhandelsabo15%+Individualrabatt10%",Freiabo,"Buchhandelsabo10%","Buchhandelsabo15%","Buchhandelsabo10%+Individualrabatt20%","Buchhandelsabo10%+Mitgliedsrabatt30%","Buchhandelsabo15%+Mitgliedsrabatt30%","Individualrabatt10%","Individualrabatt20%","Individualrabatt25%","Individualrabatt28%","Individualrabatt35%","Individualrabatt40%","Mitgliedsrabatt30%","Mitgliedsrabatt37%","Studentenabo50%",Normalabo,"Prämienabo",Halbjahresabo,"SmallBusiness/Campus";
            OptionOrdinalValues = -1, 181510021, 181510018, 181510019, 181510020, 181510000, 181510001, 181510005, 181510017, 181510007, 181510006, 181510008, 181510009, 181510010, 181510011, 181510012, 181510013, 181510014, 181510015, 181510016, 181510002, 181510003, 181510004, 181510022;
        }
        field(111; cos_abostatusuebertrag; Option)
        {
            ExternalName = 'cos_abostatusuebertrag';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abostatus Übertrag';
            InitValue = " ";
            OptionMembers = " ",Inaktiv,"AktivOhneTerminkündigung","AktivMitTerminkündigung",InaktivMitTerminzugang;
            OptionOrdinalValues = -1, 181510000, 181510001, 181510002, 181510003;
        }
        field(113; cos_firmenzusatz; Text[100])
        {
            ExternalName = 'cos_firmenzusatz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Firmenzusatz';
        }
        field(114; cos_kontaktzusatz; Text[100])
        {
            ExternalName = 'cos_kontaktzusatz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Kontaktzusatz';
        }
        field(115; cos_lieferempfaengerkontakt; GUID)
        {
            ExternalName = 'cos_lieferempfaengerkontakt';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lieferempfänger (Kontakt)';
            TableRelation = "CRM Contact".ContactId;
        }
        field(116; cos_lieferempfangerfirma; GUID)
        {
            ExternalName = 'cos_lieferempfangerfirma';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lieferempfänger (Firma)';
            TableRelation = "CRM Account".AccountId;
        }
        field(117; cos_lieferungankunde; GUID)
        {
            ExternalName = 'cos_lieferungankunde';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lieferung an Kunde';
            TableRelation = "CRM Account".AccountId;
        }
        field(124; cos_Abonummer; Text[100])
        {
            ExternalName = 'cos_abonummer';
            ExternalType = 'String';
            Description = '';
            Caption = 'Abonummer';
        }
        field(125; cos_lieferbeginn; Date)
        {
            ExternalName = 'cos_lieferbeginn';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Lieferbeginn';
        }
        field(126; cos_flowhasrun; Boolean)
        {
            ExternalName = 'cos_flowhasrun';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'FlowHasRun';
        }
        field(128; cos_BestellungAbonnementId; GUID)
        {
            ExternalName = 'cos_bestellungabonnementid';
            ExternalType = 'Lookup';
            Description = 'Eindeutiger Bezeichner für Bestellung, zugeordnet zu Abonnement.';
            Caption = 'BetsellungAbonnement';
            TableRelation = "CRM Salesorder".SalesOrderId;
        }
        field(130; cos_AboTypNew; Option)
        {
            ExternalName = 'cos_abotypnew';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abo-Typ';
            InitValue = " ";
            OptionMembers = " ","EPaper/Scifo",MitgliedsaboNAMUR,"Buchhandelsabo10%+Individualrabatt10%","Buchhandelsabo15%+Individualrabatt10%",Freiabo,"Buchhandelsabo10%","Buchhandelsabo15%","Buchhandelsabo25%","Buchhandelsabo10%+Individualrabatt20%","Buchhandelsabo10%+Mitgliedsrabatt30%","Buchhandelsabo15%+Mitgliedsrabatt30%","Individualrabatt10%","Individualrabatt20%","Individualrabatt25%","Individualrabatt28%","Individualrabatt35%","Individualrabatt40%","Mitgliedsrabatt30%","Mitgliedsrabatt37%","Studentenabo50%",Normalabo,"Prämienabo",Halbjahresabo,"SmallBusiness/Campus";
            OptionOrdinalValues = -1, 181510021, 181510018, 181510019, 181510020, 181510000, 181510001, 181510005, 100000000, 181510017, 181510007, 181510006, 181510008, 181510009, 181510010, 181510011, 181510012, 181510013, 181510014, 181510015, 181510016, 181510002, 181510003, 181510004, 181510022;
        }
        field(133; new_accountguid; Text[50])
        {
            ExternalName = 'new_accountguid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Firmen GUID';
        }
        field(134; new_customerguid; Text[50])
        {
            ExternalName = 'new_customerguid';
            ExternalType = 'String';
            Description = 'In diesem Feld steht die GUID des Datensatzes, der über das Feld Lieferung an Kunde gesetzt wurde.';
            Caption = 'Kunden GUID';
        }
        field(136; vv_EMailInvoiceRecipient; Text[100])
        {
            ExternalName = 'vv_emailinvoicerecipient';
            ExternalType = 'String';
            Description = 'Rechnungsempfänger E-Mail';
            Caption = 'Rechnungsempfänger E-Mail';
        }
        field(137; new_abostatus; Option)
        {
            ExternalName = 'new_abostatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Abostatus';
            InitValue = " ";
            OptionMembers = " ",Inaktiv,"AktivOhneTerminkündigung","AktivMitTerminkündigung",InaktivInTerminzugang;
            OptionOrdinalValues = -1, 100000000, 100000001, 100000002, 100000003;
        }
        field(138; new_IhreReferenz; Text[35])
        {
            ExternalName = 'new_ihrereferenz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Ihre Referenz';
        }
        field(139; new_Rabatt; GUID)
        {
            ExternalName = 'new_rabatt';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Rabatt';
            TableRelation = "CDS cos_rabattkategorien".cos_rabattkategorienId;
        }
        // field(60700; AccountName; Text[160])
        // {
        //     CalcFormula = Lookup("CRM Account".Name WHERE(AccountId = FIELD(cos_account)));
        //     Caption = 'AccountName';
        //     ExternalAccess = Read;
        //     ExternalName = 'AccountName';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60701; "AccountNo"; Text[20])
        // {
        //     CalcFormula = Lookup("CRM Account".new_bccustomerno WHERE(AccountId = FIELD(cos_account)));
        //     Caption = 'AccountNo';
        //     ExternalAccess = Read;
        //     ExternalName = 'AccountNo';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60702; "Product Name"; Text[100])
        // {
        //     CalcFormula = Lookup("CRM Product".Name where(ProductId = field(cos_BasicProduct)));
        //     Caption = 'Product Name';
        //     ExternalAccess = Read;
        //     ExternalName = 'ProductName';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60703; "OrderByContactName"; Text[160])
        // {
        //     CalcFormula = Lookup("CRM Contact".FullName where(ContactId = field(cos_orderbycontact)));
        //     Caption = 'Order By Contact Name';
        //     ExternalAccess = Read;
        //     ExternalName = 'OrderByContactName';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60704; "ShipToAccountName"; Text[160])
        // {
        //     CalcFormula = Lookup("CRM Account".Name where(AccountId = field(cos_lieferungankunde)));
        //     Caption = 'Ship To Account Name';
        //     ExternalAccess = Read;
        //     ExternalName = 'ShipToAccountName';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60705; "ShipToContactName"; Text[160])
        // {
        //     CalcFormula = Lookup("CRM Contact".FullName where(ContactId = field(cos_shiptocontact)));
        //     Caption = 'Ship To Contact Name';
        //     ExternalAccess = Read;
        //     ExternalName = 'ShipToContactName';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60706; "BillingAddresZipCode"; Text[21])
        // {
        //     CalcFormula = Lookup("CDS cos_adresse".cos_postalcode where(cos_adresseId = field(cos_billtoaddress)));
        //     Caption = 'Billing Addres Zip Code';
        //     ExternalAccess = Read;
        //     ExternalName = 'BillingAddresZipCode';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }

        // field(60707; "BillingAddresCity"; Text[80])
        // {
        //     CalcFormula = Lookup("CDS cos_adresse".cos_city where(cos_adresseId = field(cos_billtoaddress)));
        //     Caption = 'Billing Addres City';
        //     ExternalAccess = Read;
        //     ExternalName = 'BillingAddresCity';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60708; "BillingAddresCountry"; Text[100])
        // {
        //     CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_billtoaddress)));
        //     Caption = 'Billing Addres City';
        //     ExternalAccess = Read;
        //     ExternalName = 'BillingAddresCity';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60709; "ShippingAddresZipCode"; Text[21])
        // {
        //     CalcFormula = Lookup("CDS cos_adresse".cos_postalcode where(cos_adresseId = field(cos_shiptoaddress)));
        //     Caption = 'Shipping Addres Zip Code';
        //     ExternalAccess = Read;
        //     ExternalName = 'ShippingAddresZipCode';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60710; "ShippingAddresCity"; Text[80])
        // {
        //     CalcFormula = Lookup("CDS cos_adresse".cos_city where(cos_adresseId = field(cos_shiptoaddress)));
        //     Caption = 'ShippingAddres City';
        //     ExternalAccess = Read;
        //     ExternalName = 'ShippingAddresCity';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60711; "ShippingAddresCountry"; Text[100])
        // {
        //     CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_shiptoaddress)));
        //     Caption = 'Shipping Addres City';
        //     ExternalAccess = Read;
        //     ExternalName = 'ShippingAddresCity';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60712; "OrderByContactFirstName"; Text[50])
        // {
        //     CalcFormula = Lookup("CRM Contact".FirstName where(AccountId = field(cos_orderbycontact)));
        //     Caption = 'Order By Contact Firstname';
        //     ExternalAccess = Read;
        //     ExternalName = 'OrderByContactFirstname';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }

        // field(60713; "OrderByContactLastName"; Text[50])
        // {
        //     CalcFormula = Lookup("CRM Contact".LastName where(ContactId = field(cos_orderbycontact)));
        //     Caption = 'Order By Contact Lastname';
        //     ExternalAccess = Read;
        //     ExternalName = 'OrderByContactLastname';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60714; "OrderByContactBusinessPhone"; Text[50])
        // {
        //     CalcFormula = Lookup("CRM Contact".Telephone1 where(ContactId = field(cos_orderbycontact)));
        //     Caption = 'Order By Contact Phone';
        //     ExternalAccess = Read;
        //     ExternalName = 'OrderByContactPhone';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60715; "OrderByContactMobile"; Text[50])
        // {
        //     CalcFormula = Lookup("CRM Contact".MobilePhone where(ContactId = field(cos_orderbycontact)));
        //     Caption = 'Order By Contact Mobile';
        //     ExternalAccess = Read;
        //     ExternalName = 'OrderByContactMobile';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }
        // field(60716; "OrderByContactEmail"; Text[100])
        // {
        //     CalcFormula = Lookup("CRM Contact".EMailAddress1 where(ContactId = field(cos_orderbycontact)));
        //     Caption = 'Order By Contact Email';
        //     ExternalAccess = Read;
        //     ExternalName = 'OrderByContactEmail';
        //     ExternalType = 'String';
        //     FieldClass = FlowField;
        // }

    }
    keys
    {
        key(PK; cos_abonnementId)
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