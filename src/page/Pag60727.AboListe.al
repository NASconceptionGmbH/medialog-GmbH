page 60727 "Abo Liste"
{
    ApplicationArea = All;
    Caption = 'Abo Liste';
    PageType = List;
    SourceTable = Subscriptions;
    UsageCategory = Lists;
    CardPageId = "Subscription Card";
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                // field("Entry No."; Rec."Entry No.")
                // {
                //     ApplicationArea = All;
                // }
                field("BC Status"; Rec."BC Status")
                {
                    ApplicationArea = All;
                }
                field(cos_endofdeliveryyear; Rec.cos_endofdeliveryyear)
                {
                    ApplicationArea = All;
                }

                field("Process Status"; Rec."Process Status")
                {
                    ApplicationArea = All;
                }


                field(cos_name; Rec.cos_name)
                {
                    ApplicationArea = All;
                }
                field("AccountNo."; Rec."AccountNo")
                {
                    ApplicationArea = All;
                }
                field(AccountName; Rec.AccountName)
                {
                    ApplicationArea = All;
                }
                field(cos_BasicProduct; Rec.cos_BasicProduct)
                {
                    ApplicationArea = All;
                }
                field("Product No."; Rec."Product No.")
                {
                    ApplicationArea = All;
                }

                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = All;
                }

                field(cos_OrderID; Rec.cos_OrderID)
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order created at"; Rec."Sales Order created at")
                {
                    ApplicationArea = All;
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    ApplicationArea = All;
                }


                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
    actions
    {
        area(Promoted)
        {
            group(Subscriptions)
            {
                caption = 'Abos';

                actionref(createorders_ref; CreateOrders)
                {

                }
                actionref(createorders2_ref; CreateOrders2)
                {

                }
                actionRef(createAnnualOrders_ref; CreateAnnualOrders)
                {

                }
                actionref(FillData_ref; FillData)
                {

                }
                actionref(FillData2_ref; FillData2)
                {

                }

            }
            group(Dataverse)
            {
                actionref(CDSGoToSubscription_ref; CDSGoToSubscription)
                {

                }
                actionref(CDSSynchronizeNow_ref; CDSSynchronizeNow)
                {

                }
                actionref(ShowLog_ref; ShowLog)
                {

                }
                group(Coupling_Ref)
                {
                    caption = 'Kopplung';
                    actionref(ManageCDSCoupling_ref; ManageCDSCoupling)
                    {

                    }
                    actionref(DeleteCDSCoupling_ref; DeleteCDSCoupling)
                    {

                    }
                }


            }

        }
        area(Processing)
        {
            action(CreateOrders)
            {
                ApplicationArea = All;
                Caption = 'Ausgewählte Aufträge erstellen';
                image = CreateDocument;

                trigger OnAction()
                var
                    SubscriptionsL: Record Subscriptions;
                    SubscriptionHelperL: Codeunit SubscriptionHelper;
                    SubscriptionRunnerL: Codeunit SubscriptionRunner;
                begin
                    SubscriptionsL := Rec;
                    CurrPage.SetSelectionFilter(SubscriptionsL);

                    if SubscriptionsL.FindSet() then
                        repeat
                            SubscriptionRunnerL.SetSingleSubscription(SubscriptionsL.cos_abonnementId);
                            SubscriptionRunnerL.CreateOrdersFromSubscriptions();
                        until SubscriptionsL.Next() = 0;
                end;
            }
            action(CreateOrders2)
            {
                ApplicationArea = All;
                Caption = 'Alle möglichen Aufträge erstellen';
                image = CreateDocument;

                trigger OnAction()
                var
                    SubscriptionsL: Record Subscriptions;
                    SubscriptionHelperL: Codeunit SubscriptionHelper;
                    SubscriptionRunnerL: Codeunit SubscriptionRunner;
                begin
                    SubscriptionRunnerL.CreateOrdersFromSubscriptions();
                end;
            }

            action(CreateAnnualOrders)
            {
                ApplicationArea = All;
                Caption = 'Abojahresfaktur';
                Image = CreateYear;

                trigger OnAction()
                var
                    SubscriptionsL: Record Subscriptions;
                    SubscriptionRunnerL: Codeunit SubscriptionRunner;
                    MonthL: integer;
                begin
                    MonthL := Date2DMY(Today, 2);
                    if MonthL <> 11 then
                        error('Es ist nicht November, die Jahresfaktur lässt sich nicht ausführen');

                    if Dialog.Confirm('Wollen sie die komplette Jahresfaktur jetzt ausführen?') then
                        SubscriptionRunnerL.RunAnnualSubscriptions();
                end;
            }
            action(FillData)
            {
                ApplicationArea = all;
                caption = 'BC Daten aktualisieren (einzelnd)';
                image = DataEntry;

                trigger OnAction()
                var
                    SubscriptionsL: Record Subscriptions;
                begin
                    SubscriptionsL.FillCRMFields(Rec.cos_abonnementId);
                end;
            }
            action(FillData2)
            {
                ApplicationArea = all;
                caption = 'BC Daten aktualisieren (alle))';
                image = DataEntry;

                trigger OnAction()
                var
                    SubscriptionsL: Record Subscriptions;
                    SubscriptionRunnerL: Codeunit SubscriptionRunner;
                begin
                    SubscriptionRunnerL.FillData(true);
                end;
            }
            // action(Deleteall)
            // {
            //     ApplicationArea = all;
            //     caption = 'Delete all entries(temp)';
            //     image = DataEntry;

            //     trigger OnAction()
            //     var
            //         SubscriptionsL: Record Subscriptions;
            //     begin
            //         SubscriptionsL.DeleteAll();
            //     end;
            // }


            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;

                action(CDSGoToSubscription)
                {
                    Caption = 'Abo in CRM';
                    Image = CoupledCustomer;
                    ToolTip = 'Open the coupled Dataverse lab book.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CDSSynchronizeNow)
                {
                    Caption = 'Synchronisieren';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Refresh;
                    Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Send or get updated data to or from Microsoft Dataverse.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }
                action(ShowLog)
                {
                    Caption = 'Synchronization Log';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Log;

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Microsoft Dataverse row.';

                    action(ManageCDSCoupling)
                    {
                        Caption = 'Koppeln';
                        ApplicationArea = All;
                        Visible = true;
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dataverse lab book.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                        end;
                    }
                    action(DeleteCDSCoupling)
                    {
                        Caption = 'Kopplung löschen';
                        ApplicationArea = All;
                        Visible = true;
                        Image = UnLinkAccount;
                        Enabled = CDSIsCoupledToRecord;
                        ToolTip = 'Delete the coupling to a Microsoft Dataverse lab book.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                        end;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if CDSIntegrationEnabled then
            CDSIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
    end;





    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CDSIntegrationEnabled: Boolean;
        CDSIsCoupledToRecord: Boolean;
}
