codeunit 60739 ExcelImportCorrectPrices
{

    trigger OnRun()
    var
        SalesHeaderL: Record "Sales Header";
        SalesLineL: Record "Sales Line";
        LineNoL: Integer;
        ContactL: Record Contact;
        InvoiceDiscountL: Decimal;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        ExcelImportOrders: Record "Excel Import Orders";
    begin

        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetRange("Quantity Invoiced", 0);
        if SalesLineL.FindSet(true) then
            repeat
                ExcelImportOrders.SetRange("BC Order No.", SalesLineL."Document No.");
                ExcelImportOrders.SetRange("Artikelnr.", SalesLineL."No.");
                if ExcelImportOrders.FindFirst() then begin
                    if ExcelImportOrders."VK Netto" <> 0 then begin
                        if ExcelImportOrders.order_state <> 'fakturiert' then begin
                            SalesLineL.Validate("Unit Price", ExcelImportOrders."VK Netto");
                            SalesLineL.Validate("Line Amount", ExcelImportOrders."Zeilen Netto");
                            SalesLineL.modify();

                            if ExcelImportOrders.Rechnungsrabatt <> 0 then begin
                                clear(SalesHeaderL);
                                SalesHeaderL.get(SalesHeaderL."Document Type"::Order, SalesLineL."Document No.");
                                InvoiceDiscountL := GetInvoiceDiscountAmount(SalesHeaderL, ExcelImportOrders.Rechnungsrabatt);
                                if InvoiceDiscountL <> 0 then
                                    SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountL, SalesHeaderL);
                            end;
                        end else begin
                            SalesLineL.validate("Unit Price", 0);
                            SalesLineL.modify();
                        end;
                    end;
                end;
            until SalesLineL.next() = 0;
    end;

    local procedure GetInvoiceDiscountAmount(SalesHeader: record "Sales Header"; DiscountPctV: Decimal): decimal;
    var
        DocumentTotals: Codeunit "Document Totals";
        AmountWithDiscountAllowed: Decimal;
        InvoiceDiscountAmount: decimal;
        CurrencyL: Record Currency;
        TotalSalesline: record "Sales Line";
    begin
        TotalSalesline.SetRange("Document Type", SalesHeader."Document Type");
        TotalSalesline.SetRange("Document No.", SalesHeader."No.");
        if TotalSalesline.FindSet() then begin

            CurrencyL.InitRoundingPrecision();
            AmountWithDiscountAllowed := DocumentTotals.CalcTotalSalesAmountOnlyDiscountAllowed(TotalSalesLine);
            InvoiceDiscountAmount := Round(AmountWithDiscountAllowed * DiscountPctV / 100, CurrencyL."Amount Rounding Precision");
            exit(InvoiceDiscountAmount);
        end;
        exit(0);
    end;


}
