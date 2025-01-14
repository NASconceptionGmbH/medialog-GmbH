tableextension 60704 "Item Category Ext" extends "Item Category"
{
    fields
    {
        /*   field(60700; "CRM GUID"; Guid)
           {
               Caption = 'CRM GUID';
               DataClassification = ToBeClassified;
           }*/
        field(60701; "Item Category Template Code"; Code[50])
        {
            Caption = 'Artikelkategorienvorlagencode';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(60702; "Subscription"; Boolean)
        {
            Caption = 'Abonnement';
            DataClassification = ToBeClassified;
        }
        field(60703; "Issue"; Boolean)
        {
            Caption = 'Anzeige';
            DataClassification = ToBeClassified;
        }
        field(60700; "Show Retail Price"; Boolean)
        {
            Caption = 'Ladenpreis in Vk-Zeile';
            DataClassification = ToBeClassified;
        }
    }

}