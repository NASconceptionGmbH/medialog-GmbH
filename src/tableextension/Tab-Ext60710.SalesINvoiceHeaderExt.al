tableextension 60710 "SalesINvoiceHeaderExt" extends "Sales Invoice Header"
{
    fields
    {
        field(60705; "Ship-To Customer No."; Code[20])
        {
            Caption = 'Lief. an Debitor Nr.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(60700; "Document Sending Profile"; Code[20])
        {
            Caption = 'Belegsendeprofil';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Document Sending Profile" where("No." = field("Sell-to Customer No.")));
        }
        // field(60706; "CRM Guid"; GUID)
        // {
        //     Caption = 'CRM Guid';
        //     DataClassification = ToBeClassified;
        // }
        // field(60707; "CRM Invoice Synced"; Boolean)
        // {
        //     Caption = 'Invoice Synced to CRM';
        //     DataClassification = ToBeClassified;
        // }

        // field(60708; "CRM Invoice Linked"; Boolean)
        // {
        //     Caption = 'Invoice Linked in CRM';
        //     DataClassification = ToBeClassified;
        // }
        field(60707; "Clerk"; Code[20])
        {
            Caption = 'Sachbearbeiter';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60702; "Salesperson Code 2"; Code[20])
        {
            Caption = 'Verkäufercode 2';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin
                IF SalespersonPurchaserL.Get("Salesperson Code") then
                    "Commission Salesperson 2" := SalespersonPurchaserL."Commission %"
                else
                    "Commission Salesperson 2" := 0;
            end;
        }
        field(60703; "Commission Salesperson"; Decimal)
        {
            Caption = 'Provision Verkäufer';
            DataClassification = ToBeClassified;
        }
        field(60704; "Commission Salesperson 2"; Decimal)
        {
            Caption = 'Provision Verkäufer 2';
            DataClassification = ToBeClassified;
        }
        field(60706; "Is Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60711; "Imported"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60712; "Automated Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // field(60713; "Report URL"; Text[50])
        // {
        //     Caption = 'Report Url';
        //     DataClassification = ToBeClassified;
        // }
        // field(60714; "Report URL Text"; Text[50])
        // {
        //     Caption = 'Report Url Text';
        //     DataClassification = ToBeClassified;
        // }
        field(60713; "Subscription No."; text[50])
        {
            Caption = 'Abonummer ';
            DataClassification = ToBeClassified;
        }
        field(60714; "Subscription Order"; Boolean)
        {
            Caption = 'Abo Auftrag';
            DataClassification = ToBeClassified;
        }
        field(60720; "Subscription Email Sent"; Boolean)
        {
            Caption = 'Abo Mail versendet';
            DataClassification = ToBeClassified;
        }
        field(60721; "Subscription Email Error"; text[250])
        {
            Caption = 'Abo Mail Fehlertext';
            DataClassification = ToBeClassified;
        }
        field(60715; "Subscription Entry No."; Guid)
        {
            Caption = 'Abo Guid';
            DataClassification = ToBeClassified;
        }
        field(60717; "Annual Invoice Mark"; Code[16])
        {
            Caption = 'Jahresfaktur Kennzeichen';
            DataClassification = ToBeClassified;
        }


    }
}