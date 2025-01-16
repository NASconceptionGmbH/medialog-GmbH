codeunit 60730 ExcelImportProcessorEmail
{
    TableNo = "Excel Import Header Email";
    trigger OnRun()
    var
        CustomerL: Record Customer;
        CustomReportSelectionL: Record "Custom Report Selection";
    begin
        CustomerL.setrange(vv_id_location, Rec.id_location);
        CustomerL.FindFirst();

        case
            Rec.Belegsendeprofil of
            'EMAIL':
                begin
                    CustomerL."E-Mail" := Rec.communication_number;
                    CustomerL."Document Sending Profile" := 'EMAIL';
                    CustomerL.modify();

                    CustomReportSelectionL.init();
                    CustomReportSelectionL."Source Type" := Database::customer;
                    CustomReportSelectionL."Source No." := CustomerL."No.";
                    CustomReportSelectionL.Usage := CustomReportSelectionL.Usage::"S.Invoice";
                    CustomReportSelectionL."Report ID" := 60407;
                    CustomReportSelectionL."Use for Email Attachment" := true;
                    CustomReportSelectionL."Send To Email" := CopyStr(Rec.communication_number, 1, 200);
                    if not CustomReportSelectionL.insert() then;
                end;
        end;
    end;




    procedure ImportExcel()
    var
        FileManagementL: Codeunit "File Management";
        InStreamL: InStream;
        FromFileL: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFileL, InStreamL);
        if FromFileL <> '' then begin
            FileName := FileManagementL.GetFileName(FromFileL);
            TempExcelBuffer.GetSheetsNameListFromStream(InStreamL, TempNameValueBuffer);
        end else
            Error(NoFileFoundMsg);

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempNameValueBuffer.Reset();
        if TempNameValueBuffer.FindSet() then
            repeat
                Clear(SheetName);
                SheetName := TempNameValueBuffer.Value;
                TempExcelBuffer.OpenBookStream(InStreamL, SheetName);
                TempExcelBuffer.ReadSheet();

                MaxRowNo := 0;
                TempExcelBuffer.Reset();
                if TempExcelBuffer.FindLast() then
                    MaxRowNo := TempExcelBuffer."Row No.";

                RowNo := 0;
                ColNo := 0;

                ImportHeaderData();

            until TempNameValueBuffer.next() = 0;
    end;

    local procedure ImportHeaderData();
    var
        ExcelImportHeaderL: Record "Excel Import Header Email";
        LineNo: Integer;
    begin
        LineNo := 0;
        ExcelImportHeaderL.Reset();

        for RowNo := 2 to MaxRowNo do begin
            ExcelImportHeaderL.Init();
            ExcelImportHeaderL."Entry No" := 0;
            Evaluate(ExcelImportHeaderL.id_location, GetValueAtCell(RowNo, 1));
            Evaluate(ExcelImportHeaderL.id_communication, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportHeaderL.communication_number, GetValueAtCell(RowNo, 3));
            Evaluate(ExcelImportHeaderL.Belegsendeprofil, GetValueAtCell(RowNo, 4));
            Evaluate(ExcelImportHeaderL.kind_of_communication, GetValueAtCell(RowNo, 5));


            ExcelImportHeaderL.Insert();
        end;
    end;



    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    local procedure GetValueAtCellNumber(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('0');
    end;




    var
        MaxRowNo: integer;
        RowNo: integer;
        ColNo: integer;
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        FileName: text;
        SheetName: TExt;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
}
