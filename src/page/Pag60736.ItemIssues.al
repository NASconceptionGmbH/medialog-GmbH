page 60736 "Item Issues"
{

    APIGroup = 'medialog';
    APIPublisher = 'nasconception';
    APIVersion = 'v1.0';
    Caption = 'itemIssues';
    DelayedInsert = true;
    EntityName = 'itemIssue';
    EntitySetName = 'itemIssues';
    PageType = API;
    SourceTable = "Issue Ad";

    layout
    {
        area(content)
        {
            repeater(General)
            {

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
                field(variantCode; Rec."Variant Code")
                {
                }
                field(salesOrderNo; Rec."Sales Order No.")
                {
                }
                field(createdDate; Rec."Created Date")
                {
                }
            }
        }
    }
}
