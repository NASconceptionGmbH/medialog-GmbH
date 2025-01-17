codeunit 60731 Cleanuptemp
{
    trigger OnRun()
    var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        CustomReportSelection.DeleteAll();
    end;

    var
        myInt: Integer;
}