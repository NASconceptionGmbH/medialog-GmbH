codeunit 60733 ExcelImportProcessorOrders
{
    TableNo = "Excel Import Orders";
    trigger OnRun()
    var
        SalesHeaderL: Record "Sales Header";
        SalesLineL: Record "Sales Line";
        LineNoL: Integer;
        ContactL: Record Contact;
    begin
        if not SalesHeaderL.get(SalesHeaderL."Document Type"::Order, Rec."order no") then begin
            SalesHeaderL.init();
            SalesHeaderL."Document Type" := SalesHeaderL."Document Type"::Order;
            SalesHeaderL."No." := Rec."order no";
            SalesHeaderL.validate("Sell-to Customer No.", Rec.Debitor);
            SalesHeaderL.validate("Prices Including VAT", false);
            SalesHeaderL.validate("Order Date", Rec."Auftragsdatum");
            SalesHeaderL."Your Reference" := CopyStr(Rec."Ihre Referenz", 1, 35);
            SalesHeaderL."order state" := rec.order_state;

            if Rec."Debitor Kontakt" <> '' then begin
                ContactL.SetRange("id location", Rec."Debitor Kontakt");
                if ContactL.FindFirst() then begin
                    SalesHeaderL.validate("Sell-to Contact No.", ContactL."No.");
                end;
            end;

            if rec."Liefern an Debitor" <> '' then
                SalesHeaderL.validate("Ship-To Customer No.", Rec."Liefern an Debitor");

            if rec."Liefern an Kontakt" <> '' then begin
                ContactL.Reset();
                ContactL.SetRange("id location", rec."Liefern an Kontakt");
                if ContactL.findfirst() then begin
                    SalesHeaderL."Ship-to Contact" := ContactL.Name;
                end;
            end;

            SalesHeaderL."interfall Sammelrechnung" := rec.interfall_sammelrechnung;
            SalesHeaderL."Payment Terms Code" := rec.Zahlungsbedingung;
            SalesHeaderL."External Document No." := CopyStr(rec."Externe Belegnummer", 1, 35);
            //??
            SalesHeaderL.validate("Posting Date", rec.Buchungsdatum);

            SalesHeaderL.Insert();
        end;

        LineNoL := GetLineNo(Rec."order no");
        SalesLineL.init();
        SalesLineL."Document Type" := SalesLineL."Document Type"::Order;
        SalesLineL."Document No." := SalesHeaderL."No.";
        SalesLineL."Line No." := LineNoL;
        SalesLineL.Type := SalesLineL.Type::Item;
        SalesLineL.validate("No.", rec."Artikelnr.");
        SalesLineL.validate("Variant Code", Rec.Variantencode);
        SalesLineL.validate(Quantity, 1);
        SalesLineL.Validate("Unit Price", Rec."VK Netto");
        SalesLineL.Validate("Line Discount %", Rec.Zeilenrabatt);
        SalesLineL.Placement := copystr(rec.Platzierung, 1, 80);
        //SalesLineL."Posting Date" := rec.Buchungsdatum  ??
        SalesLineL.insert();

        LineNoL += 10000;
        if Rec.Zusatzzeile <> '' then begin

        end;


        //rechnungsrabatt!!

    end;

    local procedure GetLineNo(DocNoV: COde[20]): integer
    var
        SalesLineL: Record "Sales Line";
    begin
        SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
        SalesLineL.SetRange("Document No.", DocNoV);
        if SalesLineL.FindLast() then
            exit(SalesLineL."Line No." + 10000);

        exit(10000);
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
        ExcelImportOrdersL: Record "Excel Import Orders";
        LineNo: Integer;
    begin
        LineNo := 0;
        ExcelImportOrdersL.Reset();

        for RowNo := 2 to MaxRowNo do begin
            ExcelImportOrdersL.Init();
            ExcelImportOrdersL."Entry No" := 0;
            Evaluate(ExcelImportOrdersL."Artikelnr.", GetValueAtCell(RowNo, 1));
            Evaluate(ExcelImportOrdersL.Variantencode, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportOrdersL."order no", GetValueAtCell(RowNo, 3));
            Evaluate(ExcelImportOrdersL."Auftragsdatum", GetValueAtCell(RowNo, 4));
            Evaluate(ExcelImportOrdersL."Ihre Referenz", GetValueAtCell(RowNo, 5));
            Evaluate(ExcelImportOrdersL."order_state", GetValueAtCell(RowNo, 6));
            Evaluate(ExcelImportOrdersL.Debitor, GetValueAtCell(RowNo, 7));
            Evaluate(ExcelImportOrdersL."Debitor Kontakt", GetValueAtCell(RowNo, 8));
            Evaluate(ExcelImportOrdersL."Liefern an Debitor", GetValueAtCell(RowNo, 9));
            Evaluate(ExcelImportOrdersL."Liefern an Kontakt", GetValueAtCell(RowNo, 10));
            Evaluate(ExcelImportOrdersL.interfall_sammelrechnung, GetValueAtCell(RowNo, 11));
            Evaluate(ExcelImportOrdersL.Zahlungsbedingung, GetValueAtCell(RowNo, 12));
            Evaluate(ExcelImportOrdersL.Belegsendeprofil, GetValueAtCell(RowNo, 13));
            Evaluate(ExcelImportOrdersL."Email Rechnung", GetValueAtCell(RowNo, 14));
            Evaluate(ExcelImportOrdersL."Debitor Kontakt Email", GetValueAtCell(RowNo, 15));
            Evaluate(ExcelImportOrdersL."Email Agenturen Rechnung", GetValueAtCell(RowNo, 16));
            Evaluate(ExcelImportOrdersL.Buchungsdatum, GetValueAtCell(RowNo, 17));
            Evaluate(ExcelImportOrdersL.Platzierung, GetValueAtCell(RowNo, 18));
            Evaluate(ExcelImportOrdersL.Zusatzzeile, GetValueAtCell(RowNo, 19));
            Evaluate(ExcelImportOrdersL."Externe Belegnummer", GetValueAtCell(RowNo, 20));
            Evaluate(ExcelImportOrdersL.Zeilenrabatt, GetValueAtCellNumber(RowNo, 22));
            Evaluate(ExcelImportOrdersL."Rabatt Betrag", GetValueAtCellNumber(RowNo, 23));
            Evaluate(ExcelImportOrdersL."VK Netto", GetValueAtCellNumber(RowNo, 24));
            Evaluate(ExcelImportOrdersL."Zeilen Netto", GetValueAtCellNumber(RowNo, 25));
            Evaluate(ExcelImportOrdersL.MwSt, GetValueAtCellNumber(RowNo, 27));
            Evaluate(ExcelImportOrdersL.Rechnungsrabatt, GetValueAtCellNumber(RowNo, 28));
            ExcelImportOrdersL.Insert();
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
