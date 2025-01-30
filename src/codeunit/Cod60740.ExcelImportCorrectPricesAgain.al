codeunit 60740 ExcelImportCorrectPricesAgain
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
        ExcelImportOrders.SetRange(order_state, 'fakturiert');
        if ExcelImportOrders.FindSet() then
            repeat
                SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
                SalesLineL.SetRange("Document No.", ExcelImportOrders."order no");
                SalesLineL.SetRange(Type, SalesLineL.Type::Item);
                SalesLineL.SetRange("Quantity Invoiced", 0);
                SalesLineL.SetRange("No.", ExcelImportOrders."Artikelnr.");
                if SalesLineL.findfirst then begin
                    SalesLineL.SuspendStatusCheck(true);
                    SalesLineL.Validate("Unit Price", ExcelImportOrders."VK Netto");
                    if ExcelImportOrders."VK Netto" <> 0 then
                        SalesLineL.Validate("Line Amount", ExcelImportOrders."Zeilen Netto");
                    SalesLineL.modify();
                end;

                if ExcelImportOrders.Rechnungsrabatt <> 0 then begin
                    clear(SalesHeaderL);
                    SalesHeaderL.get(SalesHeaderL."Document Type"::Order, SalesLineL."Document No.");
                    InvoiceDiscountL := GetInvoiceDiscountAmount(SalesHeaderL, ExcelImportOrders.Rechnungsrabatt);
                    if InvoiceDiscountL <> 0 then
                        SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountL, SalesHeaderL);
                end;

            until ExcelImportOrders.next() = 0;

        ExcelImportOrders.Reset();
        ExcelImportOrders.SetRange(schaltung_state, 'fakturiert');
        if ExcelImportOrders.FindSet() then
            repeat
                SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
                SalesLineL.SetRange("Document No.", ExcelImportOrders."order no");
                SalesLineL.SetRange(Type, SalesLineL.Type::Item);
                SalesLineL.SetRange("Quantity Invoiced", 0);
                SalesLineL.SetRange("No.", ExcelImportOrders."Artikelnr.");
                if SalesLineL.FindFirst() then begin
                    SalesLineL.SuspendStatusCheck(true);
                    SalesLineL.validate("Unit Price", 0);
                    SalesLineL.modify();
                end;

                if ExcelImportOrders.Rechnungsrabatt <> 0 then begin
                    clear(SalesHeaderL);
                    SalesHeaderL.get(SalesHeaderL."Document Type"::Order, SalesLineL."Document No.");
                    InvoiceDiscountL := GetInvoiceDiscountAmount(SalesHeaderL, ExcelImportOrders.Rechnungsrabatt);
                    if InvoiceDiscountL <> 0 then
                        SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountL, SalesHeaderL);
                end;
            until ExcelImportOrders.next() = 0;

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
