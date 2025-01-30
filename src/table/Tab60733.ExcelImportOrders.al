table 60733 "Excel Import Orders"
{
    Caption = 'Excel Sent Orders';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Artikelnr."; code[20])
        {
            Caption = 'Artikelnr.';
            DataClassification = ToBeClassified;
        }
        field(3; "Variantencode"; code[20])
        {
            Caption = 'Variantencode';
            DataClassification = ToBeClassified;
        }
        field(4; "order no"; code[20])
        {
            Caption = 'order no';
            DataClassification = ToBeClassified;
        }

        field(5; "Auftragsdatum"; Date)
        {
            Caption = 'Auftragsdatum';
            DataClassification = ToBeClassified;
        }
        field(6; "Ihre Referenz"; Text[50])
        {
            Caption = 'Ihre Referenz';
            DataClassification = ToBeClassified;
        }
        field(7; "order_state"; text[100])
        {
            Caption = 'order_state';
            DataClassification = ToBeClassified;
        }
        field(8; "Debitor"; Code[20])
        {
            Caption = 'Debitor';
            DataClassification = ToBeClassified;
        }
        field(9; "Debitor Kontakt"; text[100])
        {
            Caption = 'Debitor Kontakt';
            DataClassification = ToBeClassified;
        }
        field(10; "Liefern an Debitor"; Code[20])
        {
            Caption = 'Liefern an Debitor';
            DataClassification = ToBeClassified;
        }
        field(11; "Liefern an Kontakt"; text[100])
        {
            Caption = 'Liefern an Kontakt';
            DataClassification = ToBeClassified;
        }
        field(12; "interfall_sammelrechnung"; text[50])
        {
            Caption = 'interfall_sammelrechnung';
            DataClassification = ToBeClassified;
        }
        field(13; "Zahlungsbedingung"; code[20])
        {
            Caption = 'Zahlungsbedingung';
            DataClassification = ToBeClassified;
        }
        field(14; "Belegsendeprofil"; code[20])
        {
            Caption = 'Belegsendeprofil';
            DataClassification = ToBeClassified;
        }
        field(15; "Email Rechnung"; text[250])
        {
            Caption = 'Email Rechnung';
            DataClassification = ToBeClassified;
        }
        field(16; "Debitor Kontakt Email"; Text[250])
        {
            Caption = 'Debitor Kontakt Email';
            DataClassification = ToBeClassified;
        }
        field(17; "Email Agenturen Rechnung"; Text[250])
        {
            Caption = 'Email Agenturen Rechnung';
            DataClassification = ToBeClassified;
        }

        field(18; "Buchungsdatum"; Date)
        {
            Caption = 'Buchungsdatum';
            DataClassification = ToBeClassified;
        }
        field(19; "Platzierung"; Text[200])
        {
            Caption = 'Platzierung';
            DataClassification = ToBeClassified;
        }
        field(20; "Zusatzzeile"; Text[1024])
        {
            Caption = 'Zusatzzeile';
            DataClassification = ToBeClassified;
        }
        field(21; "Externe Belegnummer"; Code[250])
        {
            Caption = 'Externe Belegnummer';
            DataClassification = ToBeClassified;
        }
        field(22; "Zeilenrabatt"; Decimal)
        {
            Caption = 'Zeilenrabatt';
            DataClassification = ToBeClassified;
        }
        field(23; "Rabatt Betrag"; Decimal)
        {
            Caption = 'Rabatt Betrag';
            DataClassification = ToBeClassified;
        }
        field(24; "VK Netto"; Decimal)
        {
            Caption = 'VK Netto';
            DataClassification = ToBeClassified;
        }
        field(25; "Zeilen Netto"; Decimal)
        {
            Caption = 'Zeilen Netto';
            DataClassification = ToBeClassified;
        }
        field(26; "MwSt"; Decimal)
        {
            Caption = 'MwSt';
            DataClassification = ToBeClassified;
        }
        field(27; "Rechnungsrabatt"; Decimal)
        {
            Caption = 'Rechnungsrabatt';
            DataClassification = ToBeClassified;
        }

        field(31; "schaltung_state"; text[150])
        {
            Caption = 'schaltung';
            DataClassification = ToBeClassified;
        }











        field(28; "processed"; Boolean)
        {
            Caption = 'processed';
            DataClassification = ToBeClassified;
        }
        field(29; "error"; text[250])
        {
            Caption = 'error';
            DataClassification = ToBeClassified;
        }
        field(30; "BC Order No."; code[20])
        {
            Caption = 'BC Order No.';
            DataClassification = ToBeClassified;
        }






    }

    keys
    {
        key(pk; "Entry No")
        {
        }
        key(orderno; "order no")
        {

        }
    }
}