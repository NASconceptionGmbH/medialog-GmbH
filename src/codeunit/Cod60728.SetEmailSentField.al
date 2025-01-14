codeunit 60728 SetSetEmailFields
{
    Permissions = tabledata "Sales Invoice Header" = rimd;

    procedure SetEmailFields()
    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        ExcelImportHeaderL: Record "Excel Import Header";
    begin
        ExcelImportHeaderL.SetFilter("Invoice No", '<>%1', '');
        if ExcelImportHeaderL.FindSet() then
            repeat
                if SalesInvoiceHeaderL.get(ExcelImportHeaderL."Invoice No") then begin
                    SalesInvoiceHeaderL."Subscription Email Sent" := true;
                    SalesInvoiceHeaderL.Modify();
                end;

            until ExcelImportHeaderL.next() = 0;
    end;

    procedure Transform()
    var
        ExcelImportHeaderL: Record "Excel Import Header";
    begin
        if ExcelImportHeaderL.FindSet() then
            repeat
                ExcelImportHeaderL."Invoice No" := CopyStr(ExcelImportHeaderL.Description, StrLen(ExcelImportHeaderL.Description) - 8, 9);
                ExcelImportHeaderL.Modify();

            until ExcelImportHeaderL.next() = 0;
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
        ExcelImportHeaderL: Record "Excel Import Header";
        LineNo: Integer;
    begin
        LineNo := 0;
        ExcelImportHeaderL.Reset();

        for RowNo := 2 to MaxRowNo do begin
            ExcelImportHeaderL.Init();
            ExcelImportHeaderL."Entry No" := 0;
            Evaluate(ExcelImportHeaderL.Description, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportHeaderL.Time, GetValueAtCell(RowNo, 3));
            Evaluate(ExcelImportHeaderL.Date, GetValueAtCell(RowNo, 4));

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
