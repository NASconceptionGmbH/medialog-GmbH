page 60735 "Excel Invoice Import SP"
{
    AutoSplitKey = true;
    Caption = 'Excel Import Worksheet Salesperson';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    // SaveValues = true;
    SourceTable = "Excel Import Header SP";
    // SourceTableView = sorting("Batch Name", "Line No.");
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
                }
                field(Salesperson; Rec.Salesperson)
                {
                }
                field(Clerk; Rec.Clerk)
                {
                }

                // field("Entry No"; Rec."Entry No")
                // {
                // }



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
                    ExcelImportProcessorEmailL: Codeunit ExcelImportProcessorSP;
                begin
                    ExcelImportProcessorEmailL.ImportExcel();
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
                    ExcelImportProcessorVATL: Codeunit ExcelImportProcessorSP;
                    ExcelImportHeaderVATL: Record "Excel Import Header SP";
                    ExcelImportHeaderVATL2: Record "Excel Import Header SP";
                begin
                    ExcelImportHeaderVATL.SetRange(processed, false);
                    if ExcelImportHeaderVATL.FindSet() then
                        repeat
                            if not ExcelImportProcessorVATL.run(ExcelImportHeaderVATL) then begin
                                ExcelImportHeaderVATL2.get(ExcelImportHeaderVATL."Entry No");
                                ExcelImportHeaderVATL2.error := copystr(GetLastErrorText(), 1, 250);
                            end else begin
                                ExcelImportHeaderVATL2.get(ExcelImportHeaderVATL."Entry No");
                                ExcelImportHeaderVATL2.error := '';
                                ExcelImportHeaderVATL2.processed := true;
                            end;
                            ExcelImportHeaderVATL2.Modify();
                            commit;
                        until ExcelImportHeaderVATL.next() = 0;

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
                    ExcelInvoiceImportHeaderVATL: Record "Excel Import Header SP";
                begin
                    ExcelInvoiceImportHeaderVATL.DeleteAll();
                end;
            }

        }
    }

}