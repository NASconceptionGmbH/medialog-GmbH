codeunit 60730 CleanUp
{
    trigger OnRun()
    var
        CustomerL: Record Customer;
    begin
        CustomerL.DeleteAll();

    end;

    var
        myInt: Integer;
}