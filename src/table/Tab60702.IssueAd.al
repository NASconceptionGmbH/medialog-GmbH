table 60702 "Issue Ad"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ad No."; Integer)
        {
            Caption = 'Anzeigennummer';
            //AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
            ObsoleteState = Removed;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Artikelnummer';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(3; "Variant Code"; Code[20])
        {
            Caption = 'Variante';
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
            trigger
            OnValidate()
            var
                PriceListLine: Record "Price List Line";
            begin
                PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::"All Customers");
                PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                PriceListLine.SetRange("Asset No.", "Item No.");
                PriceListLine.SetRange("Variant Code", "Variant Code");
                If PriceListLine.FindFirst() then
                    "Unit Price" := PriceListLine."Unit Price";
                "Created Date" := Today;
            end;
        }
        field(4; Status; Option)
        {
            OptionMembers = Open,Released;
            DataClassification = ToBeClassified;
        }
        field(5; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Verkauf an Debitor Nr.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(6; "Sell-to Customer Name"; Text[100])
        {
            Caption = 'Verkauf an Debitorname';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Editable = false;
        }
        field(7; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Rechnung an Debitor Nr.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Verkaufspreis';
            DataClassification = ToBeClassified;
        }
        field(9; "Sales Order No."; Code[20])
        {
            Caption = 'Verkaufsauftragnummer';
            DataClassification = ToBeClassified;
        }
        field(10; "Sales Person Code"; Code[20])
        {
            Caption = 'Verkäufercode';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(11; "Created Date"; Date)
        {
            Caption = 'Erstellungsdatum';
            DataClassification = ToBeClassified;
        }
        field(12; "Confirmation Date"; Date)
        {
            Caption = 'Bestätigungsdatum';
            DataClassification = ToBeClassified;
        }
        field(13; "Motive"; Text[50])
        {
            Caption = 'Motiv';
            DataClassification = ToBeClassified;
        }
        field(14; "Placement"; Text[50])
        {
            Caption = 'Platzierung';
            DataClassification = ToBeClassified;
        }
        field(15; "Invoice No."; Code[20])
        {
            Caption = 'Rechnungsnummer';
            DataClassification = ToBeClassified;
        }
        field(16; "Invoice Date"; Date)
        {
            Caption = 'Buchungsdatum';
            DataClassification = ToBeClassified;
        }
        field(17; "Print Documents"; Boolean)
        {
            Caption = 'Druckunterlagen';
            DataClassification = ToBeClassified;
        }
        field(18; "Print Documents Enddate"; Date)
        {
            Caption = 'Anzeigen Schlussdatum';
            DataClassification = ToBeClassified;
        }
        field(19; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Reminder Count"; Integer)
        {
            Caption = 'Druckerinnerungen';
            DataClassification = ToBeClassified;
        }
        field(22; "Last Reminder"; Date)
        {
            Caption = 'Letzte Erinnerung';
            DataClassification = ToBeClassified;
        }
        field(23; "Email"; Text[50])
        {

            DataClassification = ToBeClassified;
        }
        field(24; "Ship-to Customer No."; Code[50])
        {
            Caption = 'Lieferung an Debitor Nr.';
            TableRelation = Customer;
            DataClassification = ToBeClassified;
        }
        field(25; "Line Amount Excl. VAT"; Decimal)
        {
            Caption = 'Zeilenbetrag ohne MwSt.';
            DataClassification = ToBeClassified;

        }
        field(26; Format; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Commission %"; Decimal)
        {
            Caption = 'Provisionssatz';
            DataClassification = ToBeClassified;
        }
        field(28; "Commission Amount"; Decimal)
        {
            Caption = 'Provisionsbetrag';
            DataClassification = ToBeClassified;
        }
        field(29; "Clerk"; Code[20])
        {
            Caption = 'Sachbearbeiter';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(30; "Line Amount"; Decimal)
        {
            Caption = 'Zeilenbetrag Inkl. MwSt.';
            DataClassification = ToBeClassified;
        }
        field(31; "Salesperson 2"; Code[50])
        {
            Caption = 'Verkäufer 2';
            DataClassification = ToBeClassified;
        }
        field(32; "Commission 2 %"; Decimal)
        {
            Caption = 'Provisionssatz 2';
            DataClassification = ToBeClassified;
        }
        field(33; "Commission Amount 2"; Decimal)
        {
            Caption = 'Provisionsbetrag 2';
            DataClassification = ToBeClassified;
        }
        field(60705; "Type of Business"; Code[20])
        {
            Caption = 'Art des Geschäfts';
            DataClassification = ToBeClassified;
            TableRelation = "Type of Business".Code;
        }
        field(34; "Ship-to Name"; Text[250])
        {
            Caption = 'Lieferung an Debitor Name';
            DataClassification = ToBeClassified;
        }
        field(35; "Posting Error"; Text[1000])
        {
            Caption = 'Fehlertext Buchung';
            DataClassification = ToBeClassified;
        }
        field(36; "Credit Memo No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Gutschriftsnummer';
        }
        field(37; "Purchase"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase', Comment = 'DEU="Einkauf"';
        }
    }
    keys
    {
        key(Pk; "Sales Order No.", "Sales Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        ItemL: Record Item;
    begin
        If ItemL.Get(Rec."Item No.") then
            if NOT ItemL."Marked for Update IssueList" then begin
                ItemL."Marked for Update IssueList" := true;
                ItemL.Modify();
            end;
    end;

    trigger OnModify()
    var
        ItemL: Record Item;
    begin
        If ItemL.Get(Rec."Item No.") then
            if NOT ItemL."Marked for Update IssueList" then begin
                ItemL."Marked for Update IssueList" := true;
                ItemL.Modify();
            end;
    end;

    trigger OnDelete()
    var
        ItemL: Record Item;
    begin
        If ItemL.Get(Rec."Item No.") then
            if NOT ItemL."Marked for Update IssueList" then begin
                ItemL."Marked for Update IssueList" := true;
                ItemL.Modify();
            end;
    end;


    trigger OnRename()
    begin

    end;


    procedure CalcCommission(SalesAmount: Decimal; Commission: Decimal): Decimal
    var
        myInt: Integer;
    begin
        EXIT(SalesAmount * (Commission / 100));
    end;
}