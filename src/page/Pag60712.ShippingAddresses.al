page 60712 "Shipping Addresses"
{

    Caption = 'Shipping Addresses';
    PageType = List;
    SourceTable = "Shipping Addresses";
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field';
                    ApplicationArea = All;
                }
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field';
                    ApplicationArea = All;
                }
                field("Country/Region"; Rec."Country/Region")
                {
                    ToolTip = 'Specifies the value of the Country/Region field';
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field';
                    ApplicationArea = All;
                }

            }
        }
    }

}
