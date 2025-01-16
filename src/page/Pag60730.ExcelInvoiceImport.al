page 60730 "Excel Invoice Import"
{
    AutoSplitKey = true;
    Caption = 'Excel Import Worksheet';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    // SaveValues = true;
    SourceTable = "Excel Import Header";
    // SourceTableView = sorting("Batch Name", "Line No.");
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            repeater(Group)
            {

                field("Entry No"; Rec."Entry No")
                {
                }
                field(id_juristic_person; Rec.id_juristic_person)
                {
                }
                field(Debitorennr; Rec.Debitorennr)
                {
                }
                field(customer_id; Rec.customer_id)
                {
                }
                field(customer_type; Rec.customer_type)
                {
                }
                field(Gesperrt; Rec.Gesperrt)
                {
                }
                field("SEPA Abo"; Rec."SEPA Abo")
                {
                }
                field("Zahlungsformcode SEPA ABO"; Rec."Zahlungsformcode SEPA ABO")
                {
                }
                field("SEPA allgemein"; Rec."SEPA allgemein")
                {
                }
                field("Zahlungsformcode SEPA allg"; Rec."Zahlungsformcode SEPA allg")
                {
                }
                field("Belegsendeprofil ABO"; Rec."Belegsendeprofil ABO")
                {
                }
                field(Zahlungsbedingungscode; Rec.Zahlungsbedingungscode)
                {
                }
                field(adv_zahlungsziel; Rec.adv_zahlungsziel)
                {
                }
                field(anz_e_invoice; Rec.anz_e_invoice)
                {
                }
                field("Belegsendeprofil Allgemein"; Rec."Belegsendeprofil Allgemein")
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
                    ExcelImportProcessorL: Codeunit ExcelImportProcessor;
                begin
                    ExcelImportProcessorL.ImportExcel();
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
                    ExcelImportProcessorL: Codeunit ExcelImportProcessor;
                    CustomerL: Record Customer;
                    ExcelImportHeaderL: Record "Excel Import Header";
                    ExcelImportHeaderL2: Record "Excel Import Header";
                begin
                    ExcelImportHeaderL.SetRange(processed, false);
                    if ExcelImportHeaderL.FindSet() then
                        repeat
                            if not ExcelImportProcessorL.run(ExcelImportHeaderL) then begin
                                ExcelImportHeaderL2.get(ExcelImportHeaderL."Entry No");
                                ExcelImportHeaderL2.error := GetLastErrorText();
                            end else begin
                                ExcelImportHeaderL2.get(ExcelImportHeaderL."Entry No");
                                ExcelImportHeaderL2.error := '';
                                ExcelImportHeaderL2.processed := true;
                            end;
                            ExcelImportHeaderL2.Modify();
                            commit();
                        until ExcelImportHeaderL.next() = 0;

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
                    ExcelInvoiceImportHeaderL: Record "Excel Import Header";
                begin
                    ExcelInvoiceImportHeaderL.DeleteAll();
                end;
            }

        }
    }

}