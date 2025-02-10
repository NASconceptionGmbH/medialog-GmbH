report 60712 "Update Issue Ad List"
{
    Caption = 'Dispoliste Aktualisieren';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata 114 = rimd, tabledata 112 = rimd;
    dataset
    {
        dataitem(SalesInvoiceLine; "Sales Invoice Line")
        {
            DataItemTableView = where("Variant Code" = filter(<> ''), Quantity = filter(> 0));

            trigger OnPreDataItem()
            begin
                SalesInvoiceLine.Setfilter(SystemModifiedAt, '>=%1', IssueSetupL."Last Issue Ad Update");
            end;

            trigger
            OnAfterGetRecord()
            var
                IssueAdL: Record "Issue Ad";
                SalesInvoiceHeaderL: Record "Sales Invoice Header";
                ItemVariantL: Record "Item Variant";
            begin
                //IssueAdL.SetRange("Invoice Date", 0D);
                IF IssueAdL.Get(SalesInvoiceLine."Order No.", SalesInvoiceLine."Order Line No.") then begin
                    SalesInvoiceHeaderL.Get(SalesInvoiceLine."Document No.");
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := SalesInvoiceLine."Posting Date";
                    IssueAdL."Invoice No." := SalesInvoiceLine."Document No.";
                    IssueAdL."Sales Person Code" := SalesInvoiceHeaderL."Salesperson Code";
                    IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesInvoiceLine.Amount, SalesInvoiceHeaderL."Commission Salesperson");
                    IssueAdL."Salesperson 2" := SalesInvoiceHeaderL."Salesperson Code 2";
                    IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesInvoiceLine.Amount, SalesInvoiceHeaderL."Commission Salesperson 2");
                    IssueAdL.Modify(true);
                end else begin
                    SalesInvoiceHeaderL.Get(SalesInvoiceLine."Document No.");
                    ItemVariantL.Get(SalesInvoiceLine."No.", SalesInvoiceLine."Variant Code");
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesInvoiceLine."Order No.");
                    IssueAdL.Validate("Sales Line No.", SalesInvoiceLine."Order Line No.");
                    IssueAdL.Validate("Item No.", SalesInvoiceLine."No.");
                    IssueAdL.Validate("Variant Code", SalesInvoiceLine."Variant Code");
                    IssueAdL.Validate("Unit Price", SalesInvoiceLine."Unit Price");
                    IssueAdL.Validate("Line Amount Excl. VAT", SalesInvoiceLine.Amount);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesInvoiceLine."Sell-to Customer No.");
                    IssueAdL."Sales Person Code" := SalesInvoiceHeaderL."Salesperson Code";
                    IssueAdL."Salesperson 2" := SalesInvoiceHeaderL."Salesperson Code 2";
                    IssueAdL.Clerk := SalesInvoiceHeaderL.Clerk;
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := SalesInvoiceLine."Posting Date";
                    IssueAdL."Invoice No." := SalesInvoiceLine."Document No.";
                    IssueAdL."Line Amount" := SalesInvoiceLine."Amount Including VAT";
                    IssueAdL."Ship-to Customer No." := SalesInvoiceHeaderL."Ship-To Customer No.";
                    IssueAdL."Ship-to Name" := SalesInvoiceHeaderL."Ship-to Name";
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := SalesInvoiceHeaderL."Commission Salesperson";
                    IssueAdL."Commission 2 %" := SalesInvoiceHeaderL."Commission Salesperson 2";
                    IF SalesInvoiceHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesInvoiceLine.Amount, SalesInvoiceHeaderL."Commission Salesperson");
                    If SalesInvoiceHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesInvoiceLine.Amount, SalesInvoiceHeaderL."Commission Salesperson 2");
                    IssueAdL.Insert(true);
                end;

            end;
        }
        dataitem(SalesCrMemoLine; "Sales Cr.Memo Line")
        {
            DataItemTableView = where("Variant Code" = filter(<> ''), Quantity = filter(> 0));

            trigger OnPreDataItem()
            begin
                SalesCrMemoLine.Setfilter(SystemModifiedAt, '>=%1', IssueSetupL."Last Issue Ad Update");
            end;

            trigger
            OnAfterGetRecord()
            var
                IssueAdL: Record "Issue Ad";
                SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
                ItemVariantL: Record "Item Variant";
            begin
                //IssueAdL.SetRange("Invoice Date", 0D);
                IF IssueAdL.Get(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.") then begin
                    SalesCrMemoHeaderL.Get(SalesCrMemoLine."Document No.");
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := SalesCrMemoLine."Posting Date";
                    //IssueAdL."Invoice No." := SalesInvoiceLine."Document No.";
                    IssueAdL."Sales Person Code" := SalesCrMemoHeaderL."Salesperson Code";
                    IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson") * -1;
                    IssueAdL."Salesperson 2" := SalesCrMemoHeaderL."Salesperson Code 2";
                    IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson 2") * -1;
                    IssueAdL.Modify(true);
                end else begin
                    SalesCrMemoHeaderL.Get(SalesCrMemoLine."Document No.");
                    ItemVariantL.Get(SalesCrMemoLine."No.", SalesCrMemoLine."Variant Code");
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesCrMemoLine."Document No.");
                    IssueAdL.Validate("Sales Line No.", SalesCrMemoLine."Line No.");
                    IssueAdL.Validate("Item No.", SalesCrMemoLine."No.");
                    IssueAdL.Validate("Variant Code", SalesCrMemoLine."Variant Code");
                    IssueAdL.Validate("Unit Price", SalesCrMemoLine."Unit Price");
                    IssueAdL.Validate("Line Amount Excl. VAT", SalesCrMemoLine.Amount);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesCrMemoLine."Sell-to Customer No.");
                    IssueAdL."Sales Person Code" := SalesCrMemoHeaderL."Salesperson Code";
                    IssueAdL."Salesperson 2" := SalesCrMemoHeaderL."Salesperson Code 2";
                    IssueAdL.Clerk := SalesCrMemoHeaderL.Clerk;
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := SalesCrMemoHeaderL."Posting Date";
                    IssueAdL."Line Amount" := SalesCrMemoLine."Amount Including VAT";
                    IssueAdL."Ship-to Name" := SalesCrMemoHeaderL."Ship-to Name";
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := SalesCrMemoHeaderL."Commission Salesperson";
                    IssueAdL."Commission 2 %" := SalesCrMemoHeaderL."Commission Salesperson 2";
                    IF SalesCrMemoHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson");
                    If SalesCrMemoHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson 2");
                    IssueAdL.Insert(true);
                end;

            end;
        }
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Order));

            trigger OnPreDataItem()
            begin
                SalesHeader.Setfilter(SystemModifiedAt, '>=%1', IssueSetupL."Last Issue Ad Update");
            end;

            trigger
            OnAfterGetRecord()
            var
                IssueAdL: Record "Issue Ad";
                ItemVariantL: Record "Item Variant";
            begin
                IssueAdL.SetRange("Sales Order No.", SalesHeader."No.");
                if IssueAdL.FindSet(true) then
                    repeat
                        IssueAdL."Sales Person Code" := SalesHeader."Salesperson Code";
                        IssueAdL."Salesperson 2" := SalesHeader."Salesperson Code 2";
                        IssueAdL.Clerk := SalesHeader.Clerk;
                        IssueAdL.Email := GetEmail(SalesHeader);
                        IssueAdL."Ship-to Name" := SalesHeader."Ship-to Name";
                        IssueAdL.modify(true);
                    until IssueAdL.next() = 0;
            end;
        }
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = where("Variant Code" = filter(<> ''), Quantity = filter(> 0), "Document Type" = const(Order));

            trigger OnPreDataItem()
            begin
                SalesLine.Setfilter(SystemModifiedAt, '>=%1', IssueSetupL."Last Issue Ad Update");
            end;

            trigger
            OnAfterGetRecord()
            var
                IssueAdL: Record "Issue Ad";
                ItemVariantL: Record "Item Variant";
                SalesHeaderL: Record "Sales Header";
            begin
                IF NOT IssueAdL.Get(SalesLine."Document No.", SalesLine."Line No.") then begin
                    ItemVariantL.Get(SalesLine."No.", SalesLine."Variant Code");
                    SalesHeaderL.Get(SalesLine."Document Type", SalesLine."Document No.");
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesLine."Document No.");
                    IssueAdL.Validate("Sales Line No.", SalesLine."Line No.");
                    IssueAdL.Validate("Item No.", SalesLine."No.");
                    IssueAdL.Validate("Variant Code", SalesLine."Variant Code");
                    IssueAdL.Validate("Unit Price", SalesLine."Unit Price");
                    IssueAdL.Validate("Line Amount Excl. VAT", SalesLine.Amount);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesLine."Sell-to Customer No.");
                    IssueAdL."Sales Person Code" := SalesHeaderL."Salesperson Code";
                    IssueAdL."Salesperson 2" := SalesHeaderL."Salesperson Code 2";
                    IssueAdL.Clerk := SalesHeaderL.Clerk;
                    IssueAdL."Line Amount" := SalesLine."Amount Including VAT";
                    IssueAdL."Ship-to Name" := SalesHeaderL."Ship-to Name";
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := SalesHeaderL."Commission Salesperson";
                    IssueAdL."Commission 2 %" := SalesHeaderL."Commission Salesperson 2";
                    IF SalesHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesHeaderL."Commission Salesperson");
                    If SalesHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesHeaderL."Commission Salesperson 2");
                    IssueAdL.Email := GetEmail(SalesHeader);
                    IssueAdL.Insert(true);
                end else begin
                    ItemVariantL.Get(SalesLine."No.", SalesLine."Variant Code");
                    SalesHeaderL.Get(SalesLine."Document Type", SalesLine."Document No.");
                    if IssueAdL."Item No." <> SalesLine."No." then
                        IssueAdL.Validate("Item No.", SalesLine."No.");
                    if IssueAdL."Variant Code" <> SalesLine."Variant Code" then
                        IssueAdL.Validate("Variant Code", SalesLine."Variant Code");
                    IssueAdL.Validate("Unit Price", SalesLine."Unit Price");
                    IssueAdL.Validate("Line Amount Excl. VAT", SalesLine.Amount);
                    IssueAdL.Validate("Sell-to Customer No.", SalesLine."Sell-to Customer No.");
                    IssueAdL."Sales Person Code" := SalesHeaderL."Salesperson Code";
                    IssueAdL."Salesperson 2" := SalesHeaderL."Salesperson Code 2";
                    IssueAdL.Clerk := SalesHeaderL.Clerk;
                    IssueAdL."Line Amount" := SalesLine."Amount Including VAT";
                    IssueAdL."Ship-to Name" := SalesHeaderL."Ship-to Name";
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := SalesHeaderL."Commission Salesperson";
                    IssueAdL."Commission 2 %" := SalesHeaderL."Commission Salesperson 2";
                    IF SalesHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesHeaderL."Commission Salesperson");
                    If SalesHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesHeaderL."Commission Salesperson 2");
                    IssueAdL.Email := GetEmail(SalesHeader);
                    IssueAdL.modify(true);
                end;
            end;
        }
        dataitem(PurchaseInvoiceLine; "Purch. Inv. Line")
        {
            DataItemTableView = where("Variant Code" = filter(<> ''), Quantity = filter(> 0));

            trigger OnPreDataItem()
            begin
                PurchaseInvoiceLine.Setfilter(SystemModifiedAt, '>=%1', IssueSetupL."Last Issue Ad Update");
            end;

            trigger
            OnAfterGetRecord()
            var
                IssueAdL: Record "Issue Ad";
                PurchInvHeaderL: Record "Purch. Inv. Header";
                SalesInvoiceHeaderL: Record "Sales Invoice Header";
                SalesInvoiceLineL: Record "Sales Invoice Line";
                ItemVariantL: Record "Item Variant";
            begin
                //IssueAdL.SetRange("Invoice Date", 0D);
                if not SalesInvoiceLineL.Get(PurchaseInvoiceLine."Sales Order No. Add", PurchaseInvoiceLine."Sales Order Line No. Add") then
                    CurrReport.Skip();
                if PurchInvHeaderL.Get(PurchaseInvoiceLine."Document No.") then;
                IF IssueAdL.Get(PurchaseInvoiceLine."Order No.", PurchaseInvoiceLine."Order Line No.") then begin
                    SalesInvoiceHeaderL.Get(PurchaseInvoiceLine."Sales Order No. Add");
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := PurchaseInvoiceLine."Posting Date";
                    IssueAdL."Invoice No." := PurchaseInvoiceLine."Document No.";
                    IssueAdL."Sales Person Code" := PurchInvHeaderL."Salesperson Code";
                    IssueAdL."Commission Amount" := IssueAdL.CalcCommission(PurchaseInvoiceLine.Amount, PurchInvHeaderL."Commission Salesperson");
                    IssueAdL."Salesperson 2" := PurchInvHeaderL."Salesperson Code 2";
                    IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(PurchaseInvoiceLine.Amount, PurchInvHeaderL."Commission Salesperson 2");
                    IssueAdL.Purchase := true;
                    IssueAdL.Modify(true);
                end else begin
                    SalesInvoiceHeaderL.Get(PurchaseInvoiceLine."Sales Order No. Add");
                    ItemVariantL.Get(PurchaseInvoiceLine."No.", PurchaseInvoiceLine."Variant Code");
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesInvoiceLineL."Order No.");
                    IssueAdL.Validate("Sales Line No.", SalesInvoiceLineL."Order Line No.");
                    IssueAdL.Validate("Item No.", PurchaseInvoiceLine."No.");
                    IssueAdL.Validate("Variant Code", PurchaseInvoiceLine."Variant Code");
                    IssueAdL.Validate("Unit Price", PurchaseInvoiceLine."Unit Cost");
                    IssueAdL.Validate("Line Amount Excl. VAT", PurchaseInvoiceLine.Amount);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesInvoiceHeaderL."Sell-to Customer No.");
                    IssueAdL."Sales Person Code" := PurchInvHeaderL."Salesperson Code";
                    IssueAdL."Salesperson 2" := PurchInvHeaderL."Salesperson Code 2";
                    IssueAdL.Clerk := SalesInvoiceHeaderL.Clerk;
                    IssueAdL.Status := IssueAdL.Status::Released;
                    IssueAdL."Invoice Date" := PurchaseInvoiceLine."Posting Date";
                    IssueAdL."Invoice No." := PurchaseInvoiceLine."Document No.";
                    IssueAdL."Line Amount" := PurchaseInvoiceLine."Amount Including VAT";
                    IssueAdL."Ship-to Customer No." := SalesInvoiceHeaderL."Ship-To Customer No.";
                    IssueAdL."Ship-to Name" := SalesInvoiceHeaderL."Ship-to Name";
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := PurchInvHeaderL."Commission Salesperson";
                    IssueAdL."Commission 2 %" := PurchInvHeaderL."Commission Salesperson 2";
                    IF PurchInvHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(PurchaseInvoiceLine.Amount, PurchInvHeaderL."Commission Salesperson");
                    If PurchInvHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(PurchaseInvoiceLine.Amount, PurchInvHeaderL."Commission Salesperson 2");
                    IssueAdL.Purchase := true;
                    IssueAdL.Insert(true);
                end;

            end;
        }
        // dataitem(PurchCrMemoLine; "Purch. Cr. Memo Line")
        // {
        //     DataItemTableView = where("Variant Code" = filter(<> ''), Quantity = filter(> 0));

        //     trigger
        //     OnAfterGetRecord()
        //     var
        //         IssueAdL: Record "Issue Ad";
        //         SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        //         ItemVariantL: Record "Item Variant";
        //     begin
        //         //IssueAdL.SetRange("Invoice Date", 0D);
        //         IF IssueAdL.Get(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.") then begin
        //             SalesCrMemoHeaderL.Get(SalesCrMemoLine."Document No.");
        //             IssueAdL.Status := IssueAdL.Status::Released;
        //             IssueAdL."Invoice Date" := SalesCrMemoLine."Posting Date";
        //             //IssueAdL."Invoice No." := SalesInvoiceLine."Document No.";
        //             IssueAdL."Sales Person Code" := SalesCrMemoHeaderL."Salesperson Code";
        //             IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson") * -1;
        //             IssueAdL."Salesperson 2" := SalesCrMemoHeaderL."Salesperson Code 2";
        //             IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson 2") * -1;
        //             IssueAdL.Modify(true);
        //         end else begin
        //             SalesCrMemoHeaderL.Get(SalesCrMemoLine."Document No.");
        //             ItemVariantL.Get(SalesCrMemoLine."No.", SalesCrMemoLine."Variant Code");
        //             IssueAdL.Init();
        //             IssueAdL.Validate("Sales Order No.", SalesCrMemoLine."Document No.");
        //             IssueAdL.Validate("Sales Line No.", SalesCrMemoLine."Line No.");
        //             IssueAdL.Validate("Item No.", SalesCrMemoLine."No.");
        //             IssueAdL.Validate("Variant Code", SalesCrMemoLine."Variant Code");
        //             IssueAdL.Validate("Unit Price", SalesCrMemoLine."Unit Price");
        //             IssueAdL.Validate("Line Amount Excl. VAT", SalesCrMemoLine.Amount);
        //             IssueAdL.Validate("Created Date", Today);
        //             IssueAdL.Validate("Sell-to Customer No.", SalesCrMemoLine."Sell-to Customer No.");
        //             IssueAdL.Validate("Sales Person Code", SalesCrMemoHeaderL."Salesperson Code");
        //             IssueAdL.Validate("Salesperson 2", SalesCrMemoHeaderL."Salesperson Code 2");
        //             IssueAdL.Validate(Clerk, SalesCrMemoHeaderL.Clerk);
        //             IssueAdL.Status := IssueAdL.Status::Released;
        //             IssueAdL."Invoice Date" := SalesCrMemoHeaderL."Posting Date";
        //             IssueAdL."Line Amount" := SalesCrMemoLine."Amount Including VAT";
        //             IssueAdL."Ship-to Name" := SalesCrMemoHeaderL."Ship-to Name";
        //             IssueAdL.Validate(Format, ItemVariantL.Description);
        //             IssueAdL."Commission %" := SalesCrMemoHeaderL."Commission Salesperson";
        //             IssueAdL."Commission 2 %" := SalesCrMemoHeaderL."Commission Salesperson 2";
        //             IF SalesCrMemoHeaderL."Commission Salesperson" <> 0 then
        //                 IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson");
        //             If SalesCrMemoHeaderL."Commission Salesperson 2" <> 0 then
        //                 IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson 2");
        //             IssueAdL.Insert(true);
        //         end;

        //     end;
        // }
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = where("Variant Code" = filter(<> ''), Quantity = filter(> 0));

            trigger OnPreDataItem()
            begin
                PurchaseLine.Setfilter(SystemModifiedAt, '>=%1', IssueSetupL."Last Issue Ad Update");
            end;

            trigger
            OnAfterGetRecord()
            var
                IssueAdL: Record "Issue Ad";
                ItemVariantL: Record "Item Variant";
                SalesHeaderL: Record "Sales Header";
                PurchaseHeaderL: Record "Purchase Header";
                SalesLineL: Record "Sales Line";
            begin
                if not SalesLineL.Get(PurchaseLine."Sales Order No. Add", PurchaseLine."Sales Order Line No. Add") then
                    CurrReport.Skip();
                if PurchaseHeaderL.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then;

                IF NOT IssueAdL.Get(PurchaseLine."Document No.", PurchaseLine."Line No.") then begin
                    ItemVariantL.Get(PurchaseLine."No.", PurchaseLine."Variant Code");
                    SalesHeaderL.Get(SalesLineL."Document Type", SalesLineL."Document No.");
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesLineL."Document No.");
                    IssueAdL.Validate("Sales Line No.", SalesLineL."Line No.");
                    IssueAdL.Validate("Item No.", PurchaseLine."No.");
                    IssueAdL.Validate("Variant Code", PurchaseLine."Variant Code");
                    IssueAdL.Validate("Unit Price", PurchaseLine."Unit Cost");
                    IssueAdL.Validate("Line Amount Excl. VAT", PurchaseLine.Amount);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesLineL."Sell-to Customer No.");
                    IssueAdL."Sales Person Code" := PurchaseHeaderL."Salesperson Code";
                    IssueAdL."Salesperson 2" := PurchaseHeaderL."Salesperson Code 2";
                    IssueAdL.Clerk := SalesHeaderL.Clerk;
                    IssueAdL."Line Amount" := PurchaseLine."Amount Including VAT";
                    IssueAdL."Ship-to Name" := SalesHeaderL."Ship-to Name";
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := PurchaseHeaderL."Commission Salesperson";
                    IssueAdL."Commission 2 %" := PurchaseHeaderL."Commission Salesperson 2";
                    IF PurchaseHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesHeaderL."Commission Salesperson");
                    If PurchaseHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesHeaderL."Commission Salesperson 2");
                    IssueAdL.Purchase := true;
                    IssueAdL.Insert(true);
                end;
            end;
        }
        dataitem(IssueAd; "Issue Ad")
        {
            trigger
            OnAfterGetRecord()
            var
                SalesHeaderL: Record "Sales Header";
                SalesInvoiceHeaderL: Record "Sales Invoice Header";
            begin
                SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
                SalesHeaderL.SetRange("No.", IssueAd."Sales Order No.");
                If Not SalesHeaderL.FindFirst() then begin
                    SalesInvoiceHeaderL.SetRange("Order No.", IssueAd."Sales Order No.");
                    If not SalesInvoiceHeaderL.FindFirst() then
                        IssueAd.Delete();
                end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnInitReport()
    begin
        IssueSetupL.Get();
    end;

    trigger
    OnPostReport()
    begin

        IssueSetupL."Last Issue Ad Update" := CurrentDateTime;
        IssueSetupL.modify();

        Message('Done');
    end;

    local procedure GetEmail(SalesHeaderV: Record "Sales Header"): text[200]
    var
        CustomReportSelectionL: Record "Custom Report Selection";
    begin

        CustomReportSelectionL.SetRange("Source Type", 18);
        CustomReportSelectionL.SetRange("Source No.", SalesHeaderV."Sell-to Customer No.");
        CustomReportSelectionL.SetRange(Usage, CustomReportSelectionL.Usage::"Print Doc Reminder");
        If CustomReportSelectionL.FindFirst() then
            exit(CustomReportSelectionL."Send To Email")
        Else
            exit(SalesHeaderV."Sell-to E-Mail");
    end;

    var
        IssueSetupL: Record "Issue Setup";
}