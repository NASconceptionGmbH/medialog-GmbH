page 60731 "Excel Invoice Import Email"
{
    AutoSplitKey = true;
    Caption = 'Excel Import Worksheet Email';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    // SaveValues = true;
    SourceTable = "Excel Import Header Email";
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
                field(id_location; Rec.id_location)
                {
                }
                field(id_communication; Rec.id_communication)
                {
                }
                field(communication_number; Rec.communication_number)
                {
                    ApplicationArea = All;
                }

                field(Belegsendeprofil; Rec.Belegsendeprofil)
                {
                }
                field(kind_of_communication; Rec.kind_of_communication)
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
                    ExcelImportProcessorEmailL: Codeunit ExcelImportProcessorEmail;
                begin
                    ExcelImportProcessorEmailL.ImportExcel();
                end;
            }
            action("Process")
            {
                Caption = 'Transform Lines';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ExcelImportProcessorEmailL: Codeunit ExcelImportProcessorEmail;
                    CustomerL: Record Customer;
                    ExcelImportHeaderEmailL: Record "Excel Import Header Email";
                    ExcelImportHeaderEmailL2: Record "Excel Import Header Email";
                begin
                    ExcelImportHeaderEmailL.SetRange(processed, false);
                    ExcelImportHeaderEmailL.SetRange(kind_of_communication, 'RE E-Mail');
                    if ExcelImportHeaderEmailL.FindSet() then
                        repeat
                            if not ExcelImportProcessorEmailL.run(ExcelImportHeaderEmailL) then begin
                                ExcelImportHeaderEmailL2.get(ExcelImportHeaderEmailL."Entry No");
                                ExcelImportHeaderEmailL2.error := GetLastErrorText();
                            end else begin
                                ExcelImportHeaderEmailL2.get(ExcelImportHeaderEmailL."Entry No");
                                ExcelImportHeaderEmailL2.error := '';
                                ExcelImportHeaderEmailL2.processed := true;
                            end;
                            ExcelImportHeaderEmailL2.Modify()
                        until ExcelImportHeaderEmailL.next() = 0;

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
                    ExcelInvoiceImportHeaderEmailL: Record "Excel Import Header Email";
                begin
                    ExcelInvoiceImportHeaderEmailL.DeleteAll();
                end;
            }

        }
    }

}