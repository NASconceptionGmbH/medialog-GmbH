codeunit 60731 Cleanuptemp
{
    trigger OnRun()
    var
        CustomReportLayoutL: Record "Custom Report Layout";
    begin
        CustomReportLayoutL.DeleteAll();
    end;

    var
        myInt: Integer;
}