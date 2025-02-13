page 60736 "Item Issues"
{

    APIGroup = 'medialog';
    APIPublisher = 'nasconception';
    APIVersion = 'v2.0';
    Caption = 'itemIssues';
    DelayedInsert = true;
    EntityName = 'itemIssue';
    EntitySetName = 'itemIssues';
    PageType = API;
    SourceTable = "Issue Ad";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                }
                field(salesPersonCode; Rec."Sales Person Code")
                {
                }
                field(startDate; Rec."Start Date")
                {
                }
                field(endDate; Rec."End Date")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(itemDescription; Rec."Item Description")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(salesOrderNo; Rec."Sales Order No.")
                {
                }
                field(MailRecipforIssueReminder; Rec."Mail Recip. for Issue Reminder")
                {
                }
            }
        }
    }
}
