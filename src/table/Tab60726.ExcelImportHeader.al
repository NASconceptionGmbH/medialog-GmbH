table 60726 "Excel Import Header"
{
    Caption = 'Excel Sent Email Import';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Reference';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "id_juristic_person"; Text[50])
        {
            Caption = 'id_juristic_person';
            DataClassification = ToBeClassified;
        }
        field(3; "Debitorennr"; Code[20])
        {
            Caption = 'Debitorennr';
            DataClassification = ToBeClassified;
        }
        field(4; "customer_id"; Text[50])
        {
            Caption = 'customer_id';
            DataClassification = ToBeClassified;
        }
        field(5; "customer_type"; text[30])
        {
            Caption = 'customer_type';
            DataClassification = ToBeClassified;
        }

        field(6; "Gesperrt"; Code[1])
        {
            Caption = 'Gesperrt';
            DataClassification = ToBeClassified;
        }
        field(7; "SEPA Abo"; COde[1])
        {
            Caption = 'SEPA Abo';
            DataClassification = ToBeClassified;
        }
        field(8; "Zahlungsformcode SEPA ABO"; code[20])
        {
            Caption = 'Zahlungsformcode SEPA ABO';
            DataClassification = ToBeClassified;
        }
        field(9; "SEPA allgemein"; Code[1])
        {
            Caption = 'SEPA allgemein';
            DataClassification = ToBeClassified;
        }
        field(10; "Zahlungsformcode SEPA allg"; Code[20])
        {
            Caption = 'Zahlungsformcode SEPA allg';
            DataClassification = ToBeClassified;
        }
        field(11; "Belegsendeprofil ABO"; code[20])
        {
            Caption = 'Belegsendeprofil ABO';
            DataClassification = ToBeClassified;
        }
        field(12; "Zahlungsbedingungscode"; code[20])
        {
            Caption = 'Zahlungsbedingungscode';
            DataClassification = ToBeClassified;
        }
        field(13; "adv_zahlungsziel"; text[30])
        {
            Caption = 'adv_zahlungsziel';
            DataClassification = ToBeClassified;
        }
        field(14; "anz_e_invoice"; code[1])
        {
            Caption = 'anz_e_invoice';
            DataClassification = ToBeClassified;
        }
        field(15; "Belegsendeprofil Allgemein"; code[20])
        {
            Caption = 'Belegsendeprofil Allgemein';
            DataClassification = ToBeClassified;
        }
        field(20; "processed"; Boolean)
        {
            Caption = 'processed';
            DataClassification = ToBeClassified;
        }
        field(21; "error"; text[250])
        {
            Caption = 'error';
            DataClassification = ToBeClassified;
        }





    }

    keys
    {
        key(pk; "Entry No")
        {
        }
    }
}