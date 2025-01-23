page 60734 "Excel Invoice Orders"
{
    AutoSplitKey = true;
    Caption = 'Excel Import Worksheet Orders';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Excel Import Orders";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            repeater(Group)
            {
                field("order no"; Rec."order no")
                {
                    ApplicationArea = All;
                }

                field("Artikelnr."; Rec."Artikelnr.")
                {
                }
                field(Variantencode; Rec.Variantencode)
                {
                }
                field(Auftragsdatum; Rec.Auftragsdatum)
                {
                }
                field("Ihre Referenz"; Rec."Ihre Referenz")
                {
                }
                field(order_state; Rec.order_state)
                {
                }
                field(Debitor; Rec.Debitor)
                {
                }
                field("Debitor Kontakt"; Rec."Debitor Kontakt")
                {
                }
                field("Liefern an Debitor"; Rec."Liefern an Debitor")
                {
                }
                field("Liefern an Kontakt"; Rec."Liefern an Kontakt")
                {
                }
                field(interfall_sammelrechnung; Rec.interfall_sammelrechnung)
                {
                }
                field(Zahlungsbedingung; Rec.Zahlungsbedingung)
                {
                }
                field(Belegsendeprofil; Rec.Belegsendeprofil)
                {
                }
                field("Email Rechnung"; Rec."Email Rechnung")
                {
                }
                field("Debitor Kontakt Email"; Rec."Debitor Kontakt Email")
                {
                }
                field("Email Agenturen Rechnung"; Rec."Email Agenturen Rechnung")
                {
                }
                field(Buchungsdatum; Rec.Buchungsdatum)
                {
                }
                field(Platzierung; Rec.Platzierung)
                {
                }
                field(Zusatzzeile; Rec.Zusatzzeile)
                {
                }
                field("Externe Belegnummer"; Rec."Externe Belegnummer")
                {
                }
                field(Zeilenrabatt; Rec.Zeilenrabatt)
                {
                }
                field("Rabatt Betrag"; Rec."Rabatt Betrag")
                {
                }
                field("VK Netto"; Rec."VK Netto")
                {
                }
                field("Zeilen Netto"; Rec."Zeilen Netto")
                {
                }
                field(MwSt; Rec.MwSt)
                {
                }
                field(Rechnungsrabatt; Rec.Rechnungsrabatt)
                {
                }
                field(processed; Rec.processed)
                {
                }
                field(error; Rec.error)
                {
                }

            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Order")
            {
                Caption = '&Order';
                Image = Order;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    if SalesHeaderL.get(SalesHeaderL."Document Type"::Order, Rec."BC Order No.") then
                        page.run(page::"Sales Order", SalesHeaderL);
                end;
            }
            action("&Import")
            {
                Caption = '&Import';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';

                trigger OnAction()
                var
                    ExcelImportProcessorOrdersL: Codeunit ExcelImportProcessorOrders;
                begin
                    ExcelImportProcessorOrdersL.ImportExcel();
                end;
            }
            action("Process")
            {
                Caption = 'Process';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ExcelImportProcessorOrders: Codeunit ExcelImportProcessorOrders;
                    ContactL: Record Contact;
                    ExcelImportOrdersL: Record "Excel Import Orders";
                    ExcelImportOrdersL2: Record "Excel Import Orders";
                begin
                    ExcelImportOrdersL.SetRange(processed, false);
                    if ExcelImportOrdersL.FindSet() then
                        repeat
                            if not ExcelImportProcessorOrders.run(ExcelImportOrdersL) then begin
                                ExcelImportOrdersL2.get(ExcelImportOrdersL."Entry No");
                                ExcelImportOrdersL2.error := copystr(GetLastErrorText(), 1, 250);
                            end else begin
                                ExcelImportOrdersL2.get(ExcelImportOrdersL."Entry No");
                                ExcelImportOrdersL2.error := '';
                                ExcelImportOrdersL2.processed := true;
                            end;
                            ExcelImportOrdersL2.Modify();
                            commit();
                        until ExcelImportOrdersL.next() = 0;

                end;

            }

            action(DeleteAll)
            {
                ApplicationArea = All;
                Caption = 'Delete Import Entries';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ExcelImportOrdersL: Record "Excel Import Orders";
                    SalesHeaderL: Record "Sales Header";
                    SalesLineL: Record "Sales Line";
                    IssueAd: Record "Issue Ad";
                begin
                    ExcelImportOrdersL.DeleteAll();
                    if Confirm('delete orders as well?') then begin
                        SalesHeaderL.DeleteAll(true);
                        IssueAd.DeleteAll(true);
                    end;
                end;
            }

        }
    }

}