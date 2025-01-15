codeunit 60730 ExcelImportProcessorEmail
{
    TableNo = "Excel Import Header Email";
    trigger OnRun()
    var
        CustomerL: Record Customer;
    begin
        CustomerL.setrange(vv_id_location, Rec.id_location);
        CustomerL.FindFirst();

        CustomerL."E-Mail" := Rec.communication_number;
        CustomerL."Document Sending Profile" := 'EMAIL';
        CustomerL.modify();

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
            Evaluate(ExcelImportHeaderL.id_juristic_person, GetValueAtCell(RowNo, 1));
            Evaluate(ExcelImportHeaderL.Debitorennr, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportHeaderL.customer_id, GetValueAtCell(RowNo, 3));
            Evaluate(ExcelImportHeaderL.customer_type, GetValueAtCell(RowNo, 4));
            Evaluate(ExcelImportHeaderL.Gesperrt, GetValueAtCell(RowNo, 5));
            Evaluate(ExcelImportHeaderL."SEPA Abo", GetValueAtCell(RowNo, 6));
            Evaluate(ExcelImportHeaderL."Zahlungsformcode SEPA ABO", GetValueAtCell(RowNo, 7));
            Evaluate(ExcelImportHeaderL."SEPA allgemein", GetValueAtCell(RowNo, 8));
            Evaluate(ExcelImportHeaderL."Zahlungsformcode SEPA allg", GetValueAtCell(RowNo, 9));
            Evaluate(ExcelImportHeaderL."Belegsendeprofil ABO", GetValueAtCell(RowNo, 10));
            Evaluate(ExcelImportHeaderL.Zahlungsbedingungscode, GetValueAtCell(RowNo, 11));
            Evaluate(ExcelImportHeaderL.adv_zahlungsziel, GetValueAtCell(RowNo, 12));
            Evaluate(ExcelImportHeaderL.anz_e_invoice, GetValueAtCell(RowNo, 13));
            Evaluate(ExcelImportHeaderL."Belegsendeprofil Allgemein", GetValueAtCell(RowNo, 14));


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
