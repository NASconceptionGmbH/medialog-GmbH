// tableextension 60712 CDSAccountExt extends "CRM Account"
// {
//   Description = 'Ein Geschäft, das einen Kunden oder einen potenziellen Kunden darstellt. Das Unternehmen, mit dem Geschäftstransaktionen abgerechnet werden.';

//   fields
//   {
//     field(223; TimeSpentByMeOnEmailAndMeetings; Text[1250])
//     {
//       ExternalName = 'timespentbymeonemailandmeetings';
//       ExternalType = 'String';
//       ExternalAccess = Read;
//       Description = 'Von mir aufgewendete Gesamtzeit für E-Mails (lesen und schreiben) und Meetings in Bezug auf den Firmendatensatz';
//       Caption = 'Von mir aufgewendete Zeit';
//     }
//     field(236; PrimarySatoriId; Text[200])
//     {
//       ExternalName = 'primarysatoriid';
//       ExternalType = 'String';
//       Description = 'Primäre Satori-ID für die Firma';
//       Caption = 'Primäre Satori-ID';
//     }
//     field(237; PrimaryTwitterId; Text[128])
//     {
//       ExternalName = 'primarytwitterid';
//       ExternalType = 'String';
//       Description = 'Primäre Twitter-ID für die Firma';
//       Caption = 'Primäre Twitter-ID';
//     }
//     field(241; OnHoldTime; Integer)
//     {
//       ExternalName = 'onholdtime';
//       ExternalType = 'Integer';
//       ExternalAccess = Read;
//       Description = 'Die Dauer der Zurückstellung des Datensatzes in Minuten.';
//       Caption = 'Zeit der Zurückstellung (Minuten)';
//     }
//     field(242; LastOnHoldTime; Datetime)
//     {
//       ExternalName = 'lastonholdtime';
//       ExternalType = 'DateTime';
//       Description = 'Enthält den Datums- und Zeitstempel der letzten Zurückstellungszeit.';
//       Caption = 'Letzte Zeit der Zurückstellung';
//     }
//     field(244; FollowEmail; Boolean)
//     {
//       ExternalName = 'followemail';
//       ExternalType = 'Boolean';
//       Description = 'Informationen darüber, ob das Verfolgen der E-Mail-Aktivität wie öffnen, Anhänge anzeigen und auf Links für E-Mails, die an das Konto gesendet wurden, klicken erlaubt ist.';
//       Caption = 'E-Mail-Aktivität folgen';
//     }
//     field(247; MarketingOnly; Boolean)
//     {
//       ExternalName = 'marketingonly';
//       ExternalType = 'Boolean';
//       Description = 'Gibt an, ob es nur zum Marketing dient.';
//       Caption = 'Nur Marketing';
//     }
//     field(10001; Adx_CreatedByIPAddress; Text[100])
//     {
//       ExternalName = 'adx_createdbyipaddress';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Created By (IP Address)';
//     }
//     field(10002; Adx_CreatedByUsername; Text[100])
//     {
//       ExternalName = 'adx_createdbyusername';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Created By (User Name)';
//     }
//     field(10003; Adx_ModifiedByIPAddress; Text[100])
//     {
//       ExternalName = 'adx_modifiedbyipaddress';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Modified By (IP Address)';
//     }
//     field(10004; Adx_ModifiedByUsername; Text[100])
//     {
//       ExternalName = 'adx_modifiedbyusername';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Modified By (User Name)';
//     }
//     field(10005; msa_managingpartnerid; GUID)
//     {
//       ExternalName = 'msa_managingpartnerid';
//       ExternalType = 'Lookup';
//       Description = 'Unique identifier for Account associated with Account.';
//       Caption = 'Managing Partner';
//       TableRelation = "CRM Account".AccountId;
//     }
//     field(10017; msdyn_PrimaryTimeZone; Integer)
//     {
//       ExternalName = 'msdyn_primarytimezone';
//       ExternalType = 'Integer';
//       Description = 'Gibt die primäre Zeitzone an, in der der Client arbeitet.';
//       Caption = 'Primäre Zeitzone';
//     }
//     field(10027; TeamsFollowed; Integer)
//     {
//       ExternalName = 'teamsfollowed';
//       ExternalType = 'Integer';
//       Description = 'Die Anzahl der Benutzer oder Unterhaltungen, die dem Datensatz folgen';
//       Caption = 'TeamsFollowed';
//     }
//     field(10030; msdyn_gdproptout; Boolean)
//     {
//       ExternalName = 'msdyn_gdproptout';
//       ExternalType = 'Boolean';
//       Description = 'Beschreibt, ob Konto ausgeschlossen ist oder nicht';
//       Caption = 'GDPR-Kündigung';
//     }
//     field(10036; cos_a_id; Text[100])
//     {
//       ExternalName = 'cos_a_id';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'A_ID';
//     }
//     field(10037; cos_additionaladdress; Text[100])
//     {
//       ExternalName = 'cos_additionaladdress';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Adresszusatz';
//     }
//     field(10038; cos_AGpartnernumber; Text[100])
//     {
//       ExternalName = 'cos_agpartnernumber';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'AG Geschäftspartner-Nr.';
//     }
//     field(10039; cos_control; Boolean)
//     {
//       ExternalName = 'cos_control';
//       ExternalType = 'Boolean';
//       Description = '';
//       Caption = 'Kontrolle';
//     }
//     field(10042; cos_dataimport; Text[100])
//     {
//       ExternalName = 'cos_dataimport';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Datenimport';
//     }
//     field(10043; cos_datasource; Text[100])
//     {
//       ExternalName = 'cos_datasource';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Datenquelle';
//     }
//     field(10044; cos_Events; Boolean)
//     {
//       ExternalName = 'cos_events';
//       ExternalType = 'Boolean';
//       Description = '';
//       Caption = 'Events';
//     }
//     field(10046; cos_firma1; Text[100])
//     {
//       ExternalName = 'cos_firma1';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Firma 1';
//     }
//     field(10047; cos_firma2; Text[100])
//     {
//       ExternalName = 'cos_firma2';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Firma 2';
//     }
//     field(10048; cos_Firma3; Text[100])
//     {
//       ExternalName = 'cos_firma3';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Firma 3';
//     }
//     field(10049; cos_firmenzusatz; Text[100])
//     {
//       ExternalName = 'cos_firmenzusatz';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Firmenzusatz';
//     }
//     field(10050; cos_housenumber; Text[100])
//     {
//       ExternalName = 'cos_housenumber';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Hausnummer';
//     }
//     field(10051; cos_IDCVK; Text[100])
//     {
//       ExternalName = 'cos_idcvk';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Kundennummer CVK';
//     }
//     field(10052; cos_IDMediasuite; Text[100])
//     {
//       ExternalName = 'cos_idmediasuite';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Kundennummer Mediasuite';
//     }
//     field(10053; cos_IDPhiatos; Text[100])
//     {
//       ExternalName = 'cos_idphiatos';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Kundennummer Phiatos';
//     }
//     field(10054; cos_Kundennummer; Text[100])
//     {
//       ExternalName = 'cos_kundennummer';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Kundennummer';
//     }
//     field(10055; cos_mainaddress; GUID)
//     {
//       ExternalName = 'cos_mainaddress';
//       ExternalType = 'Lookup';
//       Description = '';
//       Caption = 'Hauptadresse';
//       TableRelation = "CDS cos_adresse".cos_adresseId;
//     }
//     field(10056; cos_n_id; Text[100])
//     {
//       ExternalName = 'cos_n_id';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'N_ID';
//     }
//     field(10057; cos_phiatos_artikel; BLOB)
//     {
//       ExternalName = 'cos_phiatos_artikel';
//       ExternalType = 'Memo';
//       Description = '';
//       Caption = 'Phiatos_Artikel';
//       Subtype = Memo;
//     }
//     field(10058; cos_revenuetotal; Decimal)
//     {
//       ExternalName = 'cos_revenuetotal';
//       ExternalType = 'Money';
//       Description = '';
//       Caption = 'Gesamtumsatz';
//     }
//     field(10059; cos_revenuetotal_Base; Decimal)
//     {
//       ExternalName = 'cos_revenuetotal_base';
//       ExternalType = 'Money';
//       ExternalAccess = Read;
//       Description = 'Wert von ''Gesamtumsatz'' in der Basiswährung.';
//       Caption = '''Gesamtumsatz'' (Basis)';
//     }
//     field(10060; cos_salutation; Option)
//     {
//       ExternalName = 'cos_salutation';
//       ExternalType = 'Picklist';
//       Description = '';
//       Caption = 'Anrede';
//       InitValue = " ";
//       OptionMembers = " ", Baron, Botschafter, Botschafterin, Familie, Frau, FrauGeneralkonsulin, "FrauGeneralsekretärin", "FrauGeschäftsträgerinA", FrauKonsulin, HerrGeneralkonsul, "HerrGeneralsekretär", HerrGesandter, "HerrGeschäftsträgerA", "HerrStatssekretär", Herrn, "Herrn/Frau", Konsul, Rechtsanwalt, FrauMontag, FrauPeter, FrauTot, "RHerrDr.Klank", RHerrRichter;
//       OptionOrdinalValues = -1, 181510000, 181510001, 181510002, 181510003, 181510004, 181510005, 181510006, 181510007, 181510008, 181510009, 181510010, 181510011, 181510012, 181510013, 181510014, 181510015, 181510016, 181510017, 100000000, 100000001, 100000002, 100000003, 100000004;
//     }
//     field(10062; cos_street; Text[100])
//     {
//       ExternalName = 'cos_street';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Straße';
//     }
//     field(10063; cos_streuversand; Boolean)
//     {
//       ExternalName = 'cos_streuversand';
//       ExternalType = 'Boolean';
//       Description = '';
//       Caption = 'Streu- und Wechselversand';
//     }
//     field(10065; cos_TM; Boolean)
//     {
//       ExternalName = 'cos_tm';
//       ExternalType = 'Boolean';
//       Description = '';
//       Caption = 'TM';
//     }
//     field(10067; cos_typeofaccount; Boolean)
//     {
//       ExternalName = 'cos_typeofaccount';
//       ExternalType = 'Boolean';
//       Description = '';
//       Caption = 'Firmenart';
//     }
//     field(10070; new_bccustomerno; Text[20])
//     {
//       ExternalName = 'new_bccustomerno';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'BC Debitor Nr.';
//     }
//     field(10071; new_totalrevenueupdated; Date)
//     {
//       ExternalName = 'new_totalrevenueupdated';
//       ExternalType = 'DateTime';
//       Description = '';
//       Caption = 'Gesamtumsatz aktualisiert am';
//     }
//     field(10075; vv_id_location; Text[100])
//     {
//       ExternalName = 'vv_id_location';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Adresse ID';
//     }
//     field(10076; vv_idjuristicperson; Text[100])
//     {
//       ExternalName = 'vv_idjuristicperson';
//       ExternalType = 'String';
//       Description = '';
//       Caption = 'Juristische Person ID';
//     }
//     field(10077; vv_customermark; Option)
//     {
//       ExternalName = 'vv_customermark';
//       ExternalType = 'Picklist';
//       Description = '';
//       Caption = 'Kundenkennzeichen';
//       InitValue = " ";
//       OptionMembers = " ", Standard, Buchhandel, "Verbund.Unternehmen";
//       OptionOrdinalValues = -1, 772500000, 772500001, 772500002;
//     }
//     field(10079; vv_customertype; Option)
//     {
//       ExternalName = 'vv_customertype';
//       ExternalType = 'Picklist';
//       Description = '';
//       Caption = 'Kundentyp';
//       InitValue = " ";
//       OptionMembers = " ", Standard, Buchhandel, Agentur;
//       OptionOrdinalValues = -1, 772500000, 772500001, 772500002;
//     }
//   }
// }