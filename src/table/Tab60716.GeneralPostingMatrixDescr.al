table 60716 "GeneralPostingMatrixDescr"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Gen. Prod Posting Group"; Code[20])
        {

            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Gen. Bus. Posting Group", "Gen. Prod Posting Group")
        {
            Clustered = true;
        }
    }


}