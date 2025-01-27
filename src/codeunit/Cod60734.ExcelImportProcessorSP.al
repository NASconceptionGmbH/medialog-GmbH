codeunit 60734 ExcelImportProcessorSP
{
    TableNo = "Excel Import Header SP";
    trigger OnRun()
    var
        SalesHeaderL: Record "Sales Header";
    begin
        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
        SalesHeaderL.SetRange("No.", Rec."order no");
        if SalesHeaderL.FindFirst() then begin
            SalesHeaderL."Salesperson Code" := Rec.Salesperson;
            SalesHeaderL.Clerk := Rec.Clerk;
            SalesHeaderL.modify();
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
        ExcelImportHeaderL: Record "Excel Import Header SP";
        LineNo: Integer;
    begin
        LineNo := 0;
        ExcelImportHeaderL.Reset();

        for RowNo := 2 to MaxRowNo do begin
            ExcelImportHeaderL.Init();
            ExcelImportHeaderL."Entry No" := 0;
            Evaluate(ExcelImportHeaderL."order no", GetValueAtCell(RowNo, 1));
            Evaluate(ExcelImportHeaderL.Salesperson, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportHeaderL.clerk, GetValueAtCell(RowNo, 3));

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
