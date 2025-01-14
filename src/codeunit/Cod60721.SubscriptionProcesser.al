codeunit 60721 SubscriptionProcesser
{
    TableNo = Subscriptions;

    trigger OnRun()
    begin
        CreateOrder(Rec);
    end;

    procedure CreateOrder(var SubscriptionR: Record Subscriptions)
    var
        SalesHeaderL: Record "Sales Header";
        SalesLineL: Record "Sales Line";
        SalesLineL2: Record "Sales Line";
        SalesExplodeBOML: Codeunit "Sales-Explode BOM";
        ItemL: Record Item;
        LineNoL: integer;
        ItemNoL: COde[20];
        NoItemFound: Label 'Kein Artikel für das Jahr %1 mit Basis Artikel %2 und Kategorie %3 gefunden.';
        ZeroGuidL: Guid;
        NextInvoiceYearL: integer;
        SubscriptionHelperL: Codeunit SubscriptionHelper;
        IssueSetupL: Record "Issue Setup";
        ZeroDateFormula: DateFormula;
        QuantityL: Decimal;
        DiscountPct: decimal;
        InvoiceDiscountL: Decimal;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        SmallBusinessCampusL: boolean;
        CategoryL: Code[20];
        CustomerL: record Customer;
        EnvironmentInformationL: Codeunit "Environment Information";
        SkipCRMFunctionality: Boolean;
        SubYearSubsriptionL: Boolean;
    begin
        IssueSetupL.Get();
        SubscriptionR.TestField(AccountNo);
        SubscriptionR.TestField("Product No.");

        NextInvoiceYearL := Date2DMY(today, 3) + 1;
        if Date2DMY(today, 2) < 11 then begin
            SubYearSubsriptionL := true;
            NextInvoiceYearL -= 1;
        end;

        CategoryL := 'ABO';
        if SubscriptionR.cos_AboTypNew = SubscriptionR.cos_AboTypNew::"SmallBusiness/Campus" then begin
            CategoryL := 'ABO SMALL-CAMPUS';
            SmallBusinessCampusL := true;
        end;


        ItemNoL := SubscriptionHelperL.GetItemForYear(SubscriptionR."Product No.", NextInvoiceYearL, SmallBusinessCampusL);
        if ItemNoL = '' then
            Error(NoItemFound, NextInvoiceYearL, SubscriptionR."Product No.", CategoryL);

        ItemL.Get(ItemNoL);

        SalesHeaderL.Init();
        SalesHeaderL.SetHideValidationDialog(true);
        SalesHeaderL.validate("No.");
        SalesHeaderL."Document Type" := SalesHeaderL."Document Type"::Order;
        SalesHeaderL.Insert(true);

        SalesHeaderL.validate("Sell-to Customer No.", SubscriptionR.AccountNo);
        SalesHeaderL."Sell-to E-Mail" := SubscriptionR.vv_EMailInvoiceRecipient;

        SalesHeaderL."Subscription No." := CopyStr(SubscriptionR.cos_name, 1, 50);
        SalesHeaderL."External Document No." := CopyStr(SubscriptionR.cos_name, 1, 35);
        if SubscriptionR.cos_shiptoaddress <> ZeroGuidL then begin
            SalesHeaderL."Ship-to Name" := copystr(SubscriptionR.cos_shiptoaddressName, 1, 100);
            SalesHeaderL."Ship-to Name 2" := '';
            SalesHeaderL."Ship-to Address" := SubscriptionR.ShippingAddresStreet;
            SalesHeaderL."Ship-to Address 2" := SubscriptionR.ShippingAddresStreet2;
            SalesHeaderL."Ship-to Post Code" := SubscriptionR.ShippingAddresZipCode;
            SalesHeaderL."Ship-to City" := copystr(SubscriptionR.ShippingAddresCity, 1, 30);
            SalesHeaderL."Ship-to Country/Region Code" := SubscriptionR.ShippingAddresCountry;
            SalesHeaderL."Ship-to Contact" := copystr(SubscriptionR.ShipToContactName, 1, 100);
        end;

        if SubscriptionR.cos_billtoaddress <> ZeroGuidL then begin
            // SalesHeaderL."Bill-to Name":= Subscription.;
            SalesHeaderL."Bill-to Name" := copystr(SubscriptionR.cos_billtoaddressName, 1, 100);
            SalesHeaderL."Bill-to Name 2" := '';
            SalesHeaderL."Bill-to Address" := SubscriptionR.BillingAddresStreet;
            SalesHeaderL."Bill-to Address 2" := SubscriptionR.BillingAddresStreet2;
            SalesHeaderL."Bill-to Post Code" := SubscriptionR.BillingAddresZipCode;
            SalesHeaderL."Bill-to City" := copystr(SubscriptionR.BillingAddresCity, 1, 30);
            SalesHeaderL."Bill-to Country/Region Code" := SubscriptionR.BillingAddresCountry;
        end;
        SalesHeaderL."Subscription Order" := true;
        SalesHeaderL."Subscription Entry No." := SubscriptionR.cos_abonnementId;
        SalesHeaderL.SetHideValidationDialog(true);
        SalesHeaderL.validate("Location Code", '');
        SalesHeaderL.validate("Shortcut Dimension 1 Code", ItemL."Global Dimension 1 Code");
        SalesHeaderL."Shipping Agent Service Code" := '';
        SalesHeaderL."Shipping Agent Code" := '';
        SalesHeaderL."Shipping Time" := ZeroDateFormula;
        SalesHeaderL."Sell-to E-Mail" := SubscriptionR.vv_EMailInvoiceRecipient;
        SalesHeaderL."Sell-to Contact" := SubscriptionR.OrderByContactName;
        SalesHeaderL."Your Reference" := SubscriptionR.new_IhreReferenz;
        SalesHeaderL.Clerk := IssueSetupL."Sales Person Code";
        SalesHeaderL.cos_endofdeliveryyear := SubscriptionR.cos_endofdeliveryyear;
        SalesHeaderL.modify();


        LineNoL := 10000;
        SalesLineL.init;
        SalesLineL.SetHideValidationDialog(true);
        SalesLineL."Document No." := SalesHeaderL."No.";
        SalesLineL."Document Type" := SalesHeaderL."Document Type";
        SalesLineL."Line No." := LineNoL;
        SalesLineL.Insert();



        SalesLineL.Validate(Type, SalesLineL.Type::Item);
        SalesLineL.validate("no.", ItemL."No.");

        if SubscriptionR.cos_Menge <> '' then begin
            Evaluate(QuantityL, SubscriptionR.cos_Menge);
            SalesLineL.validate(Quantity, QuantityL);
        end else
            SalesLineL.validate(Quantity, 1);

        if SubscriptionR.cos_AboTypNew = SubscriptionR.cos_AboTypNew::"SmallBusiness/Campus" then
            SalesLineL.validate(Quantity, 1);

        SalesLineL.validate("Shortcut Dimension 1 Code", itemL."Global Dimension 1 Code");
        SalesLineL.validate("Deferral Code", SubscriptionR."Deferral Code"); //oder aus item?

        SalesLineL."Type of Business" := IssueSetupL."Type of Business";
        SalesLineL.modify();


        if EnvironmentInformationL.IsSandbox() then begin
            IssueSetupL.get();
            if IssueSetupL."SkipCRMOrderCreation(sandbox)" then
                SkipCRMFunctionality := true;
        end;

        if SkipCRMFunctionality = false then begin

            DiscountPct := GetDiscount(SubscriptionR);
            if DiscountPct <> 0 then begin
                InvoiceDiscountL := GetInvoiceDiscountAmount(SalesHeaderL, DiscountPct);
                if InvoiceDiscountL <> 0 then
                    SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountL, SalesHeaderL);
            end;
        end;


        SubscriptionR."Sales Order No." := SalesHeaderL."No.";
        SubscriptionR."Sales Order created at" := CurrentDateTime;
        if not SubYearSubsriptionL then
            SubscriptionR."Next Invoice Date" := CalcDate('<1Y>', today)
        else
            SubscriptionR."Next Invoice Date" := DMY2Date(Date2DMY(today, 1), 11, Date2DMY(today, 3));

        SubscriptionR.modify();

        if SubYearSubsriptionL then
            if IssueSetupL."Autom. Bom Explode" then begin
                ItemL.CalcFields("Assembly BOM");
                if ItemL."Assembly BOM" then begin
                    CODEUNIT.Run(CODEUNIT::"Sales-Explode BOM", SalesLineL);
                    if NextInvoiceYearL = Date2DMY(today, 3) then begin
                        SalesLineL2.SetRange("Document No.", SalesHeaderL."No.");
                        SalesLineL2.SetRange("Document Type", SalesHeaderL."Document Type");
                        SalesLineL2.SetRange(Type, SalesLineL2.Type::item);
                        if SalesLineL2.FindSet() then
                            repeat
                                ItemL.get(SalesLineL2."No.");
                                if ItemL."Item Category Code" <> 'DIGITALANTEIL' then begin
                                    if ItemL."Publication Date" < today then
                                        SalesLineL2.delete;
                                end
                            until SalesLineL2.next() = 0;
                    end;
                end;
            end;

    end;

    //   local procedure ValidateInvoiceDiscountAmount()
    // var
    //     SalesHeader: Record "Sales Header";
    //     ConfirmManagement: Codeunit "Confirm Management";
    // begin
    //     if SuppressTotals then
    //         exit;

    //     SalesHeader.Get("Document Type", "Document No.");
    //     if SalesHeader.InvoicedLineExists() then
    //         if not ConfirmManagement.GetResponseOrDefault(UpdateInvDiscountQst, true) then
    //             exit;

    //     SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, SalesHeader);
    //     DocumentTotals.SalesDocTotalsNotUpToDate();
    //     CurrPage.Update(false);
    // end;

    local procedure GetDiscount(var SubscriptionR: record Subscriptions): decimal;
    var
        CRMSalesorderL: Record "CRM Salesorder";
        CDScos_rabattkategorienL: Record "CDS cos_rabattkategorien";
    begin
        if CDScos_rabattkategorienL.Get(SubscriptionR.new_Rabatt) then begin
            SubscriptionR."Rabatt %" := CDScos_rabattkategorienL.cos_rabatt;
            SubscriptionR.Rabattname := CDScos_rabattkategorienL.cos_name;
            exit(CDScos_rabattkategorienL.cos_rabatt);
        end
        else begin
            SubscriptionR."Rabatt %" := 0;
            SubscriptionR.Rabattname := '';
        end;

        exit(0);
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


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnBeforeConfirmExplosion', '', false, false)]
    local procedure BeforeConfirmExplosion(var HideDialog: Boolean; var Selection: Integer)
    begin
        Selection := 2;
        Hidedialog := true;
    end;


}