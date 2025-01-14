pageextension 60701 "Item Card Ext." extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Magazine Type"; Rec."Magazine Type")
            {
                Caption = 'Magazin Typ';
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update();

                    if Rec."Magazine Type" <> xRec."Magazine Type" then begin
                        Rec.ItemDescriptionUploaded := false;
                        Rec.Modify();
                    end
                end;
            }
            field("Planned Value"; Rec."Planned Value")
            {
                Caption = 'Planned Value';
                ApplicationArea = All;
            }
        }
        addafter(Item)
        {
            group("Vulkan Subscription")

            {
                Caption = 'Vulkan';
                Visible = IsSubscription;

                field("Issue Qty."; Rec."Issue Qty.")
                {
                    Caption = 'Anzahl Anzeigen';
                    ApplicationArea = All;
                }
                field("Basic Product"; Rec."Basic Product")
                {
                    ApplicationArea = All;
                }

                field("Template Item"; Rec."Template Item")
                {
                    Caption = 'Vorlage Artikel';
                    ApplicationArea = All;
                }
                field("Template Item Description"; Rec."Template Item Description")
                {
                    Caption = 'Vorlage Artikel Beschreibung';
                    ApplicationArea = All;
                }
            }
            group("Vulkan Issues")
            {
                Caption = 'Vulkan';
                Visible = Isissue;

                field(Subscription; Rec.Subscription)
                {
                    Caption = 'Abo';
                    ApplicationArea = All;
                }
                field("Subscription Description"; Rec."Subscription Description")
                {
                    Caption = 'Abo Beschreibung';
                    ApplicationArea = All;
                }
                field("Issue Status"; Rec."Issue Status")
                {
                    Caption = 'Anzeigen Status';
                    ApplicationArea = All;
                }
                field("Item Issue Closing Date"; Rec."Item Issue Closing Date")
                {
                    ApplicationArea = All;
                }
                field("Total Ads (Available)"; Rec."Total Ads (Available)")
                {
                    Caption = 'Gesamt Anzeigen verfügbar';
                    ApplicationArea = All;
                }
                field("Total Ads (Open)"; Rec."Total Ads (Open)")
                {
                    Caption = 'Gesamt Anzeigen(Offen)';
                    ApplicationArea = All;
                }
                field("Total Ads (Released)"; Rec."Total Ads (Released)")
                {
                    Caption = 'Gesamt Anzeigen(Freigegeben)';
                    ApplicationArea = All;
                }
            }
            group("Miscellaneous")
            {
                Caption = 'Vulkan';
                Visible = IsMiscellaneous;
                field("Template_Item"; Rec."Template Item")
                {
                    ApplicationArea = All;
                }
                field("Template_Item_Description"; Rec."Template Item Description")
                {
                    ApplicationArea = ALL;
                }
            }
            part(IssueAds; "Item Issue Subform")
            {
                Caption = 'Anzeigen';
                SubPageLink = "Item No." = field("No.");
                Visible = IsIssue;
                ApplicationArea = All;
                Editable = True;

            }

        }
        addfirst(factboxes)
        {
            part(SharePointConnect; "Sharepoint Connect VV")
            {
                ApplicationArea = All;
                Caption = 'NC365 SharePoint Connect';
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        addfirst(Functions)
        {
            action(ItemDescription)
            {
                ApplicationArea = All;
                Caption = 'Artikelbeschreibung aktualisieren';

                trigger OnAction()
                var
                    SharePointAddinCodeUnit_NASL: Codeunit SharePointAddinCodeUnit_NAS;
                begin
                    SharePointAddinCodeUnit_NASL.UpdateItemDescriptionInSharepoint(Rec."No.");
                end;
            }

        }
        addafter(CRMGoToProduct)
        {
            action(SyncMerkmal)
            {
                ApplicationArea = All;
                caption = 'Sync Merkmal Relation';
                Visible = UpdateCRMAttributesVisible;
                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                begin
                    CustomCRMSynchronizationL.SynchronizeCharacteristicsItemRelation(Rec."No.", true);
                end;
            }
            action(SyncSparte)
            {
                ApplicationArea = All;
                caption = 'Sync Sparten Relation';
                Visible = UpdateCRMAttributesVisible;
                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                begin
                    CustomCRMSynchronizationL.SynchronizeSparteItemRelation(Rec."No.", true);
                end;
            }

        }

        addlast(Sales)
        {
            action(CustomerInformations)
            {
                Caption = 'Download Debitorinformationen';
                ApplicationArea = all;
                Image = Download;

                trigger OnAction()
                var
                    ExcelIssueFunctionsL: Codeunit ExcelIssueFunctions;
                begin
                    ExcelIssueFunctionsL.DownloadCustomerInformations(Rec."No.");
                end;
            }
        }
    }
    trigger
    OnAfterGetRecord()
    var

    begin
        UpdateCRMAttributesVisible := UserId = 'ADMIN.CC.CRM';

        IsSubscription := false;
        IsIssue := false;
        IsMiscellaneous := false;
        If ItemCategory.Get(Rec."Item Category Code") then
            If ItemCategory."Item Category Template Code" <> '' then begin
                Rec."Item Category Filter" := ItemCategory."Item Category Template Code";
                if ItemCategory.Subscription then
                    IsSubscription := true
                Else
                    IF ItemCategory.Issue then
                        IsIssue := true
                    else
                        IsMiscellaneous := true;
            end;
    end;

    var
        IsSubscription: Boolean;
        IsIssue: Boolean;
        IsMiscellaneous: Boolean;
        ItemCategory: Record "Item Category";
        IssueSetup: Record "Issue Setup";
        UpdateCRMAttributesVisible: Boolean;
}