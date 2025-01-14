codeunit 60720 SubscriptionRunner
{
    TableNo = "Job Queue Entry";
    Permissions = tabledata "sales invoice header" = rimd;

    trigger OnRun()
    begin
        case Rec."Parameter String" of
            'CreateOrders':
                begin
                    CreateOrdersFromSubscriptions()
                end;
            'CreateAnnualOrders':
                begin
                    if Date2DMY(Today, 2) <> 11 then
                        error('Es ist nicht November, die Jahresfaktur lässt sich nicht ausführen');
                    RunAnnualSubscriptions();
                end;
            'PostOrders':
                begin
                    PostSubscriptions();
                end;
            'SendInvoices':
                begin
                    SendSubscriptionEmails();
                end;
            'FillData':
                begin
                    FillData(false);
                end;
            'FillDataAll':
                begin
                    FillData(true);
                end;
            'ChangeStatus':
                begin
                    ChangeStatus();
                end;
        end;


    end;

    procedure CreateOrdersFromSubscriptions()
    var
        Subscriptions2L: Record Subscriptions;
        SubscriptionsL: Record Subscriptions;
        SubscriptionHelperL: Codeunit SubscriptionHelper;
        SubscriptionProcesserL: Codeunit SubscriptionProcesser;
        ZeroGuid: guid;
        IssueSetupL: record "Issue Setup";
        EnvironmentInformationL: Codeunit "Environment Information";
        SkipCRMInit: Boolean;
    begin
        if EnvironmentInformationL.IsSandbox() then begin
            IssueSetupL.get();
            if IssueSetupL."SkipCRMOrderCreation(sandbox)" then
                SkipCRMInit := true;
        end;

        if SkipCRMInit = false then
            Codeunit.Run(Codeunit::"CRM Integration Management");

        if SubscriptionIDG <> ZeroGuid then
            SubscriptionsL.Setrange(cos_abonnementid, SubscriptionIDG);
        SubscriptionsL.SetRange("BC Status", SubscriptionsL."BC Status"::Active);
        SubscriptionsL.Setfilter("Next Invoice Date", '%1|%2..%3', 0D, CALCDATE('<-CY>', Today), CALCDATE('<+CY>', Today));
        //zu klären!
        if SubscriptionsL.FindSet() then
            repeat
                if not SubscriptionProcesserL.run(SubscriptionsL) then begin
                    Subscriptions2L.get(SubscriptionsL."cos_abonnementId");
                    Subscriptions2L."Error Message" := GetLastErrorText();
                    Subscriptions2L."Process Status" := Subscriptions2L."Process Status"::Error;
                    Subscriptions2L.modify();
                end else begin
                    Subscriptions2L.get(SubscriptionsL.cos_abonnementid);
                    Subscriptions2L."Error Message" := '';
                    Subscriptions2L."Last Invoice Date" := today;
                    Subscriptions2L."Process Status" := Subscriptions2L."Process Status"::" ";
                    Subscriptions2L.modify();
                end;
                commit();
            until SubscriptionsL.next() = 0;

    end;

    procedure RunAnnualSubscriptions()
    var
        EnvironmentInformationL: Codeunit "Environment Information";
        IssueSetupL: Record "Issue Setup";
        SkipCRMFunctionality: Boolean;
    begin

        if EnvironmentInformationL.IsSandbox() then begin
            IssueSetupL.get();
            if IssueSetupL."SkipCRMOrderCreation(sandbox)" then
                SkipCRMFunctionality := true;
        end;

        if SkipCRMFunctionality = false then begin
            ChangeStatus();
            Commit();
        end;
        CreateAnnualOrdersFromSubscriptions();
        // CreateSubscriptionsForPartiallyInvoicedCY();
    end;

    procedure CreateAnnualOrdersFromSubscriptions()
    var
        Subscriptions2L: Record Subscriptions;
        SubscriptionsL: Record Subscriptions;
        CreateAnnualOrderL: Codeunit "Create Annual Orders";
        ZeroGuid: guid;
        IssueSetupL: record "Issue Setup";
        EnvironmentInformationL: Codeunit "Environment Information";
        SkipCRMInit: Boolean;
    begin
        if EnvironmentInformationL.IsSandbox() then begin
            IssueSetupL.get();
            if IssueSetupL."SkipCRMOrderCreation(sandbox)" then
                SkipCRMInit := true;
        end;

        if SkipCRMInit = false then
            Codeunit.Run(Codeunit::"CRM Integration Management");

        SubscriptionsL.SetRange("BC Status", SubscriptionsL."BC Status"::Active);
        SubscriptionsL.Setfilter("Next Invoice Date", '%1..%2', CALCDATE('<-CY>', Today), CALCDATE('<+CY>', Today));
        if SubscriptionsL.FindSet() then
            repeat
                if not CreateAnnualOrderL.Run(SubscriptionsL) then begin
                    Subscriptions2L.Get(SubscriptionsL."cos_abonnementId");
                    Subscriptions2L."Error Message" := GetLastErrorText();
                    Subscriptions2L."Process Status" := Subscriptions2L."Process Status"::Error;
                    Subscriptions2L.Modify();
                end else begin
                    Subscriptions2L.Get(SubscriptionsL.cos_abonnementid);
                    Subscriptions2L."Error Message" := '';
                    Subscriptions2L."Last Invoice Date" := today;
                    Subscriptions2L."Process Status" := Subscriptions2L."Process Status"::" ";
                    Subscriptions2L."Next Invoice Date" := CalcDate('<1Y>', today);
                    Subscriptions2L.Modify();
                end;
                Commit();
            until SubscriptionsL.next() = 0;
    end;

    //2024, vermutlich nichtbenötigt in 2025
    //Neue Abos die dieses Jahr gestartet sind, haben automatisch "nächstes rechnungs datum" = nächstes jahr erhalten, 
    //deswegen wurden diese nicht in der Jahresfaktur berücksichtigt.
    procedure CreateSubscriptionsForPartiallyInvoicedCY()
    var
        Subscriptions2L: Record Subscriptions;
        SubscriptionsL: Record Subscriptions;
        CreateAnnualOrderL: Codeunit "Create Annual Orders";
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        SubscriptionsL.SetRange("BC Status", SubscriptionsL."BC Status"::Active);
        SubscriptionsL.Setfilter(cos_dateofentry, '%1..%2', CALCDATE('<-CY>', Today), CALCDATE('<+CY>', Today));
        SubscriptionsL.Setfilter("Next Invoice Date", '%1..%2', CALCDATE('<-CY+1Y>', Today), CALCDATE('<+CY+1Y>', Today));
        if SubscriptionsL.FindSet() then
            repeat
                if not CreateAnnualOrderL.Run(SubscriptionsL) then begin
                    Subscriptions2L.Get(SubscriptionsL."cos_abonnementId");
                    Subscriptions2L."Error Message" := GetLastErrorText();
                    Subscriptions2L."Process Status" := Subscriptions2L."Process Status"::Error;
                    Subscriptions2L.Modify();
                end else begin
                    Subscriptions2L.Get(SubscriptionsL.cos_abonnementid);
                    Subscriptions2L."Error Message" := '';
                    Subscriptions2L."Last Invoice Date" := today;
                    Subscriptions2L."Process Status" := Subscriptions2L."Process Status"::" ";
                    Subscriptions2L."Next Invoice Date" := CalcDate('<1Y>', today);
                    Subscriptions2L.Modify();
                end;
                Commit();
            until SubscriptionsL.next() = 0;
    end;

    procedure PostSubscriptions()
    var
        SalesHeaderL: Record "Sales Header";
        ZeroGuidL: GUid;
    begin
        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
        SalesHeaderL.setfilter("Subscription No.", '<>%1', '');
        SalesHeaderL.SetRange("Subscription Order", true);
        SalesHeaderL.SetFilter("Subscription Entry No.", '<>%1', ZeroGuidL);
        if SalesHeaderL.FindSet() then
            repeat
                if not codeunit.run(codeunit::SubscriptionPost, SalesHeaderL) then begin
                    //??
                end;
                Commit();
            until SalesHeaderL.next() = 0;
    end;

    procedure SendSubscriptionEmails()
    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        SalesInvoiceHeader2L: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeaderL.SetRange("Subscription Order", true);
        SalesInvoiceHeaderL.SetFilter("Subscription No.", '<>%1', '');
        SalesInvoiceHeaderL.SetRange("Subscription Email Sent", false);
        if SalesInvoiceHeaderL.FindSet() then begin
            repeat
                if not codeunit.run(codeunit::SubscriptionSend, SalesInvoiceHeaderL) then begin
                    SalesInvoiceHeader2L.Get(SalesInvoiceHeaderL."No.");
                    SalesInvoiceHeader2L."Subscription Email Error" := copystr(GetLastErrorText(), 1, 250);
                    SalesInvoiceHeader2L."Subscription Email Sent" := false;
                    SalesInvoiceHeader2L.modify();
                end else begin
                    SalesInvoiceHeader2L.Get(SalesInvoiceHeaderL."No.");
                    SalesInvoiceHeader2L."Subscription Email Error" := '';
                    SalesInvoiceHeader2L."Subscription Email Sent" := true;
                    SalesInvoiceHeader2L.modify();
                end;
                Commit();
            until SalesInvoiceHeaderL.Next() = 0;
        end
    end;

    procedure FillData(UpdateEverything: Boolean)
    var
        SubscriptionsL: Record Subscriptions;
    begin
        SubscriptionsL.SetRange("BC Status", SubscriptionsL."BC Status"::Active);
        if not UpdateEverything then
            SubscriptionsL.SetRange("Data Updated", false);
        if SubscriptionsL.FindSet() then
            repeat
                SubscriptionsL.FillCRMFields(SubscriptionsL.cos_abonnementId);
            until SubscriptionsL.next() = 0;
    end;

    // procedure ChangeStatusOLD()
    // var
    //     SubscriptionsL: Record Subscriptions;
    // begin
    //     SubscriptionsL.SetRange("BC Status", SubscriptionsL."BC Status"::Active);
    //     SubscriptionsL.SetFilter(cos_endofdeliveryyear, '..%1&<>%2', format(Date2DMY(today, 3)), '');
    //     if SubscriptionsL.FindSet(true) then
    //         repeat
    //             SubscriptionsL."BC Status" := SubscriptionsL."BC Status"::Inactive;
    //             SubscriptionsL.modify();
    //         until SubscriptionsL.next() = 0;

    //     SubscriptionsL.Reset();
    //     SubscriptionsL.SetRange("BC Status", SubscriptionsL."BC Status"::Inactive);
    //     SubscriptionsL.SetFilter(cos_endofdeliveryyear, '>%1|=%2', format(Date2DMY(today, 3)), '');
    //     if SubscriptionsL.FindSet(true) then
    //         repeat
    //             SubscriptionsL."BC Status" := SubscriptionsL."BC Status"::Active;
    //             SubscriptionsL.modify();
    //         until SubscriptionsL.next() = 0;
    // end;

    procedure ChangeStatus()
    var
        SubscriptionsL: Record Subscriptions;
        YearL: integer;
        MonthL: integer;
    begin
        YearL := Date2DMY(today, 3);
        MonthL := Date2DMY(today, 2);

        SubscriptionsL.Reset();
        SubscriptionsL.SetFilter(cos_endofdeliveryyear, '>=%1|=%2', format(Date2DMY(today, 3)), '');
        if SubscriptionsL.FindSet(true) then
            repeat
                if SubscriptionsL.cos_Abostatus in [SubscriptionsL.cos_Abostatus::"AktivMitTerminkündigung", SubscriptionsL.cos_Abostatus::"AktivOhneTerminkündigung"] then begin
                    SubscriptionsL."BC Status" := SubscriptionsL."BC Status"::Active;
                end else begin
                    SubscriptionsL."BC Status" := SubscriptionsL."BC Status"::Inactive;
                end;

                if (SubscriptionsL.cos_endofdeliveryyear = Format(YearL)) and (MonthL >= 11) then begin
                    SubscriptionsL."BC Status" := SubscriptionsL."BC Status"::Inactive;
                end;

                SubscriptionsL.modify();
            until SubscriptionsL.next() = 0;

        SubscriptionsL.Reset();
        SubscriptionsL.SetFilter(cos_endofdeliveryyear, '<%1&<>%2', format(Date2DMY(today, 3)), '');
        if SubscriptionsL.FindSet(true) then
            repeat
                SubscriptionsL."BC Status" := SubscriptionsL."BC Status"::Inactive;
                SubscriptionsL.modify();
            until SubscriptionsL.next() = 0;


    end;



    procedure SetSingleSubscription(SubscriptionIDV: Guid)
    begin
        SubscriptionIDG := SubscriptionIDV;
    end;

    var
        SubscriptionIDG: Guid;
}