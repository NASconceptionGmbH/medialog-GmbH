codeunit 60738 UpdateReportSlections
{
    trigger OnRun()
    var
        CustomReportSelectionL: Record "Custom Report Selection";
    begin
        CustomReportSelectionL.SetRange("Source Type", 18);
        CustomReportSelectionL.SetRange("Report ID", 60704);
        if CustomReportSelectionL.FindSet() then
            repeat
                CustomReportSelectionL.Validate("Report ID", 6188472);
                CustomReportSelectionL.modify();
            until CustomReportSelectionL.next() = 0;

    end;

    var
        myInt: Integer;
}