tableextension 60702 "Sales Header" extends "Sales Header"
{
    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                CUstomerL: Record CUstomer;
            begin
                if CUstomerL.Get("Sell-to Customer No.") then
                    "Customer CRM GUID" := CUstomerL."CRM GUID";
            end;
        }

        modify("Salesperson Code")
        {
            trigger
            OnAfterValidate()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";

            begin
                IF SalespersonPurchaserL.Get("Salesperson Code") then
                    Validate("Commission Salesperson", SalespersonPurchaserL."Commission %")
                else
                    Validate("Commission Salesperson", 0);

            end;
        }
        field(60701; "Document Sending Profile"; Code[50])
        {

            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Document Sending Profile" where("No." = field("Sell-to Customer No.")));
            Editable = false;
        }
        field(60700; "Issue Posting Date"; Boolean)
        {
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
                    Validate("Commission Salesperson 2", SalespersonPurchaserL."Commission %")
                else
                    Validate("Commission Salesperson 2", 0);

            end;
        }
        field(60703; "Commission Salesperson"; Decimal)
        {
            Caption = 'Provision Verkäufer';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                IssueAdL.SetRange("Sales Order No.", "No.");
                IF IssueAdL.FindSet() then
                    repeat
                        IssueAdL."Sales Person Code" := Rec."Salesperson Code";
                        IssueAdL.CalcCommission(IssueAdL."Line Amount Excl. VAT", Rec."Commission Salesperson");
                        IssueAdL.Modify(true);
                    until IssueAdL.Next() = 0;
            end;
        }
        field(60704; "Commission Salesperson 2"; Decimal)
        {
            Caption = 'Provision Verkäufer 2';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                IssueAdL.SetRange("Sales Order No.", "No.");
                IF IssueAdL.FindSet() then
                    repeat
                        IssueAdL."Salesperson 2" := Rec."Salesperson Code 2";
                        IssueAdL.CalcCommission(IssueAdL."Line Amount Excl. VAT", Rec."Commission Salesperson 2");
                        IssueAdL.Modify(true);
                    until IssueAdL.Next() = 0;
            end;
        }
        // Add changes to table fields here
        field(60705; "Ship-To Customer No."; Code[20])
        {
            Caption = 'Ship-To Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                CustomerL: Record Customer;
                IssueAdL: Record "Issue Ad";
            begin
                if CustomerL.Get(Rec."Ship-To Customer No.") then begin
                    Validate("Ship-to Code", '');
                    "Ship-to Address" := CustomerL.Address;
                    "Ship-to Address 2" := CustomerL."Address 2";
                    "Ship-to City" := CustomerL.City;
                    "Ship-to Contact" := CustomerL.Contact;
                    Validate("Ship-to Country/Region Code", CustomerL."Country/Region Code");
                    "Ship-to County" := CustomerL.County;
                    "Ship-to Name" := CustomerL.Name;
                    "Ship-to Name 2" := CustomerL."Name 2";
                    "Ship-to Post Code" := CustomerL."Post Code";


                    IssueAdL.SetRange("Sales Order No.", "No.");
                    IF IssueAdL.FindSet() then
                        repeat
                            IssueAdL."Ship-to Customer No." := Rec."Ship-To Customer No.";
                            IssueAdL."Ship-to Name" := Rec."Ship-to Name";
                            IssueAdL.Modify(true);
                        until IssueAdL.Next() = 0;

                end;
            end;
        }
        field(60706; "Is Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60710; "Customer CRM GUID"; Guid)
        {
            Caption = 'Customer CRM GUID';
            DataClassification = ToBeClassified;
        }
        field(60708; "CRM Order ID"; Guid)
        {
            Caption = 'CRM Order ID';
            DataClassification = ToBeClassified;
        }


        field(60707; "Clerk"; Code[20])
        {
            Caption = 'Sachbearbeiter';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                IssueAdL.SetRange("Sales Order No.", "No.");
                IF IssueAdL.FindSet() then
                    repeat
                        IssueAdL.Clerk := Rec.Clerk;
                        IssueAdL.Modify(true);
                    until IssueAdL.Next() = 0;
            end;
        }
        field(60709; "Is Handled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                IF "Shortcut Dimension 1 Code" = '' then
                    if xrec."Shortcut Dimension 1 Code" <> '' then
                        "Shortcut Dimension 1 Code" := xRec."Shortcut Dimension 1 Code";
            end;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var
                ExtPos: Integer;
                PostText: Text[100];

            begin
                ExtPos := StrPos("Posting Description", ' Ext.');
                if ExtPos > 0 then
                    "Posting Description" := DelStr("Posting Description", ExtPos);
                "Posting Description" := "Posting Description" + ' Ext. ' + "External Document No.";
            end;
        }

        field(60711; "Imported"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60712; "Automated Sales Order"; Boolean)
        {
            Caption = 'Automatischer Verkaufsrechnung';
            DataClassification = ToBeClassified;
        }
        modify("Sell-to Contact")
        {
            trigger
            OnAfterValidate()
            var
                ContactL: Record Contact;
            begin
                If "Document Type" = "Document Type"::Quote then begin
                    IF "Sell-to E-Mail" = '' then
                        "Sell-to E-Mail" := xRec."Sell-to E-Mail";
                    If ContactL.Get("Sell-to Contact No.") then
                        If ContactL."E-Mail" <> '' then
                            "Sell-to E-Mail" := ContactL."E-Mail";
                end;
            end;
        }
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
        field(60715; "Subscription Entry No."; Guid)
        {
            Caption = 'Abo ID';
            DataClassification = ToBeClassified;
        }
        field(60716; "cos_endofdeliveryyear"; Text[100])
        {
            Caption = 'Abo Lieferende (Jahr)';
            DataClassification = ToBeClassified;
        }
        field(60717; "Annual Invoice Mark"; Code[16])
        {
            Caption = 'Jahresfaktur Kennzeichen';
            DataClassification = ToBeClassified;
        }
    }
    trigger
    OnDelete()
    var
        IssueAdL: Record "Issue Ad";
    begin
        IssueAdL.SetRange("Sales Order No.", Rec."No.");
        IssueAdL.SetFilter("Invoice No.", '');
        If IssueAdL.FindSet() then
            IssueAdL.DeleteAll(true);
    end;

    trigger
    OnAfterModify()
    begin
        IF (xRec."Shortcut Dimension 1 Code" <> '') AND ("Shortcut Dimension 1 Code" = '') then
            "Shortcut Dimension 1 Code" := xRec."Shortcut Dimension 1 Code";
    end;
}