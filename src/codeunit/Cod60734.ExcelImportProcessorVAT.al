codeunit 60734 ExcelImportProcessorVAT
{
    TableNo = "Excel Import Header VAT";
    trigger OnRun()
    var
        CustomerL: Record Customer;
    begin
        CustomerL.setrange(vv_id_location, Rec.id_location);
        if not CustomerL.FindFirst() then begin
            CustomerL.Reset();
            CustomerL.SetRange(vv_idjuristicperson, Rec.id_juristic_person);
            CustomerL.FindFirst()
        end;

        CustomerL.validate("VAT Registration No.", copystr(Rec."ust id", 1, 20));
        CustomerL.Modify();
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
        ExcelImportHeaderL: Record "Excel Import Header VAT";
        LineNo: Integer;
    begin
        LineNo := 0;
        ExcelImportHeaderL.Reset();

        for RowNo := 2 to MaxRowNo do begin
            ExcelImportHeaderL.Init();
            ExcelImportHeaderL."Entry No" := 0;
            Evaluate(ExcelImportHeaderL.id_location, GetValueAtCell(RowNo, 1));
            Evaluate(ExcelImportHeaderL.id_juristic_person, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportHeaderL."ust id", GetValueAtCell(RowNo, 3));

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
