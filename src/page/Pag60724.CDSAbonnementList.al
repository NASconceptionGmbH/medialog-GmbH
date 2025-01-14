page 60724 "CDS Abonnement List"
{
    Caption = 'CDS Abonnement List';
    PageType = List;
    SourceTable = "CDS cos_abonnement";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field(cos_abonnementId; Rec.cos_abonnementId)
                {
                    ToolTip = 'Specifies the value of the AbonnementID field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the Erstellt am field.';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the Erstellt von field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Geändert am field.';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'Specifies the value of the Geändert von field.';
                }
                field(CreatedOnBehalfBy; Rec.CreatedOnBehalfBy)
                {
                    ToolTip = 'Specifies the value of the Erstellt von (Stellvertreter) field.';
                }
                field(ModifiedOnBehalfBy; Rec.ModifiedOnBehalfBy)
                {
                    ToolTip = 'Specifies the value of the Geändert von (Stellvertreter) field.';
                }
                field(OwnerId; Rec.OwnerId)
                {
                    ToolTip = 'Specifies the value of the Besitzer field.';
                }
                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                    ToolTip = 'Specifies the value of the Besitzer (Unternehmenseinheit) field.';
                }
                field(OwningUser; Rec.OwningUser)
                {
                    ToolTip = 'Specifies the value of the Besitzer (Benutzer) field.';
                }
                field(OwningTeam; Rec.OwningTeam)
                {
                    ToolTip = 'Specifies the value of the Besitzer (Team) field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Statusgrund field.';
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                    ToolTip = 'Specifies the value of the Versionsnummer field.';
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                    ToolTip = 'Specifies the value of the Importsequenznummer field.';
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ToolTip = 'Specifies the value of the Datensatz erstellt am field.';
                }
                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                    ToolTip = 'Specifies the value of the Versionsnummer der Zeitzonenregel field.';
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                    ToolTip = 'Specifies the value of the Zeitzonencode für die UTC-Konvertierung field.';
                }
                field(cos_name; Rec.cos_name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(cos_AbonnementsContactsId; Rec.cos_AbonnementsContactsId)
                {
                    ToolTip = 'Specifies the value of the Abonnements field.';
                }
                field(cos_AbonnementsId; Rec.cos_AbonnementsId)
                {
                    ToolTip = 'Specifies the value of the Abonnements field.';
                }
                field(cos_Abostatus; Rec.cos_Abostatus)
                {
                    ToolTip = 'Specifies the value of the Abostatus field.';
                }
                field(cos_abotyp; Rec.cos_abotyp)
                {
                    ToolTip = 'Specifies the value of the Abo-Typ Old field.';
                }
                field(cos_account; Rec.cos_account)
                {
                    ToolTip = 'Specifies the value of the Firma field.';
                }
                field(cos_Adresse; Rec.cos_Adresse)
                {
                    ToolTip = 'Specifies the value of the Adresse field.';
                }
                field(cos_BasicProduct; Rec.cos_BasicProduct)
                {
                    ToolTip = 'Specifies the value of the Basic Produkt field.';
                }
                field(cos_billtoaddress; Rec.cos_billtoaddress)
                {
                    ToolTip = 'Specifies the value of the Rechnungsadresse field.';
                }
                field(cos_characteristics; Rec.cos_characteristics)
                {
                    ToolTip = 'Specifies the value of the Merkmal field.';
                }
                field(cos_contact; Rec.cos_contact)
                {
                    ToolTip = 'Specifies the value of the Kontakt field.';
                }
                field(cos_dateofentry; Rec.cos_dateofentry)
                {
                    ToolTip = 'Specifies the value of the Erfassungsdatum field.';
                }
                field(cos_deliveryend; Rec.cos_deliveryend)
                {
                    ToolTip = 'Specifies the value of the Lieferende field.';
                }
                field(cos_dismissal; Rec.cos_dismissal)
                {
                    ToolTip = 'Specifies the value of the Kündigung zum field.';
                }
                field(cos_end; Rec.cos_end)
                {
                    ToolTip = 'Specifies the value of the Laufzeit Ende field.';
                }
                field(cos_endofdeliveryyear; Rec.cos_endofdeliveryyear)
                {
                    ToolTip = 'Specifies the value of the Lieferende (Jahr) field.';
                }
                field(cos_LEdateofentry; Rec.cos_LEdateofentry)
                {
                    ToolTip = 'Specifies the value of the Letzte Auslieferung field.';
                }
                field(cos_order; Rec.cos_order)
                {
                    ToolTip = 'Specifies the value of the Auftrag field.';
                }
                field(cos_orderdate; Rec.cos_orderdate)
                {
                    ToolTip = 'Specifies the value of the Bestelldatum field.';
                }
                field(cos_OrderID; Rec.cos_OrderID)
                {
                    ToolTip = 'Specifies the value of the Auftrags-ID field.';
                }
                field(cos_reasonfordismissal; Rec.cos_reasonfordismissal)
                {
                    ToolTip = 'Specifies the value of the Kündigungsgrund field.';
                }
                field(cos_Reklamation; Rec.cos_Reklamation)
                {
                    ToolTip = 'Specifies the value of the Reklamation field.';
                }
                field(cos_shiptoaddress; Rec.cos_shiptoaddress)
                {
                    ToolTip = 'Specifies the value of the Lieferadresse field.';
                }
                field(cos_sparte; Rec.cos_sparte)
                {
                    ToolTip = 'Specifies the value of the Sparte field.';
                }
                field(cos_start; Rec.cos_start)
                {
                    ToolTip = 'Specifies the value of the Laufzeit Start field.';
                }
                field(cos_startofdelivery; Rec.cos_startofdelivery)
                {
                    ToolTip = 'Specifies the value of the Lieferbeginn field.';
                }
                field(cos_startofdeliveryyear; Rec.cos_startofdeliveryyear)
                {
                    ToolTip = 'Specifies the value of the Lieferbeginn (Jahr) field.';
                }
                field(cos_status; Rec.cos_status)
                {
                    ToolTip = 'Specifies the value of the Zustand field.';
                }
                field(cos_typeofcustomer; Rec.cos_typeofcustomer)
                {
                    ToolTip = 'Specifies the value of the Kundenart field.';
                }
                field(cos_ReklamationName; Rec.cos_ReklamationName)
                {
                    ToolTip = 'Specifies the value of the cos_ReklamationName field.';
                }
                field(cos_billtoaddressName; Rec.cos_billtoaddressName)
                {
                    ToolTip = 'Specifies the value of the cos_billtoaddressName field.';
                }
                field(cos_shiptoaddressName; Rec.cos_shiptoaddressName)
                {
                    ToolTip = 'Specifies the value of the cos_shiptoaddressName field.';
                }
                field(cos_AdresseName; Rec.cos_AdresseName)
                {
                    ToolTip = 'Specifies the value of the cos_AdresseName field.';
                }
                field(cos_characteristicsName; Rec.cos_characteristicsName)
                {
                    ToolTip = 'Specifies the value of the cos_characteristicsName field.';
                }
                field(cos_typeofcustomerName; Rec.cos_typeofcustomerName)
                {
                    ToolTip = 'Specifies the value of the cos_typeofcustomerName field.';
                }
                field(cos_sparteName; Rec.cos_sparteName)
                {
                    ToolTip = 'Specifies the value of the cos_sparteName field.';
                }
                field(cos_commentdismissal; Rec.cos_commentdismissal)
                {
                    ToolTip = 'Specifies the value of the Kommentar Kündigung field.';
                }
                field(cos_dataimport; Rec.cos_dataimport)
                {
                    ToolTip = 'Specifies the value of the Datenimport field.';
                }
                field(cos_shiptocontact; Rec.cos_shiptocontact)
                {
                    ToolTip = 'Specifies the value of the Lieferung an Kontakt field.';
                }
                field(cos_orderbycontact; Rec.cos_orderbycontact)
                {
                    ToolTip = 'Specifies the value of the Bestellt durch Kontakt field.';
                }
                field(cos_dateofcancellation; Rec.cos_dateofcancellation)
                {
                    ToolTip = 'Specifies the value of the Kündigungsdatum field.';
                }
                field(cos_Anrede; Rec.cos_Anrede)
                {
                    ToolTip = 'Specifies the value of the Anrede field.';
                }
                field(cos_Vorname; Rec.cos_Vorname)
                {
                    ToolTip = 'Specifies the value of the Vorname field.';
                }
                field(cos_Nachname; Rec.cos_Nachname)
                {
                    ToolTip = 'Specifies the value of the Nachname field.';
                }
                field(cos_Strae; Rec.cos_Strae)
                {
                    ToolTip = 'Specifies the value of the Straße field.';
                }
                field(cos_PLZ; Rec.cos_PLZ)
                {
                    ToolTip = 'Specifies the value of the PLZ field.';
                }
                field(cos_Ort; Rec.cos_Ort)
                {
                    ToolTip = 'Specifies the value of the Ort field.';
                }
                field(cos_Laendercode; Rec.cos_Laendercode)
                {
                    ToolTip = 'Specifies the value of the Ländercode field.';
                }
                field(cos_Menge; Rec.cos_Menge)
                {
                    ToolTip = 'Specifies the value of the Menge field.';
                }
                field(cos_Strasse2; Rec.cos_Strasse2)
                {
                    ToolTip = 'Specifies the value of the Straße 2 field.';
                }
                field(cos_Adresszusatz; Rec.cos_Adresszusatz)
                {
                    ToolTip = 'Specifies the value of the Adresszusatz field.';
                }
                field(cos_salutation; Rec.cos_salutation)
                {
                    ToolTip = 'Specifies the value of the Anrede field.';
                }
                field(cos_grossinvoiceamount; Rec.cos_grossinvoiceamount)
                {
                    ToolTip = 'Specifies the value of the Faktursummer (brutto) field.';
                }
                field(cos_abo_typ; Rec.cos_abo_typ)
                {
                    ToolTip = 'Specifies the value of the Abo-Typ Übertrag field.';
                }
                field(cos_abostatusuebertrag; Rec.cos_abostatusuebertrag)
                {
                    ToolTip = 'Specifies the value of the Abostatus Übertrag field.';
                }
                field(cos_firmenzusatz; Rec.cos_firmenzusatz)
                {
                    ToolTip = 'Specifies the value of the Firmenzusatz field.';
                }
                field(cos_kontaktzusatz; Rec.cos_kontaktzusatz)
                {
                    ToolTip = 'Specifies the value of the Kontaktzusatz field.';
                }
                field(cos_lieferempfaengerkontakt; Rec.cos_lieferempfaengerkontakt)
                {
                    ToolTip = 'Specifies the value of the Lieferempfänger (Kontakt) field.';
                }
                field(cos_lieferempfangerfirma; Rec.cos_lieferempfangerfirma)
                {
                    ToolTip = 'Specifies the value of the Lieferempfänger (Firma) field.';
                }
                field(cos_lieferungankunde; Rec.cos_lieferungankunde)
                {
                    ToolTip = 'Specifies the value of the Lieferung an Kunde field.';
                }
                field(cos_Abonummer; Rec.cos_Abonummer)
                {
                    ToolTip = 'Specifies the value of the Abonummer field.';
                }
                field(cos_lieferbeginn; Rec.cos_lieferbeginn)
                {
                    ToolTip = 'Specifies the value of the Lieferbeginn field.';
                }
                field(cos_flowhasrun; Rec.cos_flowhasrun)
                {
                    ToolTip = 'Specifies the value of the FlowHasRun field.';
                }
                field(cos_BestellungAbonnementId; Rec.cos_BestellungAbonnementId)
                {
                    ToolTip = 'Specifies the value of the BetsellungAbonnement field.';
                }
                field(cos_AboTypNew; Rec.cos_AboTypNew)
                {
                    ToolTip = 'Specifies the value of the Abo-Typ field.';
                }
                field(new_accountguid; Rec.new_accountguid)
                {
                    ToolTip = 'Specifies the value of the Firmen GUID field.';
                }
                field(new_customerguid; Rec.new_customerguid)
                {
                    ToolTip = 'Specifies the value of the Kunden GUID field.';
                }
                field(vv_EMailInvoiceRecipient; Rec.vv_EMailInvoiceRecipient)
                {
                    ToolTip = 'Specifies the value of the Rechnungsempfänger E-Mail field.';
                }
                field(new_abostatus; Rec.new_abostatus)
                {
                    ToolTip = 'Specifies the value of the Abostatus field.';
                }
                // field(AccountName; Rec.AccountName)
                // {
                //     ApplicationArea = All;
                // }
                // field(AccountNo; Rec.AccountNo)
                // {
                //     ApplicationArea = All;
                // }
                // field("Product Name"; Rec."Product Name")
                // {
                //     ApplicationArea = All;
                // }
                // field(OrderByContactName; Rec.OrderByContactName)
                // {
                //     ToolTip = 'Specifies the value of the Order By Contact Name field.';
                // }
                // field(ShipToAccountName; Rec.ShipToAccountName)
                // {
                //     ToolTip = 'Specifies the value of the Ship To Account Name field.';
                // }
                // field(ShipToContactName; Rec.ShipToContactName)
                // {
                //     ToolTip = 'Specifies the value of the Ship To Contact Name field.';
                // }
                // field(OrderByContactFirstName; Rec.OrderByContactFirstName)
                // {
                //     ApplicationArea = All;
                // }

                // field(BillingAddresZipCode; Rec.BillingAddresZipCode)
                // {
                //     ToolTip = 'Specifies the value of the Billing Addres Zip Code field.';
                // }
                // field(BillingAddresCity; Rec.BillingAddresCity)
                // {
                //     ToolTip = 'Specifies the value of the Billing Addres City field.';
                // }
                // field(BillingAddresCountry; Rec.BillingAddresCountry)
                // {
                //     ToolTip = 'Specifies the value of the Billing Addres City field.';
                // }
                // field(ShippingAddresZipCode; Rec.ShippingAddresZipCode)
                // {
                //     ToolTip = 'Specifies the value of the Shipping Addres Zip Code field.';
                // }
                // field(ShippingAddresCity; Rec.ShippingAddresCity)
                // {
                //     ToolTip = 'Specifies the value of the ShippingAddres City field.';
                // }
                // field(ShippingAddresCountry; Rec.ShippingAddresCountry)
                // {
                //     ToolTip = 'Specifies the value of the Shipping Addres City field.';
                // }
                // field(OrderByContactName2; Rec.OrderByContactName2)
                // {
                //     ApplicationArea = All;
                // }

                // field(OrderByContactLastName; Rec.OrderByContactLastName)
                // {
                //     ToolTip = 'Specifies the value of the Order By Contact Lastname field.';
                // }
                // field(OrderByContactBusinessPhone; Rec.OrderByContactBusinessPhone)
                // {
                //     ToolTip = 'Specifies the value of the Order By Contact Phone field.';
                // }
                // field(OrderByContactMobile; Rec.OrderByContactMobile)
                // {
                //     ToolTip = 'Specifies the value of the Order By Contact Mobile field.';
                // }
                // field(OrderByContactEmail; Rec.OrderByContactEmail)
                // {
                //     ToolTip = 'Specifies the value of the Order By Contact Email field.';
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateFromCDS)
            {
                ApplicationArea = All;
                Caption = 'Create in Business Central';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CDScosabonnement: Record "CDS cos_abonnement";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(CDScosabonnement);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(CDScosabonnement);
                end;
            }
        }
    }

    var
        CurrentlyCoupledCDScosabonnement: Record "CDS cos_abonnement";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCDScosabonnement(CDScosabonnement: Record "CDS cos_abonnement")
    begin
        CurrentlyCoupledCDScosabonnement := CDScosabonnement;
    end;
}