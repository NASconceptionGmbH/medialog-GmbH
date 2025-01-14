page 60714 "Sharepoint Connect Setup"
{

    Caption = 'Sharepoint Connect Setup';
    PageType = Card;
    SourceTable = "SharePoint Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field(PK; Rec.PK)
                {
                    ApplicationArea = All;
                }
                field(SalesLine; Rec.SalesLine)
                {
                    ApplicationArea = All;
                }
                field("SiteID 1"; Rec."SiteID 1")
                {
                    ApplicationArea = All;
                }
                field(TenantID; Rec.TenantID)
                {
                    ApplicationArea = All;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = all;
                }

                field("Client Secret"; Rec."Client Secret")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}
