page 60702 "Item Issue Subform"
{

    Caption = 'Anzeigen';
    PageType = ListPart;
    SourceTable = "Issue Ad";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Customer No."; Rec."Ship-to Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;

                }
                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Motive; Rec.Motive)
                {
                    ToolTip = 'Specifies the value of the Motive field';
                    ApplicationArea = All;
                }
                field(Placement; Rec.Placement)
                {
                    ToolTip = 'Specifies the value of the Placement field';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Print Documents"; Rec."Print Documents")
                {
                    ToolTip = 'Specifies the value of the Print Documents field';
                    ApplicationArea = All;
                }
                field("Print Documents Enddate"; Rec."Print Documents Enddate")
                {
                    ToolTip = 'Specifies the value of the Print Documents Enddate field';
                    ApplicationArea = All;
                }
                field("Reminder Count"; Rec."Reminder Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Reminder"; Rec."Last Reminder")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ToolTip = 'Specifies the value of the Confirmation Date field';
                    ApplicationArea = All;

                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        SalesHeaderL: Record "Sales Header";
                    begin
                        if SalesHeaderL.get(SalesHeaderL."Document Type"::Order, Rec."Sales Order No.") then
                            page.Run(page::"Sales Order", SalesHeaderL);
                    end;

                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ToolTip = 'Specifies the value of the Sales Person Code field';
                    ApplicationArea = All;
                }
                field(Clerk; Rec.Clerk)
                {
                    ApplicationArea = All;
                }
                field("Posting Error"; Rec."Posting Error")
                {
                    ApplicationArea = All;
                }
                field("Credit Memo No."; Rec."Credit Memo No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Invoice)
            {
                Caption = 'Fakturieren';
                ApplicationArea = All;
                Image = Post;
                trigger
                OnAction()
                var
                    IssueAdL: Record "Issue Ad";
                    IssueAdL2: Record "Issue Ad";
                    SalesHeaderL: Record "Sales Header";
                    SalesLineL: Record "Sales Line";
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                    SalesInvoiceLineL: Record "Sales Invoice Line";
                    Item: Record Item;
                    SalesHeader2L: Record "Sales Header";
                    VulkanFunctionsL: Codeunit "Vulkan Functions";
                    PostSalesOrderProcessorL: Codeunit "Post Sales Order Processor";
                    ItemVariantL: Record "Item Variant";
                begin
                    IssueAdL.SetRange("Item No.", Rec."Item No.");
                    IssueAdL.FindSet();
                    repeat
                        Item.Get(IssueAdL."Item No.");
                        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
                        SalesHeaderL.SetRange("No.", IssueAdL."Sales Order No.");
                        IF SalesHeaderL.FindFirst() then begin
                            SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
                            SalesLineL.SetRange("Document No.", SalesHeaderL."No.");
                            IF SalesLineL.FindSet() then
                                repeat
                                    IF SalesLineL."No." <> IssueAdL."Item No." then begin
                                        SalesLineL.Validate("Qty. to Ship", 0);
                                        SalesLineL.Validate("Qty. to Invoice", 0);
                                        SalesLineL.Modify();
                                    end else
                                        IF (ItemVariantL.Get(SalesLineL."No.", SalesLineL."Variant Code")) and (SalesLineL."Gen. Prod. Posting Group" = '') then begin
                                            SalesLineL."Gen. Prod. Posting Group" := ItemVariantL."Gen. Product Posting Group";
                                            SalesLineL.Modify();
                                        end;
                                until SalesLineL.Next() = 0;
                            SalesHeaderL."Posting Date" := Item."Publication Date";
                            Commit();
                            IF NOT PostSalesOrderProcessorL.Run(SalesHeaderL) then begin
                                IssueAdL."Posting Error" := GetLastErrorText();
                                IssueAdL.Modify();
                            end;
                            SalesHeader2L.SetRange("Document Type", SalesHeaderl."Document Type");
                            SalesHeader2L.SetRange("No.", SalesHeaderL."No.");
                            If SalesHeader2L.FindFirst() then
                                VulkanFunctionsL.GetEarliestPublicationdDate(SalesHeader2L, 0D, Rec."Item No.");
                        end;
                    until IssueAdL.Next() = 0;
                    IF IssueAdL.FindFirst() then
                        repeat
                            SalesInvoiceLineL.SetRange("Order No.", IssueAdL."Sales Order No.");
                            SalesInvoiceLineL.SetRange("Order Line No.", IssueAdL."Sales Line No.");
                            If SalesInvoiceLineL.FindFirst() then begin
                                IssueAdL."Invoice No." := SalesInvoiceLineL."Document No.";
                                IssueAdL."Invoice Date" := SalesInvoiceLineL."Posting Date";
                                IssueAdL.Status := IssueAdL.Status::Released;
                                IssueAdL.Modify(true);
                            end;
                        until IssueAdL.Next() = 0;
                    IssueAdL.SetRange(Status, Rec.Status::Open);
                    If IssueAdL.IsEmpty then begin
                        Item."Issue Status" := Item."Issue Status"::Invoiced;
                        Item.Modify();
                    end;
                end;
            }
            action(Mail)
            {
                ApplicationArea = All;
                Caption = 'Email Erinnerung';
                Image = MailAttachment;
                trigger
                OnAction()
                var
                    IssueAdL: Record "Issue Ad";
                    VulkanFunctionsL: Codeunit "Vulkan Functions";
                begin
                    CurrPage.SetSelectionFilter(IssueAdL);
                    If IssueAdL.FindSet() then
                        repeat
                            VulkanFunctionsL.SendPrintDocumentReminder(IssueAdL, 0);
                        until IssueAdL.Next() = 0;
                end;
            }

            action(DownloadIssueListExcel)
            {
                ApplicationArea = All;
                Caption = 'Download Dispoliste';
                Image = Excel;

                trigger OnAction()
                var
                    ExcelIssueFunctionsL: Codeunit ExcelIssueFunctions;
                    ItemL: Record Item;
                begin

                    ExcelIssueFunctionsL.DownloadExcelBufferFile(Rec."Item No.");
                    //ExportExcelIssueList
                end;
            }
            action(ExportIssuelist)
            {
                ApplicationArea = All;
                Caption = 'Export Dispoliste zu Sharepoint';
                image = ExportToExcel;

                trigger OnAction()
                var
                    ExcelIssueFunctionsL: Codeunit ExcelIssueFunctions;
                begin
                    ExcelIssueFunctionsL.ExportExcelIssueList(Rec."Item No.");
                    //ExportExcelIssueList
                end;
            }
            action(SalesInvoiceList)
            {
                ApplicationArea = All;
                Image = Invoice;
                Caption = 'Geb. Verkaufsrechnungen';
                trigger
                OnAction()
                var
                    FilterText: Text;
                    IssueAdL: Record "Issue Ad";
                    SalesInvoiceHeaderL: Record "Sales Invoice Header";
                    SalesInvoiceListL: Page "Posted Sales Invoices";

                begin
                    IssueAdL.SetRange("Item No.", Rec."Item No.");
                    IF IssueAdL.FindSet() then
                        repeat
                            If IssueAdL."Invoice No." <> '' then
                                FilterText += IssueAdL."Invoice No." + '|';
                        until IssueAdL.Next() = 0;
                    FilterText := CopyStr(FilterText, 1, STRLEN(FilterText) - 1);
                    SalesInvoiceHeaderL.SetFilter("No.", FilterText);
                    SalesInvoiceListL.SetTableView(SalesInvoiceHeaderL);
                    SalesInvoiceListL.RunModal();
                end;
            }
            action("Shipping Addresses")
            {
                ApplicationArea = All;
                Image = Addresses;
                Caption = 'Versandadressen';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = page "Shipping Addresses";
                RunPageLink = "Sales Order No." = field("Sales Order No.");
            }
        }
    }

}
