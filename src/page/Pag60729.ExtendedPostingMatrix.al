page 60729 "Extended Posting Matrix"
{
    ApplicationArea = All;
    Caption = 'OSS Posting Matrix';
    PageType = List;
    SourceTable = "Extended Posting Matrix";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Country Code"; Rec."Country Code")
                {
                }
                field("VAT No."; Rec."VAT No.")
                {
                }
                field("Destination Country Code"; Rec."Destination Country Code")
                {
                }
                field("General Bus. Posting Group"; Rec."General Bus. Posting Group")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }
                field("Price Incl. VAT"; Rec."Price Incl. VAT")
                {
                }
            }
        }
    }
}
