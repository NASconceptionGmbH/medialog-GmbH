codeunit 60727 "OSS Management"
{
    procedure ExtendedGetPostingGroups(Var CustomerR: Record Customer; DestinationCountry: Code[20]; B2B: Boolean): Boolean
    var
        ExtendedPostingMatrix: Record "Extended Posting Matrix";
    begin
        ExtendedPostingMatrix.SetRange("Country Code", CustomerR."Country/Region Code");
        ExtendedPostingMatrix.SetRange("Destination Country Code", DestinationCountry);
        ExtendedPostingMatrix.SetRange("VAT No.", b2b);
        if ExtendedPostingMatrix.FindFirst() then begin
            CustomerR."Gen. Bus. Posting Group" := ExtendedPostingMatrix."General Bus. Posting Group";
            CustomerR."VAT Bus. Posting Group" := ExtendedPostingMatrix."VAT Bus. Posting Group";
            CustomerR."Customer Posting Group" := ExtendedPostingMatrix."Customer Posting Group";
            CustomerR."Prices Including VAT" := ExtendedPostingMatrix."Price Incl. VAT";
            exit(true);
        end;
        exit(false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        CustomerL: Record Customer;
        CustomerL2: Record Customer;
        ReleaseL: Boolean;
        PurchaseHeaderL: Record "Purchase Header";
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        IssueSetupL: Record "Issue Setup";
        ShipToCust: Record Customer;
        B2B: Boolean;
        InvoiceDiscountL: Decimal;
        SalesCalcDiscountByTypeL: Codeunit "Sales - Calc Discount By Type";
    begin
        IssueSetupL.Get();
        B2B := false;
        If IssueSetupL."Enable OSS" then begin
            CustomerL.Get(SalesHeader."Sell-to Customer No.");
            CustomerL2.get(SalesHeader."Sell-to Customer No.");

            if (CustomerL."VAT Registration No." <> '') OR (CustomerL.GLN <> '') then begin
                B2B := true;
            end;

            if ShipToCust.Get(SalesHeader."Ship-To Customer No.") then begin
                if (ShipToCust."VAT Registration No." <> '') or (ShipToCust.GLN <> '') then
                    B2B := true
                else
                    B2B := false;
            end;

            if ExtendedGetPostingGroups(CustomerL2, SalesHeader."Ship-to Country/Region Code", B2B) then begin
                IF (CustomerL."Gen. Bus. Posting Group" <> CustomerL2."Gen. Bus. Posting Group") OR
                (CustomerL."VAT Bus. Posting Group" <> CustomerL2."VAT Bus. Posting Group") OR
                (CustomerL."Customer Posting Group" <> CustomerL2."Customer Posting Group") then begin
                    InvoiceDiscountL := SalesHeader."Invoice Discount Value";
                    SalesHeader.SetHideValidationDialog(true);
                    SalesHeader.Validate("Prices Including VAT", CustomerL2."Prices Including VAT");
                    SalesHeader.Validate("Gen. Bus. Posting Group", CustomerL2."Gen. Bus. Posting Group");
                    SalesHeader.Validate("VAT Bus. Posting Group", CustomerL2."VAT Bus. Posting Group");
                    SalesHeader.Validate("Customer Posting Group", CustomerL2."Customer Posting Group");
                    SalesHeader.Modify();

                    if (InvoiceDiscountL <> 0) AND (SalesHeader."Invoice Discount Value" = 0) then
                        SalesCalcDiscountByTypeL.ApplyInvDiscBasedOnAmt(InvoiceDiscountL, SalesHeader);
                end;
            end;
        end
    end;

    // SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountL, SalesHeaderL);
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnRecreateSalesLinesOnAfterProcessTempSalesLines', '', false, false)]
    local procedure RecreateSalesLinesOnAfterProcessTempSalesLines(var TempSalesLine: Record "Sales Line" temporary; ChangedFieldName: Text[100]; var SalesHeader: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
        SalesHeaderL: Record "Sales Header";
    begin
        if ChangedFieldName in [SalesHeader.FieldCaption("VAT Bus. Posting Group"), SalesHeader.FieldCaption("Customer Posting Group"), SalesHeader.fieldcaption("Gen. Bus. Posting Group")] then begin

            TempSalesLine.SetRange(Type, TempSalesLine.Type::Item);
            if TempSalesLine.FindSet() then
                repeat
                    if SalesLineL.get(TempSalesLine."Document Type", TempSalesLine."Document No.", TempSalesLine."Line No.") then begin
                        SalesLineL.validate("Line Discount %", TempSalesLine."Line Discount %");
                        SalesLineL."Type of Business" := TempSalesLine."Type of Business";
                        SalesLineL.modify();
                    end;
                until TempSalesLine.next() = 0;
        end;
    end;
}