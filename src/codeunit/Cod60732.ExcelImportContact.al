codeunit 60732 ExcelImportProcessorContact
{
    TableNo = "Excel Import Contact";
    trigger OnRun()
    var
        ContactL: Record Contact;
        CustomerL: Record Customer;
        CountryRegionL: Record "Country/Region";
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        ContactL.Init();
        ContactL.Name := Rec.Name;
        ContactL.Type := ContactL.Type::Person;
        ContactL."id location" := Rec.id_location;
        ContactL."id juristic person" := Rec.id_juristic_person;

        CountryRegionL.SetRange(Name, Rec.Country);
        if CountryRegionL.FindFirst() then
            ContactL.Validate("Country/Region Code", CountryRegionL.Code);

        ContactL."Post Code" := Rec."postal code";
        ContactL.Address := Rec.street;
        ContactL.City := Rec.city;

        CustomerL.SetRange(vv_idjuristicperson, Rec.id_juristic_person);
        if CustomerL.FindFirst() then begin
            ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
            ContactBusinessRelation.SetRange("No.", CustomerL."No.");
            ContactBusinessRelation.Setrange("Business Relation Code", 'DEB');
            if ContactBusinessRelation.FindFirst() then
                ContactL.Validate("Company No.", ContactBusinessRelation."Contact No.");
        end;

        ContactL.insert(true);
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
        ExcelImportContactL: Record "Excel Import Contact";
        LineNo: Integer;
    begin
        LineNo := 0;
        ExcelImportContactL.Reset();

        for RowNo := 2 to MaxRowNo do begin
            ExcelImportContactL.Init();
            ExcelImportContactL."Entry No" := 0;
            Evaluate(ExcelImportContactL.id_location, GetValueAtCell(RowNo, 1));
            Evaluate(ExcelImportContactL.Email, GetValueAtCell(RowNo, 2));
            Evaluate(ExcelImportContactL.id_juristic_person, GetValueAtCell(RowNo, 3));
            Evaluate(ExcelImportContactL.Name, GetValueAtCell(RowNo, 4));
            Evaluate(ExcelImportContactL.position, GetValueAtCell(RowNo, 5));
            Evaluate(ExcelImportContactL.Country, GetValueAtCell(RowNo, 6));
            Evaluate(ExcelImportContactL."postal code", GetValueAtCell(RowNo, 7));
            Evaluate(ExcelImportContactL.city, GetValueAtCell(RowNo, 8));
            Evaluate(ExcelImportContactL.street, GetValueAtCell(RowNo, 9));
            ExcelImportContactL.Insert();
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
