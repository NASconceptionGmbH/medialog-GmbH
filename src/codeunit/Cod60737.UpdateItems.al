codeunit 60737 UpdateItems
{
    trigger OnRun()
    var
        ItemL: Record Item;
    begin
        ItemL.ModifyAll("Marked for Update IssueList", true);
    end;
}