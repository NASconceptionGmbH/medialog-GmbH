table 60708 "Shipping Addresses"
{
    DataClassification = ToBeClassified;
    Caption = 'Versandadressen';

    fields
    {
        field(1; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Debitor Nr.';
            trigger
            OnValidate()
            var
                CustomerL: Record Customer;
            begin
                If CustomerL.get("Customer No.") then begin
                    Name := CustomerL.Name;
                    "Name 2" := CustomerL."Name 2";
                    Address := CustomerL.Address;
                    "Address 2" := CustomerL."Address 2";
                    "Post Code" := CustomerL."Post Code";
                    City := CustomerL.City;
                    "Country/Region" := CustomerL."Country/Region Code";
                    Contact := CustomerL.Contact;
                end
            end;
        }
        field(4; "Name"; Text[100])
        {

            DataClassification = ToBeClassified;
        }
        field(5; "Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Address"; Text[100])
        {
            Caption = 'Adresse';
            DataClassification = ToBeClassified;
        }
        field(7; "Address 2"; Text[100])
        {
            Caption = 'Adresse 2';
            DataClassification = ToBeClassified;
        }
        field(8; City; Text[100])
        {
            Caption = 'Stadt';
            DataClassification = ToBeClassified;
        }
        field(9; "Post Code"; Code[50])
        {
            Caption = 'PLZ';
            DataClassification = ToBeClassified;
        }
        field(10; "Country/Region"; Text[100])
        {
            Caption = 'Länder/Regionscode';
            DataClassification = ToBeClassified;
        }
        field(11; "Contact"; Text[100])
        {
            Caption = 'Kontakt';
            DataClassification = ToBeClassified;
        }
        field(12; "Number"; Integer)
        {
            Caption = 'Anzahl';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Pk; "Sales Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}