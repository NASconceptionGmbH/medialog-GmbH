page 60701 "Issue Setup"
{

    Caption = 'Issue Setup';
    PageType = Card;
    SourceTable = "Issue Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Issue Category Code"; Rec."Issue Category Code")
                {
                    ToolTip = 'Specifies the value of the Issue Category Code field';
                    ApplicationArea = All;
                }
                field("Subscription Category Code"; Rec."Subscription Category Code")
                {
                    ToolTip = 'Specifies the value of the Subscription Category Code field';
                    ApplicationArea = All;
                }
                field("Mail Reminder Dateformula"; Rec."Mail Reminder Dateformula")
                {
                    ApplicationArea = All;
                }
                field("Mail Reminder Interval"; Rec."Mail Reminder Interval")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ApplicationArea = All;
                }

                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = All;
                }
                field("Subscription Deferal Code"; Rec."Subscription Deferal Code")
                {
                    ApplicationArea = All;
                    caption = 'Abo Abgrenzungsvorlagencode';
                }

                field("Test Mail Recipient"; Rec."Test Mail Recipient")
                {
                    Caption = 'Test Mail Empfänger';
                    ApplicationArea = All;
                }
                field("Enable OSS"; Rec."Enable OSS")
                {
                    ApplicationArea = All;
                }
                field("Autom. Bom Explode"; Rec."Autom. Bom Explode")
                {
                    ApplicationArea = All;
                }
                field("SkipCRMOrderCreation(sandbox)"; Rec."SkipCRMOrderCreation(sandbox)")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SetPostingDatesToET)
            {
                ApplicationArea = All;
                RunObject = Report "Set Posting Date";
                Image = ChangeDate;
                trigger OnAction()
                begin

                end;
            }
            action(RefreshIssues)
            {
                ApplicationArea = All;
                RunObject = Report "Refresh Item Issue";
                Image = RefreshLines;
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        If not Rec.Get() then begin
            Rec.Init();
            Rec.Insert()
        end
    end;
}
