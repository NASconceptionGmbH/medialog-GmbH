table 60721 "Subscriptions"
{
    Caption = 'Abonnement';

    fields
    {
        field(1; cos_abonnementId; GUID)
        {
            // ExternalType = 'Uniqueidentifier';
            Description = 'Eindeutiger Bezeichner für Entitätsinstanzen';
            Caption = 'AbonnementID';
        }

        field(24; statecode; Option)
        {
            Description = 'Status von Abonnement';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
        }
        field(26; statuscode; Option)
        {
            Description = 'Grund für den Status von Abonnement';
            Caption = 'Statusgrund';
            InitValue = " ";
            OptionMembers = " ",Aktiv,Inaktiv;
        }

        field(33; cos_name; Text[100])
        {
            Description = 'Der Name der angepassten Entität.';
            Caption = 'Name';
        }
        field(34; cos_AbonnementsContactsId; Text[100])
        {
            // ExternalType = 'Lookup';
            Description = 'Eindeutiger Bezeichner für Kontakt, zugeordnet zu Abonnement.';
            Caption = 'Abonnements ContactID';
            // TableRelation = "CRM Contact".ContactId;
        }
        field(35; cos_AbonnementsId; Text[100])
        {
            // ExternalType = 'Lookup';
            Description = 'Eindeutiger Bezeichner für Firma, zugeordnet zu Abonnement.';
            Caption = 'Abonnements Account Id';
            // TableRelation = "CRM Account".AccountId;
        }
        field(36; cos_Abostatus; Option)
        {
            Caption = 'Abostatus';
            InitValue = " ";
            OptionMembers = " ",Inaktiv,"AktivOhneTerminkündigung","AktivMitTerminkündigung",InaktivInTerminzugang;
        }
        field(38; cos_abotyp; Option)
        {
            Caption = 'Abo-Typ Old';
            InitValue = " ";
            OptionMembers = " ",Freiabo,"Buchhandelsabo10%","Buchhandelsabo15%","Buchhandelsabo10%+Individualrabatt20%","Buchhandelsabo10%+Mitgliedsrabatt30%","Buchhandelsabo15%+Mitgliedsrabatt30%","Individualrabatt10%","Individualrabatt20%","Individualrabatt25%","Individualrabatt28%","Individualrabatt35%","Individualrabatt40%","Mitgliedsrabatt30%","Mitgliedsrabatt37%","Studentenabo50%",Normalabo,"Prämienabo",Halbjahresabo;
        }
        field(40; cos_account; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Firma';
            // TableRelation = "CRM Account".AccountId;
        }
        field(41; cos_Adresse; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Adresse';
            // TableRelation = "CDS cos_adresse".cos_adresseId;
        }
        field(42; cos_BasicProduct; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Basic Produkt';
            // TableRelation = "CRM Product".ProductId;
        }
        field(43; cos_billtoaddress; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Rechnungsadresse';
            // TableRelation = "CDS cos_adresse".cos_adresseId;
        }
        field(44; cos_characteristics; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Merkmal';
            // TableRelation = "CDS cos_characteristic".cos_characteristicId;
        }
        field(45; cos_contact; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Kontakt';
            // TableRelation = "CRM Contact".ContactId;
        }
        field(46; cos_dateofentry; Date)
        {
            Caption = 'Erfassungsdatum';
        }
        field(47; cos_deliveryend; Text[100])
        {

            Caption = 'Lieferende';
        }
        field(48; cos_dismissal; Date)
        {

            Caption = 'Kündigung zum';
        }
        field(49; cos_end; Date)
        {
            Caption = 'Laufzeit Ende';
        }
        field(50; cos_endofdeliveryyear; Text[100])
        {
            Caption = 'Lieferende (Jahr)';
        }
        field(51; cos_LEdateofentry; Date)
        {
            Caption = 'Letzte Auslieferung';
        }
        field(52; cos_order; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Auftrag';
            // TableRelation = "CRM Salesorder".SalesOrderId;
        }
        field(53; cos_orderdate; Date)
        {
            Caption = 'Bestelldatum';
        }
        field(54; cos_OrderID; Text[100])
        {
            Caption = 'Auftrags-ID';
        }
        field(55; cos_reasonfordismissal; Option)
        {
            Caption = 'Kündigungsgrund';
            InitValue = " ";
            OptionMembers = " ",NichtBelegt,AbonnentIstVerstorben,AndererGrund,AnnahmeVerweigert,AnnahmeVerweigertKeineMahnung,AustrittAusVerbandOderVerein,AutomLENachAnzahlGelieferterFolgen,BefristetBeiBestellungMitErinnerungsschreiben,BefristetBeiBestellungOhneErinnerungsschreiben,EmpfaengerwechselDurchKunden,FachinfosAnderweitigBeschafft,Freiabo,FristgerechterWiderruferNO,FZSInhaltlichNichtRelevant,FZSWirdNichtRegelmaessigGelesen,FZSZuTeuer,InterneUmbestellungDurchKunden,InternerTitelwechselDurchKunden,InternerTitelwechselDurchVerlag,ZuVielWerbung,KulanzfallMitBegruendung,KundeBekommtZuVieleGleichartigeFZS,KundeInInkasso,KundeInInsolvenz,KundeIstAnderweitigTaetig,KundeNichtMehrTaetig,KundeStelltBetriebOderBerufstaetigkeitEin,LiefereinstellungNichtzahler,LiefereinstellungNichtzahlerNormalAbo,NichtZuErmitteln,OhneAngabeEinesGrundes,PPVerschoben,StandardLieferendegrund,TiteleinstellungDurchVerlag,UmstellungABOZuABOS,UnbekanntVerzogen,VerbandOderVereinKuendigtSammelbezugsvereinbarung,VerspaeteterWiderruferNOMRechnungsstorno,Verstorben;
        }
        field(57; cos_Reklamation; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Reklamation';
            // TableRelation = "CDS cos_reklamation".cos_reklamationId;
        }
        field(58; cos_shiptoaddress; Text[100])
        {
            // ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lieferadresse';
            // TableRelation = "CDS cos_adresse".cos_adresseId;
        }
        field(59; cos_sparte; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Sparte';
            // TableRelation = "CDS cos_sparten".cos_spartenId;
        }
        field(60; cos_start; Date)
        {
            Caption = 'Laufzeit Start';
        }
        field(61; cos_startofdelivery; Text[100])
        {
            Caption = 'Lieferbeginn';
        }
        field(62; cos_startofdeliveryyear; Text[100])
        {
            Caption = 'Lieferbeginn (Jahr)';
        }
        field(63; cos_status; Option)
        {
            Caption = 'Zustand';
            InitValue = " ";
            OptionMembers = " ",Reklamation;
        }
        field(65; cos_typeofcustomer; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Kundenart';
            // TableRelation = "CDS cos_typeofcustomer".cos_typeofcustomerId;
        }
        field(70; cos_ReklamationName; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("CDS cos_reklamation".cos_name where(cos_reklamationId = field(cos_Reklamation)));
        }
        field(71; cos_billtoaddressName; Text[850])
        {
            caption = 'Rechn. an Name';
        }
        field(72; cos_shiptoaddressName; Text[850])
        {
            Caption = 'Lief. an Name';
        }
        field(77; cos_AdresseName; Text[850])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("CDS cos_adresse".cos_name where(cos_adresseId = field(cos_Adresse)));
        }
        field(78; cos_characteristicsName; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("CDS cos_characteristic".cos_name where(cos_characteristicId = field(cos_characteristics)));
        }
        field(79; cos_typeofcustomerName; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("CDS cos_typeofcustomer".cos_name where(cos_typeofcustomerId = field(cos_typeofcustomer)));
        }
        field(82; cos_sparteName; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("CDS cos_sparten".cos_name where(cos_spartenId = field(cos_sparte)));
        }
        field(83; cos_commentdismissal; BLOB)
        {
            Description = '';
            Caption = 'Kommentar Kündigung';
            Subtype = Memo;
        }
        field(84; cos_dataimport; Text[100])
        {
            Caption = 'Datenimport';
        }
        field(85; cos_shiptocontact; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Lieferung an Kontakt';
            // TableRelation = "CRM Contact".ContactId;
        }
        field(88; cos_orderbycontact; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Bestellt durch Kontakt';
            // TableRelation = "CRM Contact".ContactId;
        }
        field(91; cos_dateofcancellation; Date)
        {
            Description = '';
            Caption = 'Kündigungsdatum';
        }
        field(94; cos_Anrede; Text[100])
        {
            Description = '';
            Caption = 'Anrede';
        }
        field(95; cos_Vorname; Text[100])
        {
            Description = '';
            Caption = 'Vorname';
        }
        field(96; cos_Nachname; Text[100])
        {
            Description = '';
            Caption = 'Nachname';
        }
        field(97; cos_Strae; Text[100])
        {
            Description = '';
            Caption = 'Straße';
        }
        field(98; cos_PLZ; Text[100])
        {
            Description = '';
            Caption = 'PLZ';
        }
        field(99; cos_Ort; Text[100])
        {
            Description = '';
            Caption = 'Ort';
        }
        field(100; cos_Laendercode; Text[100])
        {
            Description = '';
            Caption = 'Ländercode';
        }
        field(101; cos_Menge; Text[100])
        {
            Caption = 'Menge';
        }
        field(102; cos_Strasse2; Text[100])
        {
            Caption = 'Straße 2';
        }
        field(103; cos_Adresszusatz; Text[100])
        {
            Caption = 'Adresszusatz';
        }
        field(104; cos_salutation; Option)
        {
            Caption = 'Anrede 2';
            InitValue = " ";
            OptionMembers = " ",Baron,Botschafter,Botschafterin,Familie,Frau,FrauGeneralkonsulin,"FrauGeneralsekretärin","FrauGeschäftssekretärinA",FrauKonsulin,HerrGeneralkonsul,"HerrGeneralsekretär",HerrGesandter,"HerrGeschäftssekretärA","HerrStatssekretär",Herrn,"Herrn/Frau",Konsul,Rechtsanwalt;
        }
        field(106; cos_grossinvoiceamount; Decimal)
        {
            Caption = 'Faktursummer (brutto)';
        }
        field(107; cos_abo_typ; Option)
        {
            Description = '';
            Caption = 'Abo-Typ Übertrag';
            InitValue = " ";
            OptionMembers = " ","EPaper/Scifo",MitgliedsaboNAMUR,"Buchhandelsabo10%+Individualrabatt10%","Buchhandelsabo15%+Individualrabatt10%",Freiabo,"Buchhandelsabo10%","Buchhandelsabo15%","Buchhandelsabo25%","Buchhandelsabo10%+Individualrabatt20%","Buchhandelsabo10%+Mitgliedsrabatt30%","Buchhandelsabo15%+Mitgliedsrabatt30%","Individualrabatt10%","Individualrabatt20%","Individualrabatt25%","Individualrabatt28%","Individualrabatt35%","Individualrabatt40%","Mitgliedsrabatt30%","Mitgliedsrabatt37%","Studentenabo50%",Normalabo,"Prämienabo",Halbjahresabo;
        }
        field(111; cos_abostatusuebertrag; Option)
        {
            Caption = 'Abostatus Übertrag';
            InitValue = " ";
            OptionMembers = " ",Inaktiv,"AktivOhneTerminkündigung","AktivMitTerminkündigung",InaktivMitTerminzugang;
        }
        field(113; cos_firmenzusatz; Text[100])
        {
            Caption = 'Firmenzusatz';
        }
        field(114; cos_kontaktzusatz; Text[100])
        {
            Description = '';
            Caption = 'Kontaktzusatz';
        }
        field(115; cos_lieferempfaengerkontakt; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Lieferempfänger (Kontakt)';
            // TableRelation = "CRM Contact".ContactId;
        }
        field(116; cos_lieferempfangerfirma; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Lieferempfänger (Firma)';
            // TableRelation = "CRM Account".AccountId;
        }
        field(117; cos_lieferungankunde; Text[100])
        {
            // ExternalType = 'Lookup';
            Caption = 'Lieferung an Kunde';
            // TableRelation = "CRM Account".AccountId;
        }
        field(124; cos_Abonummer; Text[100])
        {
            Description = '';
            Caption = 'Abonummer';
        }
        field(125; cos_lieferbeginn; Date)
        {
            Description = '';
            Caption = 'Lieferbeginn 2';
        }
        field(128; cos_BestellungAbonnementId; Text[100])
        {
            Description = 'Eindeutiger Bezeichner für Bestellung, zugeordnet zu Abonnement.';
            Caption = 'BetsellungAbonnement';
            // TableRelation = "CRM Salesorder".SalesOrderId;
        }
        field(130; cos_AboTypNew; Option)
        {
            Description = '';
            Caption = 'Abo-Typ';
            InitValue = " ";
            OptionMembers = " ","EPaper/Scifo",MitgliedsaboNAMUR,"Buchhandelsabo10%+Individualrabatt10%","Buchhandelsabo15%+Individualrabatt10%",Freiabo,"Buchhandelsabo10%","Buchhandelsabo15%","Buchhandelsabo25%","Buchhandelsabo10%+Individualrabatt20%","Buchhandelsabo10%+Mitgliedsrabatt30%","Buchhandelsabo15%+Mitgliedsrabatt30%","Individualrabatt10%","Individualrabatt20%","Individualrabatt25%","Individualrabatt28%","Individualrabatt35%","Individualrabatt40%","Mitgliedsrabatt30%","Mitgliedsrabatt37%","Studentenabo50%",Normalabo,"Prämienabo",Halbjahresabo,"SmallBusiness/Campus";
        }
        field(133; new_accountguid; Text[50])
        {
            Description = '';
            Caption = 'Firmen GUID';
        }
        field(134; new_customerguid; Text[50])
        {
            Description = 'In diesem Feld steht die GUID des Datensatzes, der über das Feld Lieferung an Kunde gesetzt wurde.';
            Caption = 'Kunden GUID';
        }
        field(136; vv_EMailInvoiceRecipient; Text[100])
        {
            Description = 'Rechnungsempfänger E-Mail';
            Caption = 'Rechnungsempfänger E-Mail';
        }
        field(137; new_abostatus; Option)
        {
            Caption = 'Abostatus (ALT)';
            InitValue = " ";
            OptionMembers = " ",Inaktiv,"AktivOhneTerminkündigung","AktivMitTerminkündigung",InaktivInTerminzugang;
        }
        field(138; new_IhreReferenz; Text[35])
        {
            Caption = 'Ihre Referenz';
        }
        field(139; new_Rabatt; GUID)
        {
            Description = '';
            Caption = 'Rabatt';
            // TableRelation = "CDS cos_rabattkategorien".cos_rabattkategorienId;
        }


        field(60700; AccountName; Text[160])
        {
            // CalcFormula = Lookup("CRM Account".Name WHERE(AccountId = FIELD(cos_account)));
            Caption = 'Firmenname';
            // FieldClass = FlowField;
        }
        field(60701; "AccountNo"; Text[20])
        {
            // CalcFormula = Lookup("CRM Account".new_bccustomerno WHERE(AccountId = FIELD(cos_account)));
            Caption = 'Firmennr.';
            // FieldClass = FlowField;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                CustomerL: Record Customer;
            begin
                if CustomerL.Get(AccountNo) then begin
                    AccountName := CustomerL.Name;
                end;
            end;
        }
        field(60702; "Product Name"; Text[100])
        {
            // CalcFormula = Lookup("CRM Product".Name where(ProductId = field(cos_BasicProduct)));
            Caption = 'Artikelname';
            // FieldClass = FlowField;
        }
        field(60703; "OrderByContactName"; Text[160])
        {
            // CalcFormula = Lookup("CRM Contact".FullName where(ContactId = field(cos_orderbycontact)));
            Caption = 'Kontaktname';
            // FieldClass = FlowField;
        }
        field(60704; "ShipToAccountName"; Text[160])
        {
            // CalcFormula = Lookup("CRM Account".Name where(AccountId = field(cos_lieferungankunde)));
            Caption = 'Lieferung Kundenname';
            // FieldClass = FlowField;
        }
        field(60705; "ShipToContactName"; Text[160])
        {
            // CalcFormula = Lookup("CRM Contact".FullName where(ContactId = field(cos_shiptocontact)));
            Caption = 'Lieferung Kontaktname';
            // FieldClass = FlowField;
        }
        field(60706; "BillingAddresZipCode"; Text[21])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_postalcode where(cos_adresseId = field(cos_billtoaddress)));
            caption = 'Rechn. an PLZ';

            // FieldClass = FlowField;
        }

        field(60707; "BillingAddresCity"; Text[80])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_city where(cos_adresseId = field(cos_billtoaddress)));
            Caption = 'Rechn. an Stadt';

            // FieldClass = FlowField;
        }
        field(60708; "BillingAddresCountry"; Text[100])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_billtoaddress)));
            Caption = 'Rechn. an Land';

            // FieldClass = FlowField;
        }
        field(60709; "ShippingAddresZipCode"; Text[21])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_postalcode where(cos_adresseId = field(cos_shiptoaddress)));
            Caption = 'Lief. an PLZ';

            // FieldClass = FlowField;
        }
        field(60710; "ShippingAddresCity"; Text[80])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_city where(cos_adresseId = field(cos_shiptoaddress)));
            Caption = 'Lief. an Stadt';

            // FieldClass = FlowField;
        }
        field(60711; "ShippingAddresCountry"; Text[100])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_shiptoaddress)));
            Caption = 'Lief. an Land';

            // FieldClass = FlowField;
        }
        field(60712; "OrderByContactFirstName"; Text[50])
        {
            // CalcFormula = Lookup("CRM Contact".FirstName where(AccountId = field(cos_orderbycontact)));
            Caption = 'Kontakt Vorname';

            // FieldClass = FlowField;
        }

        field(60713; "OrderByContactLastName"; Text[50])
        {
            // CalcFormula = Lookup("CRM Contact".LastName where(ContactId = field(cos_orderbycontact)));
            Caption = 'Kontakt Nachname';

            // FieldClass = FlowField;
        }
        field(60714; "OrderByContactBusinessPhone"; Text[50])
        {
            // CalcFormula = Lookup("CRM Contact".Telephone1 where(ContactId = field(cos_orderbycontact)));
            Caption = 'Kontakt Firmentelefonnr.';

            // FieldClass = FlowField;
        }
        field(60715; "OrderByContactMobile"; Text[50])
        {
            // CalcFormula = Lookup("CRM Contact".MobilePhone where(ContactId = field(cos_orderbycontact)));
            Caption = 'Kontakt Handynr.';

            // FieldClass = FlowField;
        }
        field(60716; "OrderByContactEmail"; Text[100])
        {
            // CalcFormula = Lookup("CRM Contact".EMailAddress1 where(ContactId = field(cos_orderbycontact)));
            Caption = 'Kontakt Email';

            // FieldClass = FlowField;
        }
        field(60717; "Product No."; code[20])
        {
            Caption = 'Artikelnr.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(60718; "Last Invoice Date"; Date)
        {
            Caption = 'Letztes Abrechnungsdatum';
            DataClassification = ToBeClassified;
        }
        field(60719; "Error Message"; Text[250])
        {
            Caption = 'Fehlermeldung';
            DataClassification = ToBeClassified;
        }
        field(60720; "Deferral Code"; code[10])
        {
            Caption = 'Abgrenzungscode';
            DataClassification = ToBeClassified;
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(60721; "Next Invoice Date"; Date)
        {
            Caption = 'Nächstes Abrechnungsdatum';
            DataClassification = ToBeClassified;
        }
        field(60725; "ShippingAddresStreet"; Text[100])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_shiptoaddress)));
            Caption = 'Lief. an Adresse';

            // FieldClass = FlowField;
        }
        field(60726; "ShippingAddresStreet2"; Text[50])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_shiptoaddress)));
            Caption = 'Lief. an Adresse 2';

            // FieldClass = FlowField;
        }
        field(60727; "BillingAddresStreet"; Text[100])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_billtoaddress)));
            Caption = 'Rechn. an Adresse';

            // FieldClass = FlowField;
        }
        field(60728; "BillingAddresStreet2"; Text[50])
        {
            // CalcFormula = Lookup("CDS cos_adresse".cos_countrycode where(cos_adresseId = field(cos_billtoaddress)));
            Caption = 'Rechn. an Adresse 2';

            // FieldClass = FlowField;
        }
        field(60749; "Sales Order created at"; DateTime)
        {
            Caption = 'Auftrag erstellt am';
            DataClassification = ToBeClassified;
        }
        field(60750; "Sales Order No."; code[20])
        {
            Caption = 'letzte Verkaufsauftragsnr.';
            DataClassification = ToBeClassified;
        }
        field(60751; "Sales Invoice No."; Integer)
        {
            Caption = 'Verkaufsrechnungen';
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where("Subscription Entry No." = field(cos_abonnementId)));
        }
        field(60760; "BC Status"; enum "Subscription Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(60762; "Process Status"; enum "Subscription Process Status")
        {
            Caption = 'Verarbeitungsstatus';
            DataClassification = ToBeClassified;
        }

        field(60761; "Data Updated"; Boolean)
        {
            Caption = 'Daten aktualisiert';
            DataClassification = ToBeClassified;
        }
        field(60729; "Rabattname"; Text[100])
        {
            Caption = 'Rabattname';
            DataClassification = ToBeClassified;
        }
        field(60730; "Rabatt %"; Decimal)
        {
            Caption = 'Rabatt %';
            DataClassification = ToBeClassified;
        }














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

    trigger OnInsert()
    var
        IssueSetupL: Record "Issue Setup";
    begin
        if IssueSetupL.Get() then
            Rec."Deferral Code" := IssueSetupL."Subscription Deferal Code";

        // FillCRMFields(Rec."Entry No.")
    end;

    procedure FillCRMFields(AboIDV: Guid)
    var
        CRMAccountL: Record "CRM Account";
        CRMProductL: Record "CRM Product";
        CRMContactL: Record "CRM Contact";
        CDScos_adresseL: Record "CDS cos_adresse";
        CDScos_rabattkategorienL: Record "CDS cos_rabattkategorien";
        SubscriptionsL: Record Subscriptions;
        customerL: Record customer;
    begin
        if SubscriptionsL.Get(AboIDV) then begin
            Codeunit.Run(Codeunit::"CRM Integration Management");

            if CRMAccountL.Get(SubscriptionsL.cos_account) then begin
                SubscriptionsL.AccountName := CRMAccountL.Name;
                if customerL.Get(CRMAccountL.new_bccustomerno) then
                    SubscriptionsL.validate(AccountNo, CRMAccountL.new_bccustomerno)
                else begin
                    customerL.SetRange("CRM GUID", CRMAccountL.AccountId);
                    if customerL.FindFirst() then
                        SubscriptionsL.Validate(AccountNo, customerL."No.")
                    else
                        SubscriptionsL.AccountNo := CRMAccountL.new_bccustomerno;
                end;
            end;

            CRMAccountL.Reset();
            if CRMAccountL.get(SubscriptionsL.cos_lieferungankunde) then begin
                SubscriptionsL.ShipToAccountName := CRMAccountL.Name;
            end;

            if CRMProductL.Get(SubscriptionsL.cos_BasicProduct) then begin
                SubscriptionsL."Product Name" := CRMProductL.Name;
                SubscriptionsL."Product No." := CRMProductL.ProductNumber;
            end;

            if CRMContactL.Get(SubscriptionsL.cos_orderbycontact) then begin
                SubscriptionsL.OrderByContactName := CRMContactL.FullName;
            end;

            CRMContactL.Reset();
            if CRMContactL.Get(SubscriptionsL.cos_shiptocontact) then begin
                SubscriptionsL.ShipToContactName := CRMContactL.FullName;
            end;

            if CDScos_adresseL.Get(SubscriptionsL.cos_billtoaddress) then begin
                SubscriptionsL.cos_billtoaddressName := SubscriptionsL.AccountName;
                SubscriptionsL.BillingAddresZipCode := CDScos_adresseL.cos_postalcode;
                SubscriptionsL.BillingAddresCity := CDScos_adresseL.cos_city;
                SubscriptionsL.BillingAddresCountry := CDScos_adresseL.cos_countrycode;
                SubscriptionsL.BillingAddresStreet := CDScos_adresseL.cos_street;
                SubscriptionsL.BillingAddresStreet2 := copystr(SubscriptionsL.cos_firmenzusatz, 1, 50);
            end;
            CDScos_adresseL.Reset();
            if CDScos_adresseL.Get(SubscriptionsL.cos_shiptoaddress) then begin
                SubscriptionsL.cos_shiptoaddressName := SubscriptionsL.ShipToAccountName;
                SubscriptionsL.ShippingAddresZipCode := CDScos_adresseL.cos_postalcode;
                SubscriptionsL.ShippingAddresCity := CDScos_adresseL.cos_city;
                SubscriptionsL.ShippingAddresCountry := CDScos_adresseL.cos_countrycode;
                SubscriptionsL.ShippingAddresStreet := CDScos_adresseL.cos_street;
                SubscriptionsL.ShippingAddresStreet2 := copystr(SubscriptionsL.cos_kontaktzusatz, 1, 50);
            end;

            CRMContactL.Reset();
            if CRMContactL.Get(SubscriptionsL.cos_orderbycontact) then begin
                SubscriptionsL.OrderByContactFirstName := CRMContactL.FirstName;
                SubscriptionsL.OrderByContactLastName := CRMContactL.LastName;
                SubscriptionsL.OrderByContactBusinessPhone := CRMContactL.Telephone1;
                SubscriptionsL.OrderByContactMobile := CRMContactL.MobilePhone;
                SubscriptionsL.OrderByContactEmail := CRMContactL.EMailAddress1;
            end;

            CDScos_rabattkategorienL.Reset();
            if CDScos_rabattkategorienL.Get(SubscriptionsL.new_Rabatt) then begin
                SubscriptionsL.Rabattname := CDScos_rabattkategorienL.cos_name;
                SubscriptionsL."Rabatt %" := CDScos_rabattkategorienL.cos_rabatt;
            end;

            SubscriptionsL."Data Updated" := true;
            SubscriptionsL.modify();
        end;

    end;
}