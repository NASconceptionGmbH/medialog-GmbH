page 60720 "Import Buffer Correction"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Import Buffer Correction";

    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("Ext. Doc No."; Rec."Ext. Doc No.")
                {
                    ToolTip = 'Specifies the value of the Ext. Doc No. field.';
                    ApplicationArea = All;
                }
                field("Line Discount"; Rec."Line Discount")
                {
                    ToolTip = 'Specifies the value of the Line Discount field.';
                    ApplicationArea = All;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ToolTip = 'Specifies the value of the Error Text field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ImportBufferCorrectionL: Record "Import Buffer Correction";
                    ImportBufferCorrectionProcessorL: Codeunit "Import Buffer Corr Processor";
                begin
                    CurrPage.SetSelectionFilter(ImportBufferCorrectionL);
                    If ImportBufferCorrectionL.FindSet() then
                        repeat
                            Commit;
                            IF NoT ImportBufferCorrectionProcessorL.Run(ImportBufferCorrectionL) then begin
                                ImportBufferCorrectionL."Error Text" := GetLastErrorText();
                                ImportBufferCorrectionL.Modify();
                            end;
                        until ImportBufferCorrectionL.Next() = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}