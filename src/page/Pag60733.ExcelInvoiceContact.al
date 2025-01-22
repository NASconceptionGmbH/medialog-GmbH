page 60733 "Excel Invoice Contact"
{
    AutoSplitKey = true;
    Caption = 'Excel Import Worksheet Contacts';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Excel Import Contact";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            repeater(Group)
            {
                field(id_juristic_person; Rec.id_juristic_person)
                {
                }
                field(id_location; Rec.id_location)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(position; Rec.position)
                {
                }
                field(Country; Rec.Country)
                {
                }
                field("postal code"; Rec."postal code")
                {
                }
                field(city; Rec.city)
                {
                }
                field(street; Rec.street)
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
                    ExcelImportProcessorContactL: Codeunit ExcelImportProcessorContact;
                begin
                    ExcelImportProcessorContactL.ImportExcel();
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
                    ExcelImportProcessorContact: Codeunit ExcelImportProcessorContact;
                    ContactL: Record Contact;
                    ExcelImportContactL: Record "Excel Import Contact";
                    ExcelImportContactL2: Record "Excel Import Contact";
                begin
                    ExcelImportContactL.SetRange(processed, false);
                    if ExcelImportContactL.FindSet() then
                        repeat
                            if not ExcelImportProcessorContact.run(ExcelImportContactL) then begin
                                ExcelImportContactL2.get(ExcelImportContactL."Entry No");
                                ExcelImportContactL2.error := GetLastErrorText();
                            end else begin
                                ExcelImportContactL2.get(ExcelImportContactL."Entry No");
                                ExcelImportContactL2.error := '';
                                ExcelImportContactL2.processed := true;
                            end;
                            ExcelImportContactL2.Modify();
                            commit();
                        until ExcelImportContactL.next() = 0;

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
                    ExcelImportContactL: Record "Excel Import Contact";
                begin
                    ExcelImportContactL.DeleteAll();
                end;
            }

        }
    }

}