tableextension 60712 "CDSAccountExt" extends "CRM Account"
{
    Description = 'Ein Geschäft, das einen Kunden oder einen potenziellen Kunden darstellt. Das Unternehmen, mit dem Geschäftstransaktionen abgerechnet werden.';

    fields
    {
        field(60223; TimeSpentByMeOnEmailAndMeetings; Text[1250])
        {
            ExternalName = 'timespentbymeonemailandmeetings';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Von mir aufgewendete Gesamtzeit für E-Mails (lesen und schreiben) und Meetings in Bezug auf den Firmendatensatz';
            Caption = 'Von mir aufgewendete Zeit';
        }
        field(60236; PrimarySatoriId; Text[200])
        {
            ExternalName = 'primarysatoriid';
            ExternalType = 'String';
            Description = 'Primäre Satori-ID für die Firma';
            Caption = 'Primäre Satori-ID';
        }
        field(60237; PrimaryTwitterId; Text[128])
        {
            ExternalName = 'primarytwitterid';
            ExternalType = 'String';
            Description = 'Primäre Twitter-ID für die Firma';
            Caption = 'Primäre Twitter-ID';
        }
        field(60241; OnHoldTime; Integer)
        {
            ExternalName = 'onholdtime';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Die Dauer der Zurückstellung des Datensatzes in Minuten.';
            Caption = 'Zeit der Zurückstellung (Minuten)';
        }
        field(60242; LastOnHoldTime; Datetime)
        {
            ExternalName = 'lastonholdtime';
            ExternalType = 'DateTime';
            Description = 'Enthält den Datums- und Zeitstempel der letzten Zurückstellungszeit.';
            Caption = 'Letzte Zeit der Zurückstellung';
        }
        field(60244; FollowEmail; Boolean)
        {
            ExternalName = 'followemail';
            ExternalType = 'Boolean';
            Description = 'Informationen darüber, ob das Verfolgen der E-Mail-Aktivität wie öffnen, Anhänge anzeigen und auf Links für E-Mails, die an das Konto gesendet wurden, klicken erlaubt ist.';
            Caption = 'E-Mail-Aktivität folgen';
        }
        field(60247; MarketingOnly; Boolean)
        {
            ExternalName = 'marketingonly';
            ExternalType = 'Boolean';
            Description = 'Gibt an, ob es nur zum Marketing dient.';
            Caption = 'Nur Marketing';
        }
        field(60018; TeamsFollowed; Integer)
        {
            ExternalName = 'teamsfollowed';
            ExternalType = 'Integer';
            Description = 'Die Anzahl der Benutzer oder Unterhaltungen, die dem Datensatz folgen';
            Caption = 'TeamsFollowed';
        }
        field(60021; cos_a_id; Text[100])
        {
            ExternalName = 'cos_a_id';
            ExternalType = 'String';
            Description = '';
            Caption = 'A_ID';
        }
        field(60022; cos_additionaladdress; Text[100])
        {
            ExternalName = 'cos_additionaladdress';
            ExternalType = 'String';
            Description = '';
            Caption = 'Adresszusatz';
        }
        field(60023; cos_AGpartnernumber; Text[100])
        {
            ExternalName = 'cos_agpartnernumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'AG Geschäftspartner-Nr.';
        }
        field(60025; cos_datasource; Text[100])
        {
            ExternalName = 'cos_datasource';
            ExternalType = 'String';
            Description = '';
            Caption = 'Datenquelle';
        }
        field(60026; cos_housenumber; Text[100])
        {
            ExternalName = 'cos_housenumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'Hausnummer';
        }
        field(60027; cos_IDCVK; Text[100])
        {
            ExternalName = 'cos_idcvk';
            ExternalType = 'String';
            Description = '';
            Caption = 'Kundennummer CVK';
        }
        field(60028; cos_IDMediasuite; Text[100])
        {
            ExternalName = 'cos_idmediasuite';
            ExternalType = 'String';
            Description = '';
            Caption = 'Kundennummer Mediasuite';
        }
        field(60029; cos_IDPhiatos; Text[100])
        {
            ExternalName = 'cos_idphiatos';
            ExternalType = 'String';
            Description = '';
            Caption = 'Kundennummer Phiatos';
        }
        field(60031; cos_n_id; Text[100])
        {
            ExternalName = 'cos_n_id';
            ExternalType = 'String';
            Description = '';
            Caption = 'N_ID';
        }
        field(60032; cos_revenuetotal; Decimal)
        {
            ExternalName = 'cos_revenuetotal';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Gesamtumsatz';
        }
        field(60033; cos_revenuetotal_Base; Decimal)
        {
            ExternalName = 'cos_revenuetotal_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Wert von ''Gesamtumsatz'' in der Basiswährung.';
            Caption = '''Gesamtumsatz'' (Basis)';
        }
        field(60034; cos_salutation; Option)
        {
            ExternalName = 'cos_salutation';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Anrede';
            InitValue = " ";
            OptionMembers = " ",Baron,Botschafter,Botschafterin,Familie,Frau,FrauGeneralkonsulin,"FrauGeneralsekretärin","FrauGeschäftsträgerinA",FrauKonsulin,HerrGeneralkonsul,"HerrGeneralsekretär",HerrGesandter,"HerrGeschäftsträgerA","HerrStatssekretär",Herrn,"Herrn/Frau",Konsul,Rechtsanwalt,FrauMontag,FrauPeter,FrauTot,"RHerrDr.Klank",RHerrRichter;
            OptionOrdinalValues = -1, 181510000, 181510001, 181510002, 181510003, 181510004, 181510005, 181510006, 181510007, 181510008, 181510009, 181510010, 181510011, 181510012, 181510013, 181510014, 181510015, 181510016, 181510017, 100000000, 100000001, 100000002, 100000003, 100000004;
        }
        field(60036; cos_street; Text[100])
        {
            ExternalName = 'cos_street';
            ExternalType = 'String';
            Description = '';
            Caption = 'Straße';
        }
        field(60037; cos_typeofaccount; Boolean)
        {
            ExternalName = 'cos_typeofaccount';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Firmenart';
        }
        field(60041; cos_dataimport; Text[100])
        {
            ExternalName = 'cos_dataimport';
            ExternalType = 'String';
            Description = '';
            Caption = 'Datenimport';
        }
        field(60044; cos_streuversand; Boolean)
        {
            ExternalName = 'cos_streuversand';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Streu- und Wechselversand';
        }
        field(60046; cos_TM; Boolean)
        {
            ExternalName = 'cos_tm';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'TM';
        }
        field(60048; cos_control; Boolean)
        {
            ExternalName = 'cos_control';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Kontrolle';
        }
        field(60050; cos_Events; Boolean)
        {
            ExternalName = 'cos_events';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Events';
        }
        field(60053; cos_phiatos_artikel; BLOB)
        {
            ExternalName = 'cos_phiatos_artikel';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Phiatos_Artikel';
            Subtype = Memo;
        }
        field(60054; cos_Kundennummer; Text[100])
        {
            ExternalName = 'cos_kundennummer';
            ExternalType = 'String';
            Description = '';
            Caption = 'Kundennummer';
        }
        field(60055; cos_firmenzusatz; Text[100])
        {
            ExternalName = 'cos_firmenzusatz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Firmenzusatz';
        }
        field(60056; cos_firma1; Text[100])
        {
            ExternalName = 'cos_firma1';
            ExternalType = 'String';
            Description = '';
            Caption = 'Firma 1';
        }
        field(60057; cos_firma2; Text[100])
        {
            ExternalName = 'cos_firma2';
            ExternalType = 'String';
            Description = '';
            Caption = 'Firma 2';
        }
        field(60058; cos_Firma3; Text[100])
        {
            ExternalName = 'cos_firma3';
            ExternalType = 'String';
            Description = '';
            Caption = 'Firma 3';
        }
        field(60065; new_bccustomerno; Text[20])
        {
            ExternalName = 'new_bccustomerno';
            ExternalType = 'String';
            Description = '';
            Caption = 'BC Debitor Nr.';
        }
        field(60066; vv_id_location; Text[100])
        {
            ExternalName = 'vv_id_location';
            ExternalType = 'String';
            Description = '';
            Caption = 'Adresse ID';
        }
        field(60067; vv_idjuristicperson; Text[100])
        {
            ExternalName = 'vv_idjuristicperson';
            ExternalType = 'String';
            Description = '';
            Caption = 'Juristische Person ID';
        }
    }
}