page 60726 "Subscription Card"
{
    ApplicationArea = All;
    Caption = 'Abonnement Karte';
    PageType = Card;
    SourceTable = Subscriptions;
    DataCaptionExpression = Rec.cos_name;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Allgemein';
                // field(statecode; Rec.statecode)
                // {
                //     ApplicationArea = All;
                // }
                field("BC Status"; Rec."BC Status")
                {
                    ApplicationArea = All;
                }

                field("Last Invoice Date"; Rec."Last Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Next Invoice Date"; Rec."Next Invoice Date")
                {
                    ApplicationArea = All;
                }


                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                }
                //oder aus item?
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    Caption = 'Geb. Rechnungen';
                    DrillDown = true;
                    DrillDownPageId = "Posted Sales Invoices";
                }
                field("Process Status"; Rec."Process Status")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }

                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }

            }
            group(Subscription)
            {
                Caption = 'Abo';

                field(cos_name; Rec.cos_name)
                {
                }
                field(cos_BasicProduct; Rec.cos_BasicProduct)
                {
                    Editable = false;
                }
                field("Product No."; Rec."Product No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemL: record Item;
                    begin
                        if iteml.get(Rec."Product No.") then
                            Rec."Product Name" := ItemL.Description;
                    end;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = All;
                }

                field(cos_Menge; Rec.cos_Menge)
                {
                }
                field(cos_abotypnew; Rec.cos_abotypnew)
                {
                    ApplicationArea = All;
                }
                field(new_Rabatt; Rec.new_Rabatt)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Rabattname; Rec.Rabattname)
                {
                    ApplicationArea = All;
                }
                field("Rabatt %"; Rec."Rabatt %")
                {
                    ApplicationArea = All;
                }


                // field(new_abostatus; Rec.new_abostatus)
                // {
                //     ApplicationArea = All;
                // }
                field(cos_Abostatus; Rec.cos_Abostatus)
                {
                }
                field(cos_account; Rec.cos_account)
                {
                    Editable = false;
                }
                field("AccountNo."; Rec."AccountNo")
                {
                    ApplicationArea = All;
                }
                field(AccountName; Rec.AccountName)
                {
                    ApplicationArea = All;
                }

                field(cos_firmenzusatz; Rec.cos_firmenzusatz)
                {
                }
                field(new_IhreReferenz; Rec.new_IhreReferenz)
                {
                    ApplicationArea = All;
                }

                field(cos_orderbycontact; Rec.cos_orderbycontact)
                {
                    editable = false;
                }
                field(OrderByContactName; Rec.OrderByContactName)
                {
                    ApplicationArea = All;
                }
                field(cos_lieferungankunde; Rec.cos_lieferungankunde)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ShipToAccountName; Rec.ShipToAccountName)
                {
                    ApplicationArea = All;
                }
                field(cos_shiptocontact; Rec.cos_shiptocontact)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ShipToContactName; Rec.ShipToContactName)
                {
                    ApplicationArea = All;
                }

                field(cos_kontaktzusatz; Rec.cos_kontaktzusatz)
                {
                    ApplicationArea = All;
                }
                field(cos_Abonummer; Rec.cos_Abonummer)
                {
                }
                field(cos_order; Rec.cos_order)
                {
                    Editable = false;
                }
                field(cos_OrderID; Rec.cos_OrderID)
                {
                }
                field(vv_EMailInvoiceRecipient; Rec.vv_EMailInvoiceRecipient)
                {
                }
                field(cos_orderdate; Rec.cos_orderdate)
                {
                }
                field(cos_dateofentry; Rec.cos_dateofentry)
                {
                }
            }
            group(BillingADdress)
            {
                Caption = 'Rechnungsadresse';
                field(cos_billtoaddress; Rec.cos_billtoaddress)
                {
                    Editable = false;
                }
                field(cos_billtoaddressName; Rec.cos_billtoaddressName)
                {
                    ApplicationArea = All;
                }
                field(BillingAddresStreet; Rec.BillingAddresStreet)
                {
                    ApplicationArea = All;
                }
                field(BillingAddresStreet2; Rec.BillingAddresStreet2)
                {
                    ApplicationArea = All;
                }
                field(BillingAddresZipCode; Rec.BillingAddresZipCode)
                {
                    ApplicationArea = All;
                }
                field(BillingAddresCity; Rec.BillingAddresCity)
                {
                    ApplicationArea = All;
                }
                field(BillingAddresCountry; Rec.BillingAddresCountry)
                {
                    ApplicationArea = All;
                }
            }
            group(ShippingAddress)
            {
                Caption = 'Lieferadresse';
                field(cos_shiptoaddress; Rec.cos_shiptoaddress)
                {
                    Editable = false;
                }
                field(cos_shiptoaddressName; Rec.cos_shiptoaddressName)
                {
                    ApplicationArea = All;
                }
                field(ShippingAddresStreet; Rec.ShippingAddresStreet)
                {
                    ApplicationArea = All;
                }
                field(ShippingAddresStreet2; Rec.ShippingAddresStreet2)
                {
                    ApplicationArea = All;
                }
                field(ShippingAddresZipCode; Rec.ShippingAddresZipCode)
                {
                    ApplicationArea = All;
                }
                field(ShippingAddresCity; Rec.ShippingAddresCity)
                {
                    ApplicationArea = All;
                }
                field(ShippingAddresCountry; Rec.ShippingAddresCountry)
                {
                    ApplicationArea = All;
                }
            }
            group(Cancellation)
            {
                caption = 'Kündigung';
                field(cos_dateofcancellation; Rec.cos_dateofcancellation)
                {
                }
                field(cos_reasonfordismissal; Rec.cos_reasonfordismissal)
                {
                }
                field(cos_LEdateofentry; Rec.cos_LEdateofentry)
                {
                }
                // field(cos_deliveryend; Rec.cos_deliveryend)
                // {
                // }
                field(cos_endofdeliveryyear; Rec.cos_endofdeliveryyear)
                {
                }
                field(cos_lieferbeginn; Rec.cos_lieferbeginn)
                {
                }
            }
            group(contact)
            {
                caption = 'Bestellt durch Kontakt';
                // field(cos_contact; Rec.cos_contact)
                // {
                // }
                field(OrderByContactFirstName; Rec.OrderByContactFirstName)
                {
                    ApplicationArea = All;
                }
                field(OrderByContactLastName; Rec.OrderByContactLastName)
                {
                    ApplicationArea = All;
                }
                field(OrderByContactBusinessPhone; Rec.OrderByContactBusinessPhone)
                {
                    ApplicationArea = All;
                }
                field(OrderByContactMobile; Rec.OrderByContactMobile)
                {
                    ApplicationArea = All;
                }
                field(OrderByContactEmail; Rec.OrderByContactEmail)
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
                caption = 'Abo';

                actionref(createorder_ref; CreateOrder)
                {

                }

                actionref(OpenOrder_ref; OpenOrder)
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
            action(CreateOrder)
            {
                ApplicationArea = All;
                Caption = 'Auftrag erstellen';
                image = Create;

                trigger OnAction()
                var
                    SubscriptionsL: Record Subscriptions;
                    SubscriptionHelperL: Codeunit SubscriptionHelper;
                    SubscriptionRunnerL: Codeunit SubscriptionRunner;
                begin
                    SubscriptionRunnerL.SetSingleSubscription(Rec.cos_abonnementId);
                    SubscriptionRunnerL.CreateOrdersFromSubscriptions();
                end;
            }
            action(OpenOrder)
            {
                ApplicationArea = All;
                caption = 'Auftrag öffnen';
                image = Order;
                RunObject = page "Sales Order";
                RunPageLink = "No." = field("Sales Order No."), "Document Type" = const(Order);
            }

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
