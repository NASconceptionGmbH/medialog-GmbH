tableextension 60708 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(60705; "Type of Business"; Code[20])
        {
            Caption = 'Art des Geschäfts';
            DataClassification = ToBeClassified;
            TableRelation = "Type of Business".Code;
        }
    }
}
