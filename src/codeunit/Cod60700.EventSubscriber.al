codeunit 60700 "EventSubscriber"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', true, true)]
    local procedure HandleOnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";

        //KUNDENARTEN/Type of Business
        CDScos_typeofcustomer: Record "CDS cos_typeofcustomer";
        TypeofBusinessL: Record "Type of Business";


        //Customer 

        CRMAccount: Record "CRM Account";
        CUstomer: Record CUstomer;

        //Merkmal
        CDScos_characteristic: Record "CDS cos_characteristic";
        ItemAttributeValue: Record "Item Attribute Value";

        //Sparten
        CDScos_sparten: Record "CDS cos_sparten";


        //Item/Product
        Item: Record Item;
        CRMProduct: Record "CRM Product";

        //Invoices
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CRMInvoice: Record "CRM Invoice";
        SalesInvoiceLine: Record "Sales Invoice Line";
        CRMInvoicedetail: Record "CRM Invoicedetail";

        //sales Order
        CRMSalesorderdetail: Record "CRM Salesorderdetail";
        SalesLine: Record "Sales Line";

        TableFilterL: Text;

    begin
        //KUNDENARTEN/TypeOfBusiness
        TableFilterL := '';
        InsertIntegrationTableMapping(IntegrationTableMapping, 'Kundenarten', DATABASE::"Type of Business", DATABASE::"CDS cos_typeofcustomer", CDScos_typeofcustomer.FieldNo(cos_typeofcustomerId), CDScos_typeofcustomer.FieldNo(ModifiedOn), '', '', false, IntegrationFieldMapping.Direction::Bidirectional, TableFilterL);
        InsertIntegrationFieldMapping('Kundenarten', TypeofBusinessL.FieldNo(Code), CDScos_typeofcustomer.FieldNo(cos_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('Kundenarten', TypeofBusinessL.FieldNo("CRM GUID"), CDScos_typeofcustomer.FieldNo(cos_typeofcustomerId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        //CUSTOMER ID 
        InsertIntegrationFieldMapping('Customer', CUstomer.FieldNo("CRM GUID"), CRMAccount.FieldNo(AccountId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('No.', CUstomer.FieldNo("No."), CRMAccount.FieldNo(new_bccustomerno), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        //Product/Item ID
        InsertIntegrationFieldMapping('ITEM-PRODUCT', Item.FieldNo("CRM GUID"), CRMProduct.FieldNo(ProductId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        //MERKMAL
        TableFilterL := 'VERSION(1) SORTING(Field1,Field2) WHERE(Field1=1(21))';
        InsertIntegrationTableMapping(IntegrationTableMapping, 'Merkmale', DATABASE::"Item Attribute Value", DATABASE::"CDS cos_characteristic", CDScos_characteristic.FieldNo(cos_characteristicId), CDScos_characteristic.FieldNo(ModifiedOn), '', '', false, IntegrationFieldMapping.Direction::ToIntegrationTable, TableFilterL);
        InsertIntegrationFieldMapping('Merkmale', ItemAttributeValue.FieldNo(Value), CDScos_characteristic.FieldNo(cos_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('Merkmale', ItemAttributeValue.FieldNo("CRM GUID"), CDScos_characteristic.FieldNo(cos_characteristicId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        //SPARTEN
        TableFilterL := 'VERSION(1) SORTING(Field1,Field2) WHERE(Field1=1(19))';
        InsertIntegrationTableMapping(IntegrationTableMapping, 'Sparten', DATABASE::"Item Attribute Value", DATABASE::"CDS cos_sparten", CDScos_sparten.FieldNo(cos_spartenId), CDScos_sparten.FieldNo(ModifiedOn), '', '', false, IntegrationFieldMapping.Direction::ToIntegrationTable, TableFilterL);
        InsertIntegrationFieldMapping('Sparten', ItemAttributeValue.FieldNo(Value), CDScos_sparten.FieldNo(cos_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('Sparten', ItemAttributeValue.FieldNo("CRM GUID"), CDScos_sparten.FieldNo(cos_spartenId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        //PostInvoice HEADER-SELL TO
        TableFilterL := '';
        InsertIntegrationTableMapping(IntegrationTableMapping, 'INVOICE-HEAD-SELLTO', DATABASE::"Sales Invoice Header", DATABASE::"CRM Invoice", CRMInvoice.FieldNo(InvoiceId), CRMInvoice.FieldNo(ModifiedOn), '', '', false, IntegrationFieldMapping.Direction::ToIntegrationTable, TableFilterL);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("No."), 11, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Currency Code"), 74, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Due Date"), 68, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to Name"), 30, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to Address"), 33, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to Address 2"), 34, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to City"), 36, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to Country/Region Code"), 38, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to Post Code"), 39, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Ship-to County"), 37, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Shipment Date"), 67, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to Customer Name"), 42, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to Address"), 45, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to Address 2"), 46, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to City"), 48, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to Country/Region Code"), 50, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to Post Code"), 51, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Sell-to County"), 49, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Amount"), 19, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Amount Including VAT"), 16, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Invoice Discount Amount"), 14, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Shipping Agent Code"), 97, IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-HEAD-SELLTO', SalesInvoiceHeader.FieldNo("Payment Terms Code"), 96, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        //Posted Invoice LINES-SELL TO
        TableFilterL := '';
        InsertIntegrationTableMapping(IntegrationTableMapping, 'INVOICE-LINE-SELLTO', DATABASE::"Sales Invoice Line", DATABASE::"CRM Invoicedetail", CRMInvoicedetail.FieldNo(InvoiceDetailId), CRMInvoicedetail.FieldNo(ModifiedOn), '', '', false, IntegrationFieldMapping.Direction::ToIntegrationTable, TableFilterL);
        InsertIntegrationFieldMapping('INVOICE-LINE-SELLTO', SalesInvoiceLine.FieldNo(Quantity), 11, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-LINE-SELLTO', SalesInvoiceLine.FieldNo("Line Discount Amount"), 12, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-LINE-SELLTO', SalesInvoiceLine.FieldNo("Unit Price"), 15, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-LINE-SELLTO', 0, 21, IntegrationFieldMapping.Direction::ToIntegrationTable, '1', true, false);
        InsertIntegrationFieldMapping('INVOICE-LINE-SELLTO', SalesInvoiceLine.FieldNo(Amount), 16, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('INVOICE-LINE-SELLTO', SalesInvoiceLine.FieldNo("Amount Including VAT"), 19, IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20];
                                            TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer;
                                            IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean; SynchDirection: Option; TableFilterV: Text)
    begin
        CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, SynchDirection, TableFilterV);


    end;

    local procedure CreateRecord(

        MappingName: Code[20];
        TableNo: Integer;
         IntegrationTableNo: Integer;
          IntegrationTableUIDFieldNo: Integer;
          IntegrationTableModifiedFieldNo: Integer;
           TableConfigTemplateCode: Code[10];
           IntegrationTableConfigTemplateCode: Code[10];
            SynchOnlyCoupledRecords: Boolean;
            SynchDirection: Option;
            TableFilterV: Text)
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        OutStream: Outstream;
    begin

        if IntegrationTableMapping.Get(MappingName) then
            IntegrationTableMapping.Delete(true);
        IntegrationTableMapping.Init;
        IntegrationTableMapping.Name := MappingName;
        IntegrationTableMapping."Table ID" := TableNo;

        if TableFilterV <> '' then begin
            IntegrationTableMapping."Table Filter".CreateOutStream(OutStream);
            OutStream.Write(TableFilterV);
        end;

        IntegrationTableMapping."Integration Table ID" := IntegrationTableNo;
        IntegrationTableMapping."Synch. Codeunit ID" := Codeunit::"CRM Integration Table Synch.";
        IntegrationTableMapping."Uncouple Codeunit ID" := Codeunit::"CDS Int. Table Uncouple";
        IntegrationTableMapping.Validate("Integration Table UID Fld. No.", IntegrationTableUIDFieldNo);
        if IntegrationTableModifiedFieldNo < 9999 then
            IntegrationTableMapping."Int. Tbl. Modified On Fld. No." := IntegrationTableModifiedFieldNo;
        IntegrationTableMapping."Table Config Template Code" := TableConfigTemplateCode;
        IntegrationTableMapping."Int. Tbl. Config Template Code" := IntegrationTableConfigTemplateCode;
        IntegrationTableMapping.Direction := SynchDirection;
        IntegrationTableMapping."Int. Tbl. Caption Prefix" := 'CDS';
        IntegrationTableMapping."Synch. Only Coupled Records" := SynchOnlyCoupledRecords;
        IntegrationTableMapping.Insert(true);
    end;

    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection, ConstValue, ValidateField, ValidateIntegrationTableField);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestSalesLine', '', true, true)]
    local procedure OnBeforeTestSalesLine(var SalesLine: Record "Sales Line")
    begin
        if SalesLine."Document Type" = SalesLine."Document Type"::Order then begin
            if SalesLine.Type = SalesLine.Type::Item then begin
                Salesline.TestField("Type of Business");
                Salesline.TestField("Shortcut Dimension 1 Code");
            end;
        end
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterValidateShippingOptions', '', true, true)]
    local procedure OnAfterValidateShippingOptions(var SalesHeader: Record "Sales Header"; ShipToOptions: Option)
    begin
        if ShipToOptions <> 2 then begin
            if SalesHeader."Ship-To Customer No." <> '' then
                SalesHeader."Ship-To Customer No." := '';
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', true, true)]
    local procedure OnAfterPostsalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line"; var SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        IssueAdL: Record "Issue Ad";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        ItemVariantL: Record "Item Variant";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        IF Not SalesInvLine.IsEmpty then begin
            If SalesInvLine.Quantity <> 0 then begin
                IssueAdL.SetRange("Sales Order No.", SalesInvLine."Order No.");
                IssueAdL.SetRange("Sales Line No.", SalesInvLine."Order Line No.");
                If IssueAdL.FindFirst() then begin
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := SalesInvLine."Posting Date";
                    IssueAdL."Invoice No." := SalesInvLine."Document No.";
                    IssueAdL.Modify(true);
                end;
            end;
        end;
        IF NOT SalesCrMemoLine.IsEmpty then
            If SalesCrMemoLine.Quantity <> 0 then begin
                IF SalesCrMemoLine."Variant Code" <> '' then begin
                    SalesCrMemoHeaderL.Get(SalesCrMemoLine."Document No.");
                    ItemVariantL.SetRange("Item No.", SalesCrMemoLine."No.");
                    ItemVariantL.SetRange(Code, SalesCrMemoLine."Variant Code");
                    ItemVariantL.FindFirst();
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesCrMemoLine."Document No.");
                    IssueAdL.Validate("Sales Line No.", SalesCrMemoLine."Line No.");
                    IssueAdL.Validate("Item No.", SalesCrMemoLine."No.");
                    IssueAdL.Validate("Variant Code", SalesCrMemoLine."Variant Code");
                    IssueAdL.Validate("Unit Price", SalesCrMemoLine."Unit Price" * -1);
                    IssueAdL.Validate("Line Amount Excl. VAT", SalesCrMemoLine.Amount * -1);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesCrMemoLine."Sell-to Customer No.");
                    IssueAdL.Validate("Sales Person Code", SalesCrMemoHeaderL."Salesperson Code");
                    IssueAdL.Validate("Salesperson 2", SalesCrMemoHeaderL."Salesperson Code 2");
                    IssueAdL.Validate(Clerk, SalesCrMemoHeaderL.Clerk);
                    IssueAdL."Line Amount" := SalesCrMemoLine."Amount Including VAT" * -1;
                    IssueAdL."Ship-to Customer No." := SalesCrMemoHeaderL."Sell-to Customer No.";
                    IssueAdL."Ship-to Name" := SalesCrMemoHeaderL."Ship-to Name";
                    IssueAdL."Print Documents" := true;
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := SalesCrMemoHeaderL."Commission Salesperson";
                    IssueAdL."Credit Memo No." := SalesCrMemoHeaderL."No.";
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := SalesCrMemoHeaderL."Posting Date";
                    IF SalesCrMemoHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson") * -1;
                    If SalesCrMemoHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson 2") * -1;
                    If SalesCrMemoHeaderL."Applies-to Doc. Type" = SalesCrMemoHeaderL."Applies-to Doc. Type"::Invoice then
                        IF SalesInvoiceHeaderL.Get(SalesCrMemoHeaderL."Applies-to Doc. No.") then
                            IssueAdL."Invoice No." := SalesInvoiceHeaderL."No.";
                    //IssueAdL."Invoice Date" := SalesInvoiceHeaderL."Posting Date";
                    IssueAdL.Insert(true);
                end;
            end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ForNAV Update No. Printed", 'OnBeforeUpdateNoPrinted', '', true, true)]
    local procedure OnBeforeUpdateNoPrinted(var Handled: Boolean; Rec: Variant)
    var
        SalesHeaderL: Record "Sales Header";
        RecRef: RecordRef;
    begin
        if Rec.IsRecord then begin
            RecRef.GetTable(Rec);
            if recref.Number = 36 then begin
                Handled := true;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, true)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        CustomCRMSynchronization: Codeunit CustomCRMSynchronization;
        DummyInt: integer;
    begin
        // if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND (SalesHeader."Is Handled" = false) then begin
        //     CustomCRMSynchronization.SendOrderConfirmationPDFtoCRM(SalesHeader."No.");
        // end
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) then begin
            CustomCRMSynchronization.SendOrderConfirmationPDFtoCRM(SalesHeader."No.");
        end
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales - Calc Discount By Type", 'OnAfterResetRecalculateInvoiceDisc', '', true, true)]
    local procedure OnAfterResetRecalculateInvoiceDisc(var SalesHeader: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
        IssueAdL: Record "Issue Ad";
    begin

        SalesLineL.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineL.SetRange("Document No.", SalesHeader."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetFilter("Variant Code", '<>%1', '');
        IF SalesLineL.FindSet() then
            repeat
                IssueAdL.SetRange("Sales Order No.", SalesLineL."Document No.");
                IssueAdL.SetRange("Sales Line No.", SalesLineL."Line No.");
                If IssueAdL.FindFirst() then begin
                    IssueAdL."Line Amount Excl. VAT" := SalesLineL.Amount;
                    IF SalesHeader."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesLineL.Amount, SalesHeader."Commission Salesperson");
                    If SalesHeader."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesLineL.Amount, SalesHeader."Commission Salesperson 2");
                    IssueAdL."Sales Person Code" := SalesHeader."Salesperson Code";
                    IssueAdL."Salesperson 2" := SalesHeader."Salesperson Code 2";
                    IssueAdL."Commission %" := SalesHeader."Commission Salesperson";
                    IssueAdL."Commission 2 %" := SalesHeader."Commission Salesperson 2";
                    IssueAdL.Modify(true);
                end;
            until SalesLineL.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', true, true)]
    local procedure SalesLineOnBeforeTestStatusOpen(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        If SalesLine."Is Handled" then
            IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnBeforeApplyStdCodesToSalesLines', '', true, true)]
    local procedure OnBeforeApplyStdCodesToSalesLines(StdSalesLine: Record "Standard Sales Line"; var SalesLine: Record "Sales Line")
    begin
        SalesLine.Validate("Unit Price", StdSalesLine."Unit Price");
        SalesLine.Validate("Type of Business", StdSalesLine."Type of Business");
        SalesLine.Validate("Line Discount %", StdSalesLine."Line Discount %");
        SalesLine.Validate("Gen. Prod. Posting Group", StdSalesLine."Gen. Prod. Posting Group");
        SalesLine.Validate("VAT Prod. Posting Group", StdSalesLine."VAT Prod. Posting Group");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnCreateSalesInvoiceOnBeforeSalesHeaderModify', '', TRUE, TRUE)]
    local procedure OnCreateSalesInvoiceOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header"; StandardCustomerSalesCode: Record "Standard Customer Sales Code")
    begin
        SalesHeader."Automated Sales Order" := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCreatePurchaseHeaderOnBeforeInsert', '', true, true)]
    local procedure OnCreatePurchaseHeaderOnBeforeInsert(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header")
    begin
        PurchaseHeader.Validate("Salesperson Code", SalesHeader."Salesperson Code");
        PurchaseHeader.Validate("Salesperson Code 2", SalesHeader."Salesperson Code 2");
        PurchaseHeader."Commission Salesperson" := (-1) * SalesHeader."Commission Salesperson";
        PurchaseHeader."Commission Salesperson 2" := (-1) * SalesHeader."Commission Salesperson 2";
        PurchaseHeader."Related Sales Order" := SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCreatePurchaseOrderOnAfterPurchaseHeaderSetFilters', '', true, true)]
    local procedure OnCreatePurchaseOrderOnAfterPurchaseHeaderSetFilters(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header")
    var
        PurchaseLineL: Record "Purchase Line";
        SalesLineL: Record "Sales Line";
    begin
        if PurchaseHeader.FindSet() then
            repeat
                PurchaseHeader."Related Sales Order" := SalesHeader."No.";
                PurchaseHeader.Validate("Salesperson Code", SalesHeader."Salesperson Code");
                PurchaseHeader.Validate("Salesperson Code 2", SalesHeader."Salesperson Code 2");
                PurchaseHeader."Commission Salesperson" := (-1) * SalesHeader."Commission Salesperson";
                PurchaseHeader."Commission Salesperson 2" := (-1) * SalesHeader."Commission Salesperson 2";
                PurchaseHeader.Modify();
                PurchaseLineL.SetRange("Document Type", PurchaseHeader."Document Type");
                PurchaseLineL.SetRange("Document No.", PurchaseHeader."No.");
                PurchaseLineL.SetRange(Type, PurchaseLineL.Type::Item);
                if PurchaseLineL.FindSet() then
                    repeat
                        SalesLineL.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLineL.SetRange("Document No.", SalesHeader."No.");
                        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
                        SalesLineL.SetRange("No.", PurchaseLineL."No.");
                        SalesLineL.SetRange("Variant Code", PurchaseLineL."Variant Code");
                        if SalesLineL.FindFirst() then begin
                            PurchaseLineL."Sales Order No. Add" := SalesLineL."Document No.";
                            PurchaseLineL."Sales Order Line No. Add" := SalesLineL."Line No.";
                            PurchaseLineL.Modify();
                        end;
                    until PurchaseLineL.Next() < 1;
            until PurchaseHeader.Next() < 1;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCopySalesLinesToPurchaseLinesOnBeforeInsert', '', true, true)]
    local procedure OnCopySalesLinesToPurchaseLinesOnBeforeInsert(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line")
    begin
        PurchaseLine."Sales Order Line No. Add" := SalesLine."Line No.";
        PurchaseLine."Sales Order No. Add" := SalesLine."Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnAfterSalesQuoteToOrderRun', '', false, false)]
    local procedure AfterSalesQuoteToOrderRun(var SalesHeader2: Record "Sales Header")
    var
        IssueAdL: Record "Issue Ad";
        SalesLineL: Record "Sales Line";
        ItemL: record Item;
        ItemVariantL: Record "Item Variant";
        CustomReportSelectionL: Record "Custom Report Selection";
        SelectionUsage: Enum "Report Selection Usage";
    begin
        SalesLineL.SetRange("Document Type", SalesHeader2."Document Type");
        SalesLineL.SetRange("Document No.", SalesHeader2."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetFilter("Variant Code", '<>%1', '');
        if SalesLineL.FindSet() then
            repeat
                clear(ItemL);
                clear(ItemVariantL);
                Clear(IssueAdL);
                ItemL.get(SalesLineL."No.");
                ItemVariantL.Get(SalesLineL."No.", SalesLineL."Variant Code");
                IssueAdL.Init();
                IssueAdL.Validate("Sales Order No.", SalesLineL."Document No.");
                IssueAdL.Validate("Sales Line No.", SalesLineL."Line No.");
                IssueAdL.Validate("Item No.", SalesLineL."No.");
                IssueAdL.Validate("Variant Code", SalesLineL."Variant Code");
                IssueAdL.Validate("Unit Price", SalesLineL."Unit Price");
                IssueAdL.Validate("Line Amount Excl. VAT", SalesLineL.Amount);
                IssueAdL.Validate("Created Date", Today);
                IssueAdL.Validate("Sell-to Customer No.", SalesLineL."Sell-to Customer No.");
                IssueAdL.Validate("Sales Person Code", SalesHeader2."Salesperson Code");
                IssueAdL.Validate("Salesperson 2", SalesHeader2."Salesperson Code 2");
                IssueAdL.Validate(Clerk, SalesHeader2.Clerk);
                IssueAdL."Line Amount" := SalesLineL."Amount Including VAT";
                IssueAdL."Ship-to Customer No." := SalesHeader2."Ship-To Customer No.";
                IssueAdL."Ship-to Name" := SalesHeader2."Ship-to Name";
                IF ItemL."Item Issue Closing Date" <> 0D then
                    IssueAdL.Validate("Print Documents Enddate", itemL."Item Issue Closing Date")
                else
                    IssueAdL.Validate("Print Documents Enddate", SalesHeader2."Posting Date");
                IssueAdL.Validate(Format, ItemVariantL.Description);
                IssueAdL."Commission %" := SalesHeader2."Commission Salesperson";
                IssueAdL."Commission 2 %" := SalesHeader2."Commission Salesperson 2";
                IssueAdL.Placement := SalesLineL.Placement;
                IssueAdL."Type of Business" := SalesLineL."Type of Business";
                IssueAdL.Motive := SalesLineL.Motive;
                IF SalesHeader2."Commission Salesperson" <> 0 then
                    IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesLineL.Amount, SalesHeader2."Commission Salesperson");
                If SalesHeader2."Commission Salesperson 2" <> 0 then
                    IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesLineL.Amount, SalesHeader2."Commission Salesperson 2");
                CustomReportSelectionL.SetRange("Source Type", 18);
                CustomReportSelectionL.SetRange("Source No.", SalesLineL."Sell-to Customer No.");
                CustomReportSelectionL.SetRange(Usage, SelectionUsage::"Print Doc Reminder");
                If CustomReportSelectionL.FindFirst() then
                    IssueAdL.Email := CustomReportSelectionL."Send To Email"
                Else
                    IssueAdL.Email := SalesHeader2."Sell-to E-Mail";
                IssueAdL.Insert(true);
            until SalesLineL.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure BeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesQuoteLine: Record "Sales Line")
    var
        ItemL: Record Item;
    begin
        SalesOrderLine.Placement := SalesQuoteLine.Placement;
        SalesOrderLine."Type of Business" := SalesQuoteLine."Type of Business";
        SalesOrderLine.Motive := SalesQuoteLine.Motive;
    end;

    //NC-10858>>>>>>>>>>>>>>>>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnBeforeUpdateMultipleFromTemplate', '', true, true)]
    local procedure "Customer Templ. Mgt._OnBeforeUpdateMultipleFromTemplate"
    (
        var Customer: Record "Customer";
        var IsHandled: Boolean
    )
    var
        CustomerTempl: Record "Customer Templ.";
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        ConfirmManagement: Codeunit "Confirm Management";
        UpdateExistingValuesQst: Label 'You are about to apply the template to selected records. Data from the template will replace data for the records. Do you want to continue?';
    begin
        IsHandled := true;
        if not CanBeUpdatedFromTemplate(CustomerTempl, IsHandled) then
            exit;
        if ConfirmManagement.GetResponseOrDefault(UpdateExistingValuesQst, false) then begin
            if Customer.FindSet() then
                repeat
                    CustomerTemplMgt.ApplyCustomerTemplate(Customer, CustomerTempl, true);
                until Customer.Next() = 0;
        end;
    end;

    local procedure CanBeUpdatedFromTemplate(var CustomerTempl: Record "Customer Templ."; var IsHandled: Boolean): Boolean
    var
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
    begin
        IsHandled := true;

        if not CustomerTemplMgt.SelectCustomerTemplate(CustomerTempl) then
            exit(false);

        exit(true);
    end;
    //NC-10858<<<<<<<<<<<<<<<<<<<<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', false, false)]
    local procedure BeforeSendEmail(var TempEmailItem: Record "Email Item"; var PostedDocNo: Code[20]; var ReportUsage: Integer; EmailScenario: Enum "Email Scenario"; EmailDocName: Text[250]; var IsFromPostedDoc: Boolean)
    var
        IssueSetupL: Record "Issue Setup";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        if EnvironmentInformationL.IsSandbox() then begin
            IssueSetupL.get();
            if IssueSetupL."Test Mail Recipient" <> '' then
                TempEmailItem."Send to" := IssueSetupL."Test Mail Recipient";
        end;
    enD;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"O365 Activities Dictionary", 'OnRunOnBeforeSetBackgroundTaskResult', '', false, false)]
    local procedure RunOnBeforeSetBackgroundTaskResult(var Results: Dictionary of [Text, Text]; ActivitiesCue: Record "Activities Cue")
    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
        SalesAndOpenOrders: Decimal;
        SalesLineL: Record "Sales Line";
    begin
        results.Remove(ActivitiesCue.FieldName("Sales This Month"));
        SalesAndOpenOrders := ActivitiesMgt.CalcSalesThisMonthAmount(false);
        SalesLineL.Setfilter("Document Type", '%1|%2', SalesLineL."Document Type"::Order, SalesLineL."Document Type"::Invoice);
        SalesLineL.SetRange("Posting Date", CalcDate('<-CM>', WorkDate()), Workdate());
        SalesLineL.CalcSums("Amount Including VAT");
        SalesAndOpenOrders += SalesLineL."Amount Including VAT";
        results.Add(ActivitiesCue.FieldName("Sales This Month"), format(SalesAndOpenOrders));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Activities Mgt.", 'OnRefreshActivitiesCueDataOnBeforeModify', '', false, false)]
    local procedure RefreshActivitiesCueDataOnBeforeModify(var ActivitiesCue: Record "Activities Cue")
    var
        SalesLineL: Record "Sales Line";
        OpenOrders: Decimal;
    begin
        SalesLineL.Setfilter("Document Type", '%1|%2', SalesLineL."Document Type"::Order, SalesLineL."Document Type"::Invoice);
        SalesLineL.SetRange("Posting Date", CalcDate('<-CM>', WorkDate()), Workdate());
        SalesLineL.CalcSums("Amount Including VAT");
        OpenOrders := SalesLineL."Amount Including VAT";
        ActivitiesCue."Sales This Month" += OpenOrders;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnBeforeTrySendToEMail', '', false, false)]
    local procedure OnBeforeTrySendToEMail(CustomerFieldNo: Integer; var IsCustomer: Boolean; DocName: Text[150]; RecordVariant: Variant)
    var
        DataTypeManagementL: Codeunit "Data Type Management";
        RecordRefL: RecordRef;
        PurchInvHeaderL: Record "Purch. Inv. Header";
    begin
        if RecordVariant.IsRecord then begin
            DataTypeManagementL.GetRecordRef(RecordVariant, RecordRefL);
            if RecordRefL.Name = PurchInvHeaderL.TableName then
                IsCustomer := false;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"CRM Integration Record", OnBeforeDeleteEvent, '', false, false)]
    local procedure OnAfterDeleteEvent(var Rec: Record "CRM Integration Record")
    var
        CRMAccountL: Record "CRM Account";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        if EnvironmentInformationL.IsProduction() then
            if CRMAccountL.get(Rec."CRM ID") then begin
                Codeunit.Run(Codeunit::"CRM Integration Management");
                CRMAccountL.new_bccustomerno := '';
                CRMAccountL.modify();
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Merge Duplicates Buffer", 'OnAfterMergeCustomers', '', false, false)]
    local procedure AfterMergeCustomers(var Customer: array[2] of Record Customer)
    var
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CRMAccountL: Record "CRM Account";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        if EnvironmentInformationL.IsProduction() then begin
            CRMIntegrationRecordL.SetRange("Table ID", 18);
            CRMIntegrationRecordL.SetRange("Integration ID", Customer[1].SystemId);
            if CRMIntegrationRecordL.FindFirst() then
                if CRMAccountL.get(CRMIntegrationRecordL."CRM ID") then begin
                    Codeunit.Run(Codeunit::"CRM Integration Management");
                    CRMAccountL.new_bccustomerno := '';
                    CRMAccountL.modify();
                end;

            CRMIntegrationRecordL.SetRange("Table ID", 18);
            CRMIntegrationRecordL.SetRange("Integration ID", Customer[2].SystemId);
            if CRMIntegrationRecordL.FindFirst() then
                if CRMAccountL.get(CRMIntegrationRecordL."CRM ID") then begin
                    Codeunit.Run(Codeunit::"CRM Integration Management");
                    CRMAccountL.new_bccustomerno := '';
                    CRMAccountL.modify();
                end;
        end;
    end;
}