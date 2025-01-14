codeunit 60710 "Import Buffer Processer"
{
    TableNo = MediaSuiteImportBuffer;
    trigger OnRun()
    var
        MediaSuiteImportBufferL: Record MediaSuiteImportBuffer;
        SalesHeaderL: Record "Sales Header";
        SalesLineL2, SalesLineL : Record "Sales Line";
        UnitPriceL: Decimal;
        LineDisc: Decimal;
        SalesCalcDiscountByTypeL: Codeunit "Sales - Calc Discount By Type";
        InvDisc: Decimal;
        CustomerL: Record Customer;
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CountryRegionL: Record "Country/Region";
        VATBusinessPostingGroupL: Record "VAT Business Posting Group";
        GenBusinessPostingGroupL: Record "Gen. Business Posting Group";
        ItemL: Record Item;
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        NextLine: Integer;
    begin
        MediaSuiteImportBufferL := Rec;
        Clear(SalesHeaderL);
        IF MediaSuiteImportBufferL."Sell-to Customer No." = '' then begin
            Clear(CustomerL);
            CustomerL.Init();
            CustomerL.Insert(True);
            CustomerL.Name := MediaSuiteImportBufferL."Sell-to Customer Name";
            CustomerL."Name 2" := MediaSuiteImportBufferL."Sell-to Customer Name 2";
            CustomerL.Address := MediaSuiteImportBufferL."Sell-to Address";
            CustomerL."Post Code" := MediaSuiteImportBufferL."Sell-to Customer Post Code";
            CustomerL.City := MediaSuiteImportBufferL."Sell-to City";
            //CustomerL.Contact := "Sell-to Contact VN" + '' + "Sell-to Contact LN";
            CustomerL."CRM GUID" := MediaSuiteImportBufferL."Sell-To CRM ID";
            CustomerL."Country/Region Code" := MediaSuiteImportBufferL."Sell-to Customer Country Code";
            IF CustomerL."Country/Region Code" <> 'DE' then begin
                CountryRegionL.SetRange(Code, CustomerL."Country/Region Code");
                CountryRegionL.SetFilter("EU Country/Region Code", '<>%1', '');
                IF CountryRegionL.FindFirst() then begin
                    CustomerL."Customer Posting Group" := 'EU';

                    GenBusinessPostingGroupL.SetRange(Code, 'EU ' + CustomerL."Country/Region Code" + ' PRIVAT');
                    IF GenBusinessPostingGroupL.FindFirst() then
                        CustomerL."Gen. Bus. Posting Group" := GenBusinessPostingGroupL.Code
                    else
                        CustomerL."Gen. Bus. Posting Group" := 'EU';

                    VATBusinessPostingGroupL.SetRange(Code, 'EU ' + CustomerL."Country/Region Code" + ' PRIVAT');
                    IF VATBusinessPostingGroupL.FindFirst() then
                        CustomerL."VAT Bus. Posting Group" := VATBusinessPostingGroupL.Code
                    else
                        CustomerL."VAT Bus. Posting Group" := 'EU';
                end else begin
                    CustomerL."Customer Posting Group" := 'AUSLAND';
                    CustomerL."Gen. Bus. Posting Group" := 'DRITTLAND';
                    CustomerL."VAT Bus. Posting Group" := 'DRITTLAND';
                end;
            end else begin
                CustomerL."Customer Posting Group" := 'INLAND';
                CustomerL."Gen. Bus. Posting Group" := 'INLAND';
                CustomerL."VAT Bus. Posting Group" := 'INLAND';
            end;
            CustomerL.Modify();
            CRMIntegrationRecordL.Init();
            CRMIntegrationRecordL."CRM ID" := CustomerL."CRM GUID";
            CRMIntegrationRecordL."Integration ID" := CustomerL.SystemId;
            CRMIntegrationRecordL."Table ID" := 18;
            CRMIntegrationRecordL.Insert();
            MediaSuiteImportBufferL."Sell-to Customer No." := CustomerL."No.";
        end;
        IF MediaSuiteImportBufferL."Ship-To CRM ID" <> '' then begin
            Clear(CustomerL);
            CustomerL.Init();
            CustomerL.Insert(True);
            CustomerL.Name := MediaSuiteImportBufferL."Ship-to Customer Name";
            //CustomerL."Name 2" := "Sell-to Customer Name 2";
            CustomerL.Address := MediaSuiteImportBufferL."Ship-to Address 1";
            CustomerL."Address 2" := MediaSuiteImportBufferL."Ship-to Address 2";
            CustomerL."Post Code" := MediaSuiteImportBufferL."Ship-To Post Code";
            CustomerL.City := MediaSuiteImportBufferL."Ship-to City";
            //CustomerL.Contact := "Ship-to Contact VN" + '' + "Ship-to Contact LN";
            CustomerL."CRM GUID" := MediaSuiteImportBufferL."Ship-To CRM ID";
            CustomerL."Country/Region Code" := MediaSuiteImportBufferL."Ship-To County Code";
            IF CustomerL."Country/Region Code" <> 'DE' then begin
                CountryRegionL.SetRange(Code, CustomerL."Country/Region Code");
                CountryRegionL.SetFilter("EU Country/Region Code", '<>%1', '');
                IF CountryRegionL.FindFirst() then begin
                    CustomerL."Customer Posting Group" := 'EU';

                    GenBusinessPostingGroupL.SetRange(Code, 'EU ' + CustomerL."Country/Region Code" + ' PRIVAT');
                    IF GenBusinessPostingGroupL.FindFirst() then
                        CustomerL."Gen. Bus. Posting Group" := GenBusinessPostingGroupL.Code
                    else
                        CustomerL."Gen. Bus. Posting Group" := 'EU';

                    VATBusinessPostingGroupL.SetRange(Code, 'EU ' + CustomerL."Country/Region Code" + ' PRIVAT');
                    IF VATBusinessPostingGroupL.FindFirst() then
                        CustomerL."VAT Bus. Posting Group" := VATBusinessPostingGroupL.Code
                    else
                        CustomerL."VAT Bus. Posting Group" := 'EU';
                end else begin
                    CustomerL."Customer Posting Group" := 'AUSLAND';
                    CustomerL."Gen. Bus. Posting Group" := 'DRITTLAND';
                    CustomerL."VAT Bus. Posting Group" := 'DRITTLAND';
                end;
            end else begin
                CustomerL."Customer Posting Group" := 'INLAND';
                CustomerL."Gen. Bus. Posting Group" := 'INLAND';
                CustomerL."VAT Bus. Posting Group" := 'INLAND';
            end;
            CustomerL.Modify();
            CRMIntegrationRecordL.Init();
            CRMIntegrationRecordL."CRM ID" := CustomerL."CRM GUID";
            CRMIntegrationRecordL."Integration ID" := CustomerL.SystemId;
            CRMIntegrationRecordL."Table ID" := 18;
            CRMIntegrationRecordL.Insert();
            MediaSuiteImportBufferL."Ship-to Customer No." := CustomerL."No.";
        end;
        SalesHeaderL.Init();
        SalesHeaderL."Document Type" := SalesHeaderL."Document Type"::Order;
        SalesHeaderL.Insert(true);
        SalesHeaderL.Validate("Sell-to Customer No.", MediaSuiteImportBufferL."Sell-to Customer No.");
        SalesHeaderL."Sell-to Customer Name" := MediaSuiteImportBufferL."Sell-to Customer Name";
        SalesHeaderL."Sell-to Customer Name 2" := MediaSuiteImportBufferL."Sell-to Customer Name 2";
        SalesHeaderL."Sell-to Address" := MediaSuiteImportBufferL."Sell-to Address";
        SalesHeaderL."Sell-to City" := MediaSuiteImportBufferL."Sell-to City";
        SalesHeaderL."Sell-to Post Code" := MediaSuiteImportBufferL."Sell-to Customer Post Code";
        SalesHeaderL."Sell-to Contact" := MediaSuiteImportBufferL."Sell-to Contact VN" + ' ' + MediaSuiteImportBufferL."Sell-to Contact LN";
        Evaluate(SalesHeaderL."Order Date", '21112022');
        Evaluate(SalesHeaderL."Posting Date", '21112022');
        Evaluate(SalesHeaderL."Document Date", '21112022');
        Evaluate(SalesHeaderL."Shipment Date", '21112022');
        SalesHeaderL.validate("Payment Terms Code", '60');
        SalesHeaderL.Validate("Payment Method Code", 'RECHNUNG');
        SalesHeaderL."Ship-To Customer No." := MediaSuiteImportBufferL."Ship-to Customer No.";
        SalesHeaderL."Ship-to Name" := MediaSuiteImportBufferL."Ship-to Customer Name";
        SalesHeaderL."Ship-to Address" := MediaSuiteImportBufferL."Ship-to Address 1";
        SalesHeaderL."Ship-to Address 2" := MediaSuiteImportBufferL."Ship-to Address 2";
        SalesHeaderL."Ship-to City" := MediaSuiteImportBufferL."Ship-to City";
        SalesHeaderL."Ship-to Post Code" := MediaSuiteImportBufferL."Ship-To Post Code";
        SalesHeaderL."Ship-to Contact" := MediaSuiteImportBufferL."Ship-to Contact VN" + ' ' + MediaSuiteImportBufferL."Ship-to Contact LN";
        SalesHeaderL."Ship-to Country/Region Code" := MediaSuiteImportBufferL."Ship-To County Code";
        SalesHeaderL."External Document No." := MediaSuiteImportBufferL."External Document No.";
        SalesHeaderL."Your Reference" := MediaSuiteImportBufferL."Youre Reference";
        SalesHeaderL.Clerk := 'VERTRIEB';
        SalesHeaderL."Salesperson Code" := '';
        SalesHeaderL."Location Code" := '';
        SalesHeaderL.Validate("Shipping Agent Code", '');
        SalesHeaderL.Imported := true;
        //SalesHeaderL."Sell-to Contact" := Rec.Contact;
        SalesHeaderL."Salesperson Code" := MediaSuiteImportBufferL."Salesperson";
        // If Rec.Commission <> '' then begin
        //     Rec.Commission := ConvertStr(Rec.Commission, '.', ',');
        //     Evaluate(SalesHeaderL."Commission Salesperson", Rec.Commission);
        // end;
        SalesHeaderL."Salesperson Code 2" := MediaSuiteImportBufferL."Salesperson 2";
        // If Rec."Commission 2" <> '' then begin
        //     Rec."Commission 2" := ConvertStr(Rec."Commission 2", '.', ',');
        //     Evaluate(SalesHeaderL."Commission Salesperson 2", Rec."Commission 2");
        // end;
        SalesHeaderL.Modify();
        SalesLineL.Init();
        SalesLineL."Document Type" := SalesLineL."Document Type"::Order;
        SalesLineL."Document No." := SalesHeaderL."No.";
        SalesLineL."Line No." := 10000;
        SalesLineL.Type := SalesLineL.Type::Item;
        If ItemL.Get(MediaSuiteImportBufferL."Item No.") then begin
            ItemL.Blocked := false;
            ItemL.Modify();
        end;
        SalesLineL.Validate("No.", MediaSuiteImportBufferL."Item No.");
        if MediaSuiteImportBufferL."Item Description" <> '' then
            SalesLineL.Description := MediaSuiteImportBufferL."Item Description";
        //SalesLineL.Validate("Variant Code", Rec."Variant Code");
        MediaSuiteImportBufferL."Unit Price" := ConvertStr(MediaSuiteImportBufferL."Unit Price", '.', ',');
        Evaluate(UnitPriceL, MediaSuiteImportBufferL."Unit Price");
        SalesLineL.Validate("Unit Price", UnitPriceL);
        MediaSuiteImportBufferL."Line Discount" := ConvertStr(MediaSuiteImportBufferL."Line Discount", '.', ',');
        IF MediaSuiteImportBufferL."Line Discount" <> '' then begin
            Evaluate(LineDisc, MediaSuiteImportBufferL."Line Discount");
            SalesLineL.Validate("Line Discount %", LineDisc);
        end;
        // SalesLineL.Motive := Rec.Motiv;
        // SalesLineL.Placement := Rec.Format;
        SalesLineL."Type of Business" := MediaSuiteImportBufferL."Type of Business";
        SalesLineL.Insert();
        SalesHeaderL."Shortcut Dimension 1 Code" := SalesLineL."Shortcut Dimension 1 Code";
        SalesHeaderL.Modify();
        IF MediaSuiteImportBufferL."Comment Sales Line" <> '' then begin
            SalesLineL.Init();
            SalesLineL."Document Type" := SalesLineL."Document Type"::Order;
            SalesLineL."Document No." := SalesHeaderL."No.";
            SalesLineL."Line No." := 20000;
            SalesLineL.Type := SalesLineL.Type::" ";
            SalesLineL.Description := MediaSuiteImportBufferL."Comment Sales Line";
            SalesLineL.Insert();
        end;
        // To add extended Text
        SalesLineL2.Reset();
        SalesLineL2.SetRange("Document Type", SalesLineL."Document Type");
        SalesLineL2.SetRange("Document No.", SalesLineL."Document No.");
        if SalesLineL2.FindLast() then
            NextLine := SalesLineL2."Line No."
        else
            NextLine := 0;
        ExtendedTextLine.Reset();
        ExtendedTextLine.SetRange("Table Name", Enum::"Extended Text Table Name"::Item);
        ExtendedTextLine.SetRange("No.", MediaSuiteImportBufferL."Item No.");
        if ExtendedTextLine.FindSet() then begin
            repeat
                SalesLineL.Init();
                SalesLineL."Document Type" := SalesLineL."Document Type"::Order;
                SalesLineL."Document No." := SalesHeaderL."No.";
                SalesLineL."Line No." := NextLine + 100;
                SalesLineL.Type := SalesLineL.Type::" ";
                SalesLineL.Description := ExtendedTextLine.Text;
                SalesLineL.Insert();
                NextLine += 100;
            until ExtendedTextLine.Next() = 0;
        end;
        // To add extended Text
        // Rec."Invoice Discount" := ConvertStr(Rec."Invoice Discount", '.', ',');
        // Evaluate(InvDisc, Rec."Invoice Discount");
        // IF InvDisc > 0 then begin
        //     InvDisc := (SalesLineL."Unit Price" * InvDisc) / 100;
        //     SalesCalcDiscountByTypeL.ApplyInvDiscBasedOnAmt(InvDisc, SalesHeaderL);
        //     SalesHeaderL.Modify();
        // end;
        MediaSuiteImportBufferL.Delete();
        Commit();
    end;

    var
        myInt: Integer;
}