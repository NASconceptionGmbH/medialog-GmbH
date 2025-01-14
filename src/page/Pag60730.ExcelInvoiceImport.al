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
                field(Description; Rec.Description)
                {
                }
                field("Date"; Rec.Date)
                {
                }
                field("Time"; Rec.Time)
                {
                }

                field("Invoice No"; Rec."Invoice No")
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
                    SetSetEmailFieldsL: Codeunit SetSetEmailFields;
                begin
                    SetSetEmailFieldsL.ImportExcel();
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
                    ExcelInvoiceImportL: Codeunit SetSetEmailFields;
                begin
                    ExcelInvoiceImportL.Transform();
                end;
            }
            action("WriteInvoices")
            {
                Caption = 'SetEmailSent';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ExcelInvoiceImportL: Codeunit SetSetEmailFields;
                begin
                    ExcelInvoiceImportL.SetEmailFields();
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