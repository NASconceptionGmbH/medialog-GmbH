tableextension 60705 "CustomerExt" extends Customer
{
    fields
    {
        field(60700; "CRM GUID"; Guid)
        {
            Caption = 'CRM ID';
            DataClassification = ToBeClassified;
        }
        field(60701; vv_id_location; Text[100])
        {
            Caption = 'Adresse ID';
            DataClassification = ToBeClassified;
        }
        field(60702; vv_idjuristicperson; Text[100])
        {
            Caption = 'Juristische Person ID';
            DataClassification = ToBeClassified;
        }
        field(60703; cos_n_id; Text[100])
        {
            Caption = 'N_ID';
            DataClassification = ToBeClassified;
        }
        field(60704; cos_a_id; Text[100])
        {
            Caption = 'A_ID';
            DataClassification = ToBeClassified;
        }



    }

}