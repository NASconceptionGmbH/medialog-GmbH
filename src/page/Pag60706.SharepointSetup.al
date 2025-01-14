page 60706 "Sharepoint Setup"
{
    Caption = 'Sharepoint Setup Hidden';
    PageType = Card;
    SourceTable = "SharePoint Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("SiteID 1"; Rec."SiteID 1")
                {
                    ApplicationArea = All;
                }

                field(CreateLinkEnabled; Rec.CreateLinkEnabled)
                {
                    ApplicationArea = All;
                }

                field(DocumentsLanguage; Rec.DocumentsLanguage)
                {
                    ApplicationArea = All;
                }

                field(HighestFolder; Rec.HighestFolder)
                {
                    ApplicationArea = All;
                }
                field(InBearbeitung; Rec.InBearbeitung)
                {
                    ApplicationArea = All;
                }
                field(MaximalTiefe; Rec.MaximalTiefe)
                {
                    ApplicationArea = All;
                }
                field(TenantID; Rec.TenantID)
                {

                    ApplicationArea = All;
                }
                field(ColumnDescription; Rec.ColumnDescription)
                {
                    ApplicationArea = All;
                }

            }
            group(pages)
            {

                field(Contact; Rec.SalesLine)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
