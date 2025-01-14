table 60723 "NAS Activities"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primery Key"; Code[10])
        {
            Caption = 'MyField';
            DataClassification = ToBeClassified;
        }
        field(2; "Subscription Errors"; Integer)
        {
            Caption = 'Abos mit Fehlermeldungen';
            FieldClass = FlowField;
            CalcFormula = count(Subscriptions where("Error Message" = filter(<> '')));
        }
        field(3; "Subscription without Sales Order"; Integer)
        {
            Caption = 'Abos ohne Verkaufsaufträge';
            FieldClass = FlowField;
            CalcFormula = count(Subscriptions where("Error Message" = filter(''), "Sales Order No." = const(''), "BC Status" = const(Active)));
        }
        field(4; "Sales Order Type Abo"; Integer)
        {
            Caption = 'Verkaufsaufträge mit Typ Abo';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order), "Subscription Order" = const(true)));
        }
    }

    keys
    {
        key(PK; "Primery Key")
        {
            Clustered = true;
        }
    }



}