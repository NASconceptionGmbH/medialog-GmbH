tableextension 60709 "Sales Cr. Memo Line Ext" extends "Sales Cr.Memo Line"
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
