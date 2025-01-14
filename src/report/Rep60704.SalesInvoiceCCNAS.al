report 60704 "Sales Invoice CC NAS"
{
    RDLCLayout = './Layouts/Sales Invoice CC NAS.rdl';
    // WordLayout = './StandardSalesInvoice.docx';
    Caption = 'Sales - Invoice NAS';
    DefaultLayout = rdlc;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterHeading = 'Posted Sales Invoice';
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";

            column(CompanyAddress1; CompanyAddr[1])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
                IncludeCaption = false;
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
                IncludeCaption = false;
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
                IncludeCaption = false;
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
                IncludeCaption = false;
            }
            column(CompanyPicture; DummyCompanyInfo.Picture)
            {
                IncludeCaption = false;
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
                IncludeCaption = false;
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
                IncludeCaption = false;
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
                IncludeCaption = false;
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
                IncludeCaption = false;
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
                IncludeCaption = false;
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
                IncludeCaption = false;
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
                IncludeCaption = false;
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
                IncludeCaption = false;
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
                IncludeCaption = false;
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
                IncludeCaption = false;
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
                IncludeCaption = false;
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
                IncludeCaption = false;
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
                IncludeCaption = false;
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
                IncludeCaption = false;
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
                IncludeCaption = false;
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
                IncludeCaption = false;
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
                IncludeCaption = false;
            }
            column(CompanyLegalStatement; GetLegalStatement)
            {
                IncludeCaption = false;
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
                IncludeCaption = false;
            }
            column(CustomerAddress1; CustAddr[1])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress2; CustAddr[2])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress3; CustAddr[3])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress4; CustAddr[4])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress5; CustAddr[5])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress6; CustAddr[6])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress7; CustAddr[7])
            {
                IncludeCaption = false;
            }
            column(CustomerAddress8; CustAddr[8])
            {
                IncludeCaption = false;
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
                IncludeCaption = false;
            }
            column(YourReference; "Your Reference")
            {
                IncludeCaption = false;
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
                IncludeCaption = false;
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
                IncludeCaption = false;
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
                IncludeCaption = false;
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
                IncludeCaption = false;
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
                IncludeCaption = false;
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
                IncludeCaption = false;
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
                IncludeCaption = false;
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
                IncludeCaption = false;
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
                IncludeCaption = false;
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
                IncludeCaption = false;
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
                IncludeCaption = false;
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
                IncludeCaption = false;
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
                IncludeCaption = false;
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
                IncludeCaption = false;
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
                IncludeCaption = false;
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
                IncludeCaption = false;
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
                IncludeCaption = false;
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
                IncludeCaption = false;
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
                IncludeCaption = false;
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
                IncludeCaption = false;
            }
            column(DocumentNo; "No.")
            {
                IncludeCaption = false;
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
                IncludeCaption = false;
            }
            column(OrderNo; "Order No.")
            {
                IncludeCaption = false;
            }
            column(OrderNo_Lbl; FieldCaption("Order No."))
            {
                IncludeCaption = false;
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
                IncludeCaption = false;
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
                IncludeCaption = false;
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
                IncludeCaption = false;
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
                IncludeCaption = false;
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
                IncludeCaption = false;
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
                IncludeCaption = false;
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
                IncludeCaption = false;
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
                IncludeCaption = false;
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
                IncludeCaption = false;
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
                IncludeCaption = false;
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber)
            {
                IncludeCaption = false;
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl)
            {
                IncludeCaption = false;
            }
            column(SellToFaxNo; GetSellToCustomerFaxNo)
            {
                IncludeCaption = false;
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
                IncludeCaption = false;
            }
            column(PaymentReference; GetPaymentReference)
            {
                IncludeCaption = false;
            }
            column(From_Lbl; FromLbl)
            {
                IncludeCaption = false;
            }
            column(BilledTo_Lbl; BilledToLbl)
            {
                IncludeCaption = false;
            }
            column(ChecksPayable_Lbl; ChecksPayableText)
            {
                IncludeCaption = false;
            }
            column(PaymentReference_Lbl; GetPaymentReferenceLbl)
            {
                IncludeCaption = false;
            }
            column(LegalEntityType; Cust.GetLegalEntityType)
            {
                IncludeCaption = false;
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
            {
                IncludeCaption = false;
            }
            column(Copy_Lbl; CopyLbl)
            {
                IncludeCaption = false;
            }
            column(EMail_Header_Lbl; EMailLbl)
            {
                IncludeCaption = false;
            }
            column(HomePage_Header_Lbl; HomePageLbl)
            {
                IncludeCaption = false;
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
                IncludeCaption = false;
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
                IncludeCaption = false;
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
                IncludeCaption = false;
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
                IncludeCaption = false;
            }
            column(ExchangeRateAsText; ExchangeRateText)
            {
                IncludeCaption = false;
            }
            column(Page_Lbl; PageLbl)
            {
                IncludeCaption = false;
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
                IncludeCaption = false;
            }
            column(Questions_Lbl; QuestionsLbl)
            {
                IncludeCaption = false;
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText)
            {
                IncludeCaption = false;
            }
            column(DocumentTitle_Lbl; DocumentCaption)
            {
                IncludeCaption = false;
            }
            column(YourDocumentTitle_Lbl; YourSalesInvoiceLbl)
            {
                IncludeCaption = false;
            }
            column(Thanks_Lbl; ThanksLbl)
            {
                IncludeCaption = false;
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
                IncludeCaption = false;
            }
            column(RemainingAmount; RemainingAmount)
            {
                IncludeCaption = false;
            }
            column(RemainingAmountText; RemainingAmountTxt)
            {
                IncludeCaption = false;
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
                IncludeCaption = false;
            }
            column(Total_Lbl; TotalLbl)
            {
                IncludeCaption = false;
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
                IncludeCaption = false;
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
                IncludeCaption = false;
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
                IncludeCaption = false;
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
                IncludeCaption = false;
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
                IncludeCaption = false;
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
                IncludeCaption = false;
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
                IncludeCaption = false;
            }
            column(PackageTrackingNo; "Package Tracking No.")
            {
                IncludeCaption = false;
            }
            column(PackageTrackingNo_Lbl; FieldCaption("Package Tracking No."))
            {
                IncludeCaption = false;
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
                IncludeCaption = false;
            }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code"))
            {
                IncludeCaption = false;
            }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt)
            {
                IncludeCaption = false;
            }
            column(ExternalDocNo; "External Document No.")
            {
                IncludeCaption = false;
            }
            column(ExternalDocNo_Lbl; Fieldcaption("External Document No."))
            {
                IncludeCaption = false;
            }
            column(FirstItemDescription; FirstItemDescription)
            {
                IncludeCaption = false;
            }
            column(Posting_Date; "Posting Date")
            {
                IncludeCaption = false;
            }
            column(LangCode; LangCode)
            {
                IncludeCaption = false;
            }
            column(IhreBankVerbLbl; IhreBankVerbLbl)
            {
                IncludeCaption = false;
            }
            column(YourBankAccount; YourBankAccount)
            {
            }
            column(SEPAText1; SEPAText1)
            {

            }
            column(SEPAText2; SEPAText2)
            {

            }
            column(PaymentMethodG; PaymentMethodG)
            {

            }
            column(PaymentTermsCodeG; PaymentTermsCodeG)
            {

            }
            column(InvoiceDiscountG; InvoiceDiscountG)
            {

            }
            column(HeaderTextG; HeaderTextG)
            {

            }
            column(HeadlineTextG; HeadlineTextG)
            {

            }
            column(HeaderText2G; HeaderText2G)
            {

            }
            column(ClosingTextG; ClosingTextG)
            {

            }
            column(ClosingText2G; ClosingText2G)
            {

            }
            column(TelephoneTextG; TelephoneTextG)
            {

            }
            column(FooterText1G; FooterText1G)
            {

            }
            column(CEOTextG; CEOTextG)
            {

            }
            column(HyperlinkForFooterURL_Url; HyperlinkForFooterURL_Url)
            {

            }
            column(HyperlinkForFooterURL_UrlText; HyperlinkForFooterURL_UrlText)
            {

            }
            column(FooterText2G; FooterText2G)
            {

            }
            column(ClerkName; ClerkName)
            {

            }
            column(ClerkPosition; ClerkPosition)
            {

            }
            column(ClerkEmail; ClerkEmail)
            {

            }
            column(ClerkPhone; ClerkPhone)
            {

            }



            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ShowLines; ShowLines)
                { }

                column(LineNo_Line; "Line No.")
                {
                    IncludeCaption = false;
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                    IncludeCaption = false;
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                    IncludeCaption = false;
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                    IncludeCaption = false;
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                    IncludeCaption = false;
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                    IncludeCaption = false;
                }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                    IncludeCaption = false;
                }
                column(ItemNo_Line; "No.")
                {
                    IncludeCaption = false;
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                    IncludeCaption = false;
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                    IncludeCaption = false;
                }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                {
                    IncludeCaption = false;
                }
                column(Quantity_Line; FormattedQuantity)
                {
                    IncludeCaption = false;
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                    IncludeCaption = false;
                }
                column(Type_Line; Format(Type))
                {
                    IncludeCaption = false;
                }
                column(UnitPrice; FormattedUnitPrice)
                {
                    IncludeCaption = false;
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                    IncludeCaption = false;
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                    IncludeCaption = false;
                }
                column(UnitPriceInclVAT; UnitCostInclVat)
                {
                    IncludeCaption = false;
                    DecimalPlaces = 0 : 2;
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                    IncludeCaption = false;
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                    IncludeCaption = false;
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                    IncludeCaption = false;
                }
                column(VATPct_Line; FormattedVATPct)
                {
                    IncludeCaption = false;
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                    IncludeCaption = false;
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                    IncludeCaption = false;
                }
                column(JobTaskNo; JobTaskNo)
                {
                    IncludeCaption = false;
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                    IncludeCaption = false;
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                    IncludeCaption = false;
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                    IncludeCaption = false;
                }
                column(JobNo; JobNo)
                {
                    IncludeCaption = false;
                }
                column(Unit_Lbl; UnitLbl)
                {
                    IncludeCaption = false;
                }
                column(Qty_Lbl; QtyLbl)
                {
                    IncludeCaption = false;
                }
                column(Price_Lbl; PriceLbl)
                {
                    IncludeCaption = false;
                }
                column(PricePer_Lbl; PricePerLbl)
                {
                    IncludeCaption = false;
                }
                column(UnitPriceIncludingVAT; UnitPriceIncludingVAT)
                {
                    IncludeCaption = false;
                }
                column(ItemPrice; "Unit Price")
                {
                    IncludeCaption = false;
                }
                column(UnitOfMeasureG; UnitOfMeasureG)
                {

                }
                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    UseTemporary = true;
                    DataItemTableView = sorting("Document No.", "Line No.", "Entry No.");

                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                        IncludeCaption = false;
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                        IncludeCaption = false;
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                        IncludeCaption = false;
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        IncludeCaption = false;
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                        IncludeCaption = false;
                    }
                    trigger OnPreDataItem();
                    begin
                        SetRange("Line No.", Line."Line No.");


                    end;

                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    UseTemporary = true;
                    DataItemTableView = sorting("Document No.", "Line No.");

                    column(LineNo_AssemblyLine; "No.")
                    {
                        IncludeCaption = false;
                    }
                    column(Description_AssemblyLine; Description)
                    {
                        IncludeCaption = false;
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        IncludeCaption = false;
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {
                        IncludeCaption = false;
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                        IncludeCaption = false;
                    }
                    trigger OnPreDataItem();
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break;
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;

                }
                trigger OnPreDataItem();
                var
                    SalesInvoiceLineL: record "sales invoice line";
                begin
                    VATAmountLine.DeleteAll;
                    // VATClauseLine.DeleteAll;
                    GeneralPostingMatrixDescr.deleteall;
                    ShipmentLine.Reset;
                    ShipmentLine.DeleteAll;
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break;
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;


                    OnAfterLineOnPreDataItem(Header, Line);
                end;

                trigger OnAfterGetRecord();
                var
                    EnvironmentInfo: Codeunit "Environment Information";
                    Item: Record Item;
                    SalesInvoiceLineL: Record "Sales Invoice Line";
                    GeneralPostingSetupL: Record "General Posting Setup";
                    ItemUnitOfMeasureL: Record "Item Unit of Measure";
                    UnitOfMeasureL: Record "Unit of Measure";
                    UnitofMeasureTranslationL: Record "Unit of Measure Translation";
                begin
                    InitializeShipmentLine;
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    // Unit of Measure Code Translated                                       
                    if UnitOfMeasureL.Get(Line."Unit of Measure Code") then begin
                        if UnitofMeasureTranslationL.Get(Line."Unit of Measure Code", Header."Language Code") then begin
                            UnitOfMeasureG := UnitofMeasureTranslationL.Description;
                        end else begin
                            UnitOfMeasureG := UnitOfMeasureL.Description;
                        end;
                    end;


                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

                    VATAmountLine.Init;
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    if ("VAT %" <> 0) or ("VAT Clause Code" <> '') or (Amount <> "Amount Including VAT") then
                        VATAmountLine.InsertLine;

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalLineDiscountAmount -= "Line Discount Amount";
                    TotalDiscount -= "Inv. Discount Amount" + "Line Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    if ("Job No." <> '') and (not EnvironmentInfo.IsSaaS) then
                        JobNo := ''
                    else
                        JobNo := "Job No.";
                    if ("Job Task No." <> '') and (not EnvironmentInfo.IsSaaS) then
                        JobTaskNo := ''
                    else
                        JobTaskNo := "Job Task No.";

                    if JobTaskNo <> '' then begin
                        JobTaskNoLbl := JobTaskNoLbl2;
                        JobTaskDescription := GetJobTaskDescription(JobNo, JobTaskNo);
                    end else begin
                        JobTaskDescription := '';
                        JobTaskNoLbl := '';
                    end;

                    if JobNo <> '' then
                        JobNoLbl := JobNoLbl2
                    else
                        JobNoLbl := '';

                    FormatDocument.SetSalesInvoiceLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
                    if Type = type::Item then
                        if Header."Prices Including VAT" then
                            UnitCostInclVat := "Unit Price"
                        else
                            if "Quantity (Base)" <> 0 then
                                UnitCostInclVat := "Line Amount" / "Quantity (Base)"
                            else
                                UnitcostInclVat := 0;
                    if Quantity <> 0 then
                        UnitPriceIncludingVAT := "Amount Including VAT" / Quantity
                    else
                        UnitPriceIncludingVAT := 0;

                    if Item.get("No.") then begin
                        ItemPrice := item."Unit Price";
                    end else begin
                        ItemPrice := 0;
                    end;


                    IF (Type <> Type::" ") AND (Quantity > 0) then
                        ShowLines := true;
                    If (Type <> Type::" ") AND (Quantity = 0) then
                        ShowLines := false;

                    if ShowLines then
                        if GeneralPostingSetupL.Get("Gen. Bus. Posting Group", "Gen. Prod. Posting Group") then
                            if GeneralPostingSetupL.Description <> '' then begin
                                GeneralPostingMatrixDescr.init;
                                GeneralPostingMatrixDescr."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                GeneralPostingMatrixDescr."Gen. Prod Posting Group" := "Gen. Prod. Posting Group";
                                GeneralPostingMatrixDescr.Description := GeneralPostingSetupL.Description;
                                if not GeneralPostingMatrixDescr.insert then;
                            end

                end;


            }
            dataitem(WorkDescriptionLines; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = FILTER(1 .. 99999));

                column(WorkDescriptionLineNumber; Number)
                {
                    IncludeCaption = false;
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                    IncludeCaption = false;
                }
                trigger OnPreDataItem();
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break;
                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;

                trigger OnAfterGetRecord();
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break;
                    WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                end;

                trigger OnPostDataItem();
                begin
                    Clear(WorkDescriptionInstream)
                end;

            }

            dataitem(VATAmountLine; "VAT Amount Line")
            {
                UseTemporary = true;
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);

                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                    IncludeCaption = false;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                    IncludeCaption = false;
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                    IncludeCaption = false;
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                    IncludeCaption = false;
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                    IncludeCaption = false;
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                    IncludeCaption = false;
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                    IncludeCaption = false;
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                    IncludeCaption = false;
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                    IncludeCaption = false;
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                    IncludeCaption = false;
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                    IncludeCaption = false;
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    IncludeCaption = false;
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                    IncludeCaption = false;
                }
                column(NoOfVATIdentifiers; Count)
                {
                    IncludeCaption = false;
                }
                trigger OnPreDataItem();
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;

                trigger OnAfterGetRecord();
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;

                    // if ShowVATClause("VAT Clause Code") then begin
                    //     VATClauseLine := VATAmountLine;
                    //     if VATClauseLine.Insert then;
                    // end;
                end;

            }
            dataitem(GeneralPostingMatrixDescr; GeneralPostingMatrixDescr)
            {
                UseTemporary = true;
                column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group")
                {
                    IncludeCaption = false;
                }
                column(Gen__Prod__Posting_Group; "Gen. Prod Posting Group")
                {
                    IncludeCaption = false;
                }
                column(PostingDescription; Description)
                {
                    IncludeCaption = false;
                }
            }
            // dataitem(VATClauseLine; "VAT Amount Line")
            // {
            //     UseTemporary = true;

            //     column(VATClausesHeader; VATClausesText)
            //     {
            //         IncludeCaption = false;
            //     }
            //     column(VATIdentifier_VATClauseLine; "VAT Identifier")
            //     {
            //         IncludeCaption = false;
            //     }
            //     column(Code_VATClauseLine; VATClause.Code)
            //     {
            //         IncludeCaption = false;
            //     }
            //     column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
            //     {
            //         IncludeCaption = false;
            //     }
            //     column(Description_VATClauseLine; VATClause.Description)
            //     {
            //         IncludeCaption = false;
            //     }
            //     column(Description2_VATClauseLine; VATClause."Description 2")
            //     {
            //         IncludeCaption = false;
            //     }
            //     column(VATAmount_VATClauseLine; "VAT Amount")
            //     {
            //         IncludeCaption = false;
            //         AutoFormatType = 1;
            //     }
            //     column(NoOfVATClauses; Count)
            //     {
            //         IncludeCaption = false;
            //     }
            //     trigger OnPreDataItem();
            //     begin
            //         if Count = 0 then
            //             VATClausesText := ''
            //         else
            //             VATClausesText := VATClausesLbl;
            //     end;

            //     trigger OnAfterGetRecord();
            //     begin
            //         if "VAT Clause Code" = '' then
            //             CurrReport.Skip;
            //         if not VATClause.Get("VAT Clause Code") then
            //             CurrReport.Skip;
            //         VATClause.GetDescription(Header);
            //     end;

            // }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                UseTemporary = true;
                DataItemTableView = sorting("Line No.");

                column(Description_ReportTotalsLine; Description)
                {
                    IncludeCaption = false;
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                    IncludeCaption = false;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    IncludeCaption = false;
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                    IncludeCaption = false;
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                    IncludeCaption = false;
                }
                trigger OnPreDataItem();
                begin
                    CreateReportTotalLines;
                end;

            }
            dataitem(LineFee; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));

                column(LineFeeCaptionText; TempLineFeeNoteOnReportHist.ReportText)
                {
                    IncludeCaption = false;
                }
                trigger OnAfterGetRecord();
                begin
                    if not DisplayAdditionalFeeNote then
                        CurrReport.Break;

                    if Number = 1 then begin
                        if not TempLineFeeNoteOnReportHist.FindSet then
                            CurrReport.Break
                    end else
                        if TempLineFeeNoteOnReportHist.Next = 0 then
                            CurrReport.Break;
                end;

            }
            dataitem(PaymentReportingArgument; "Payment Reporting Argument")
            {
                UseTemporary = true;
                DataItemTableView = sorting(Key);

                column(PaymentServiceLogo; Logo)
                {
                    IncludeCaption = false;
                }
                column(PaymentServiceLogo_UrlText; "URL Caption")
                {
                    IncludeCaption = false;
                }
                column(PaymentServiceLogo_Url; GetTargetURL)
                {
                    IncludeCaption = false;
                }
                column(PaymentServiceText_UrlText; "URL Caption")
                {
                    IncludeCaption = false;
                }
                column(PaymentServiceText_Url; GetTargetURL)
                {
                    IncludeCaption = false;
                }
            }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                UseTemporary = true;
                DataItemTableView = sorting(ID);

                column(LeftHeaderName; Name)
                {
                    IncludeCaption = false;
                }
                column(LeftHeaderValue; Value)
                {
                    IncludeCaption = false;
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                UseTemporary = true;
                DataItemTableView = sorting(ID);

                column(RightHeaderName; Name)
                {
                    IncludeCaption = false;
                }
                column(RightHeaderValue; Value)
                {
                    IncludeCaption = false;
                }
            }
            dataitem(LetterText; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = CONST(1));

                column(GreetingText; GreetingLbl)
                {
                    IncludeCaption = false;
                }
                column(BodyText; BodyLbl)
                {
                    IncludeCaption = false;
                }
                column(ClosingText; ClosingLbl)
                {
                    IncludeCaption = false;
                }
                column(PmtDiscText; PmtDiscText)
                {
                    IncludeCaption = false;
                }
                trigger OnPreDataItem();
                begin
                    PmtDiscText := '';
                    if Header."Payment Discount %" <> 0 then
                        PmtDiscText := StrSubstNo(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                end;

            }
            dataitem("Shipping Addresses"; "Shipping Addresses")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Sales Order No." = FIELD("Order No.");
                DataItemTableView = sorting("Line No.");

                column(Sales_Order_No_; "Sales Order No.")
                {
                    IncludeCaption = false;
                }
                column(Line_No_; "Line No.")
                {
                    IncludeCaption = false;
                }
                column(Customer_No_; "Customer No.")
                {
                    IncludeCaption = false;
                }
                column(Name; Name)
                {
                    IncludeCaption = false;
                }
                column(Name_2; "Name 2")
                {
                    IncludeCaption = false;
                }
                column(Address; Address)
                {
                    IncludeCaption = false;
                }
                column(Address_2; "Address 2")
                {
                    IncludeCaption = false;
                }
                column(City; City)
                {
                    IncludeCaption = false;
                }
                column(Post_Code; "Post Code")
                {
                    IncludeCaption = false;
                }
                column(Country_RegionDesc; CountryDesc)
                {
                    IncludeCaption = false;
                }
                column(Contact; Contact)
                {
                    IncludeCaption = false;
                }
                column(Number; Number)
                {
                    IncludeCaption = false;
                }
                trigger OnAfterGetRecord();
                var
                    CountryRegionL: Record "Country/Region";
                    CountryRegionCode: Text;
                    StringLength: Decimal;
                begin
                    CountryDesc := '';
                    StringLength := StrLen("Shipping Addresses"."Country/Region");
                    if StringLength <= 10 then
                        CountryRegionCode := "Shipping Addresses"."Country/Region".Substring(1, StringLength);
                    if CountryRegionL.Get(CountryRegionCode) then
                        CountryDesc := CountryRegionL.Name;
                end;

            }
            dataitem(Totals; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = CONST(1));

                column(TotalNetAmount; TotalAmount)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                    IncludeCaption = false;
                }
                column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                    IncludeCaption = false;
                }
                column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                    IncludeCaption = false;
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText)
                {
                    IncludeCaption = false;
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                    IncludeCaption = false;
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                    IncludeCaption = false;
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    IncludeCaption = false;
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                {
                    IncludeCaption = false;
                }
                column(TotalText; TotalText)
                {
                    IncludeCaption = false;
                }
                column(TotalAmountExclInclVAT; TotalAmountExclInclVATValue)
                {
                    IncludeCaption = false;
                }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue)
                {
                    IncludeCaption = false;
                }
                column(TotalLineDiscountAmount; TotalLineDiscountAmount)
                {
                    IncludeCaption = false;
                }
                column(TotalDiscount; TotalDiscount)
                {
                    IncludeCaption = false;
                }
                trigger OnPreDataItem();
                begin
                    if Header."Prices Including VAT" then begin
                        TotalAmountExclInclVATTextValue := TotalExclVATText;
                        TotalAmountExclInclVATValue := TotalAmount;
                    end else begin
                        TotalAmountExclInclVATTextValue := TotalInclVATText;
                        TotalAmountExclInclVATValue := TotalAmountInclVAT;
                    end;
                end;

            }
            trigger OnPreDataItem();

            begin
                FirstLineHasBeenOutput := false;


            end;

            trigger OnAfterGetRecord();
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                PaymentServiceSetup: Record "Payment Service Setup";
                SalesInvoiceLineL: record "sales invoice line";
                Cust: Record Customer;
                SalesInvoiceLine2L: Record "Sales Invoice Line";
                CustLedgerEntryL: Record "Cust. Ledger Entry";
                TotalAmountL: Decimal;
                RoundedAndFormattedAmount: Text;
                PaymentTermsL: Record "Payment Terms";
                DummyDate: Date;
                DaysTilDue: integer;
                DaysTilDiscount: integer;
                AmountOfDaysL: Integer;
                PaymentMethodL: Record "Payment Method";
                PaymentMethodTranslationL: Record "Payment Method Translation";
                PostedSalesInvoiceL: Record "Sales Invoice Header";
                PaymrntTermsL: Record "Payment Terms";
                PaymentTermTranslationL: Record "Payment Term Translation";
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
                CustomerShipToL: Record Customer;
                ForNAVeDocumentInterfaceL: Codeunit "ForNAV eDocument Interface";
            begin
                "Language Code" := Language.GetUserLanguageCode;
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                if Header."Ship-To Customer No." <> '' then begin
                    if CustomerShipToL.Get(Header."Ship-To Customer No.") then begin
                        ShipToVATRegNo := CustomerShipToL."VAT Registration No.";
                    end;
                end;

                // Payment Method Code Check
                if PaymentMethodL.Get(Header."Payment Method Code") then begin
                    if PaymentMethodTranslationL.Get(Header."Payment Method Code", Header."Language Code") then begin
                        PaymentMethodG := PaymentMethodTranslationL.Description;
                    end else begin
                        PaymentMethodG := PaymentMethodL.Description;
                    end;
                end;

                // Payment Terms Code Check
                if PaymentTermsL.Get(Header."Payment Terms Code") then begin
                    if PaymentTermTranslationL.Get(Header."Payment Terms Code", Header."Language Code") then begin
                        PaymentTermsCodeG := PaymentTermTranslationL.Description;
                    end else begin
                        PaymentTermsCodeG := PaymentTermsL.Description;
                    end;
                end;

                // Invoice Discount
                if Header."Language Code" = 'ENU' then begin
                    InvoiceDiscountG := 'Invoice discount ';
                end else begin
                    InvoiceDiscountG := 'Rechnungsrabatt '
                end;



                if not IsReportInPreviewMode then
                    CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", Header);

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                Clear(PaymentInstructionsTxt);
                //PaymentInstructionsTxt := O365SalesInvoiceMgmt.GetPaymentInstructionsFromPostedInvoice(Header);

                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);

                FormatAddressFields(Header);
                FormatDocumentFields(Header);

                FillLeftHeader;
                FillRightHeader;

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                GetLineFeeNoteOnReportHist("No.");

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                CalcFields("Amount Including VAT");
                RemainingAmount := GetRemainingAmount;
                if RemainingAmount = 0 then
                    RemainingAmountTxt := AlreadyPaidLbl
                else
                    if RemainingAmount <> "Amount Including VAT" then
                        RemainingAmountTxt := StrSubstNo(PartiallyPaidLbl, Format(RemainingAmount, 0, '<Precision,2><Standard Format,0>'))
                    else
                        RemainingAmountTxt := '';

                SalesInvoiceLineL.SetRange("Document No.", Header."No.");
                SalesInvoiceLineL.setrange(Type, SalesInvoiceLineL.type::Item);
                if SalesInvoiceLineL.FindFirst() then
                    FirstItemDescription := SalesInvoiceLineL.Description;

                OnAfterGetSalesHeader(Header);

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;

                Cust.get("Bill-to Customer No.");
                LangCode := Cust."Language Code";


                Clear(YourBankAccount);

                if CustomerBank.get(Cust."No.", Cust."Preferred Bank Account Code") then begin
                    if CustomerBank.Name <> '' then
                        YourBankAccount := CustomerBank.Name + ', ';
                    if CustomerBank.IBAN <> '' then
                        YourBankAccount := YourBankAccount + 'IBAN: ' + CustomerBank.IBAN;
                    if CustomerBank."SWIFT Code" <> '' then
                        YourBankAccount := YourBankAccount + ', SWIFT: ' + CustomerBank."SWIFT Code";
                end;

                // SEPASkontoLbl: Label 'Wie vereinbart buchen wir den Betrag abzüglich %1 Skonto (verbleiben %2 EUR) von Ihrem Konto ab.';
                //     SEPALbl2: Label 'Die Forderung in Höhe von %1 EUR ziehen wir mit SEPA-Lastschrift von ihrem Konto IBAN %2 bei der %2 %3 zum Fälligkeitstag ein.';

                SEPAText1 := '';
                SEPAText2 := '';
                RoundedAndFormattedAmount := '';
                TotalAmountL := 0;

                SalesInvoiceLine2L.SetRange("Document No.", Header."No.");
                if SalesInvoiceLine2L.FindSet() then
                    repeat
                        TotalAmountL += SalesInvoiceLine2L."Amount Including VAT";
                    until SalesInvoiceLine2L.next() = 0;

                if PaymentTermsL.get(Header."Payment Terms Code") then begin
                    DummyDate := CalcDate(PaymentTermsL."Due Date Calculation", today);
                    DaysTilDue := DummyDate - Today;

                    DummyDate := CalcDate(PaymentTermsL."Discount Date Calculation", today);
                    DaysTilDiscount := DummyDate - Today;
                end else begin
                    DaysTilDiscount := 0;
                    DaysTilDue := 0;
                end;

                if (Header."Payment Discount %" > 0) AND (Header."Payment Method Code" = 'SEPA') then begin
                    CustLedgerEntryL.SetRange("Document No.", Header."No.");
                    CustLedgerEntryL.SetRange("Posting Date", Header."Posting Date");
                    CustLedgerEntryL.FindFirst();

                    RoundedAndFormattedAmount := Format(Round((TotalAmountL - CustLedgerEntryL."Original Pmt. Disc. Possible"), 0.01), 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    SEPAText1 := StrSubstNo(SEPASkontoLbl, (format(Header."Payment Discount %") + '%'), RoundedAndFormattedAmount);
                    SEPAText2 := StrSubstNo(SEPALbl2, RoundedAndFormattedAmount, CustomerBank.IBAN, CustomerBank.Name, CustomerBank."SWIFT Code")
                end;

                if (Header."Payment Discount %" > 0) AND (Header."Payment Method Code" <> 'SEPA') then begin
                    CustLedgerEntryL.SetRange("Document No.", Header."No.");
                    CustLedgerEntryL.SetRange("Posting Date", Header."Posting Date");
                    CustLedgerEntryL.FindFirst();

                    RoundedAndFormattedAmount := Format(Round((TotalAmountL - CustLedgerEntryL."Original Pmt. Disc. Possible"), 0.01), 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    SEPAText1 := StrSubstNo(SkontoLbl, DaysTilDue, DaysTilDiscount, (format(Header."Payment Discount %") + '%'), RoundedAndFormattedAmount);
                end;

                if (Header."Payment Discount %" = 0) AND (Header."Payment Method Code" = 'SEPA') then begin
                    RoundedAndFormattedAmount := Format(Round(TotalAmountL, 0.01), 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    SEPAText1 := SEPALbl1;
                    SEPAText2 := StrSubstNo(SEPALbl2, RoundedAndFormattedAmount, CustomerBank.IBAN, CustomerBank.Name, CustomerBank."SWIFT Code")
                end;

                NewLineG[1] := 10;
                if Header."Language Code" = 'ENU' then begin
                    HeaderText2G := 'Bill-to Customer No. ';
                    HeaderTextG := 'Thank you for your Order. Attached you can find our Invoice.';
                    ClosingTextG := 'Best regards';
                    ClosingText2G := 'i.A. ';
                    TelephoneTextG := 'Phone ';
                    CEOTextG := 'CEO: ';
                    FooterText1G := 'This e-mail contains confidential or legally protected information. If you are not the intended recipient, please inform us immediately and delete this e-mail including attachments. Unauthorized copying of this e-mail and unauthorized disclosure of the information contained therein are not permitted. Thank you';

                end else begin
                    HeaderText2G := 'Rechnung an Deb.-Nr. ';
                    HyperlinkForFooterURL_Url := 'https://www.vulkan-verlag.de/service/datenschutz/';
                    HyperlinkForFooterURL_UrlText := 'hier';
                    HeaderTextG := 'Vielen Dank für Ihre Bestellung. Im Anhang können Sie die Rechnung finden.';
                    ClosingTextG := 'Mit freundlichen Grüßen';
                    ClosingText2G := 'i.A. ';
                    TelephoneTextG := 'Telefon ';
                    CEOTextG := 'Geschäftsführer: ';
                    FooterText1G := 'Unser vollständiges Impressum finden Sie ';
                    FooterText2G := NewLineG + NewLineG + 'Diese E-Mail enthält vertrauliche oder rechtlich geschützte Informationen. Wenn Sie nicht der beabsichtige Empfänger sind, informieren Sie uns bitte sofort und löschen diese E-Mail samt Anlagen. Das unerlaubte Kopieren dieser E-Mail und die unbefugte Weitergabe der enthaltenen Informationen sind nicht gestattet. Vielen Dank';
                end;

                if SalespersonPurchaserL.Get(Header.Clerk) then begin
                    ClerkName := SalespersonPurchaserL.Name;
                    ClerkPosition := SalespersonPurchaserL."Job Title";
                    ClerkEmail := SalespersonPurchaserL."E-Mail";
                    ClerkPhone := SalespersonPurchaserL."Phone No.";
                end else
                    if SalespersonPurchaserL.Get(Header."Salesperson Code") then begin
                        ClerkName := SalespersonPurchaserL.Name;
                        ClerkPosition := SalespersonPurchaserL."Job Title";
                        ClerkEmail := SalespersonPurchaserL."E-Mail";
                        ClerkPhone := SalespersonPurchaserL."Phone No.";
                    end;

                ForNAVeDocumentInterfaceL.AddZugferd(report::"Sales Invoice CC NAS", Header.recordid);
            end;

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold. (Only possible for RDLC report layout.)';
                    }
                    field(DisplayShipmentInformation; DisplayShipmentInformation)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Shipments';
                        ToolTip = 'Specifies that shipments are shown on the document.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
                    }


                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get;
        SalesSetup.Get;
        CompanyInfo.VerifyAndSetPaymentInfo;


    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if Header.FindSet then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
                until Header.Next = 0;





    end;

    trigger OnPreReport()
    begin
        ShowLines := true;
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction;

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
        ;

    end;

    var
        SalespersonLbl: Label 'Salesperson';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        YourSalesInvoiceLbl: Label 'Your Invoice';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        VATClause: Record "VAT Clause";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        WorkDescriptionInstream: InStream;
        JobNo: Code[20];
        JobTaskNo: Code[20];
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[100];
        ChecksPayableText: Text;
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        PmtDiscText: Text;
        RemainingAmountTxt: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        TotalAmountExclInclVATTextValue: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        RemainingAmount: Decimal;
        TransHeaderAmount: Decimal;
        UnitCostInclVat: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        PaymentInstructionsTxt: Text;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        TotalAmountExclInclVATValue: Decimal;
        DisplayAdditionalFeeNote: Boolean;
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.';
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        FromLbl: Label 'From';
        BilledToLbl: Label 'Billed to';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        QuestionsLbl: Label 'Questions?';
        ThanksLbl: Label 'Thank You!';
        JobNoLbl2: Label 'Job No.';
        JobTaskNoLbl2: Label 'Job Task No.';
        JobTaskDescription: Text[100];
        JobTaskDescLbl: Label 'Job Task Description';
        UnitLbl: Label 'Unit';
        VATClausesText: Text;
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        UnitPriceIncludingVAT: Decimal;
        TotalLineDiscountAmount: Decimal;
        TotalDiscount: Decimal;
        ItemPrice: Decimal;
        FirstItemDescription: TExt;
        CountryDesc: Text;

        ShowLines: Boolean;
        LangCode: Code[3];
        IhreBankVerbLbl: label 'Your Bank Details';
        YourBankAccount: Text;
        CustomerBank: Record "Customer Bank Account";
        AutoFormat: Codeunit "Auto Format";

        SEPAText1: Text;
        SEPATExt2: TExt;
        SEPASkontoLbl: Label 'Wie vereinbart buchen wir den Betrag abzüglich %1 Skonto (verbleiben %2 EUR) von Ihrem Konto ab.';
        SEPALbl1: Label 'Wie vereinbart buchen wir den Betrag von Ihrem Konto ab.';
        SkontoLbl: Label 'Zahlbar netto innerhalb von %1 Tagen nach Rechnungsdatum, innerhalb von %2 Tagen abzüglich %3 Skonto, verbleiben %4 EUR.';
        SEPALbl2: Label 'Die Forderung in Höhe von %1 EUR ziehen wir mit SEPA-Lastschrift von ihrem Konto IBAN %2 bei der %3 %4 zum Fälligkeitstag ein.';
        PaymentMethodG: Text;
        PaymentTermsCodeG: Text;
        UnitOfMeasureG: Text;
        InvoiceDiscountG: Text;
        ShipToVATRegNo: Text[20];



    local procedure InitLogInteraction()
    begin
        // LogInteraction := SegManagement.FindInteractTmplCode(4) <> ''; //Marked as obsolete
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;



    local procedure InitializeShipmentLine()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
    begin
        if Line.Type = Line.Type::" " then
            exit;

        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.Get(Line."Shipment No.") then
                exit;

        ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.Reset;
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.FindFirst then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.Next = 0 then begin
                    ShipmentLine.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete;
                    exit;
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll;
                exit;
            end;
        end;
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(SalesInvoiceLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll;
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                if Header."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATText, TotalAmountInclVAT, true, false, false)
                else
                    ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText, TotalAmountVAT, false, true, false);
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll;
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet then begin
            repeat
                TempLineFeeNoteOnReportHist.Init;
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert;
            until LineFeeNoteOnReportHist.Next = 0;
        end else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode);
            if LineFeeNoteOnReportHist.FindSet then
                repeat
                    TempLineFeeNoteOnReportHist.Init;
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert;
                until LineFeeNoteOnReportHist.Next = 0;
        end;
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DeleteAll;

        FillNameValueTable(LeftHeader, Header.FieldCaption("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl, Header.GetCustomerVATRegistrationNumber);
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl, Header.GetCustomerGlobalLocationNumber);
        FillNameValueTable(LeftHeader, InvNoLbl, Header."No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
        FillNameValueTable(LeftHeader, Cust.GetLegalEntityTypeLbl, Cust.GetLegalEntityType);
        FillNameValueTable(LeftHeader, ShptMethodDescLbl, ShipmentMethod.Description);
    end;

    local procedure FillRightHeader()
    begin
        RightHeader.DeleteAll;

        FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
        FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl, CompanyInfo.GetRegistrationNumber);
        FillNameValueTable(RightHeader, CompanyInfoBankNameLbl, CompanyInfo."Bank Name");
        FillNameValueTable(RightHeader, CompanyInfoGiroNoLbl, CompanyInfo."Giro No.");
        FillNameValueTable(RightHeader, CompanyInfo.FieldCaption(IBAN), CompanyInfo.IBAN);
        FillNameValueTable(RightHeader, CompanyInfo.FieldCaption("SWIFT Code"), CompanyInfo."SWIFT Code");
        FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl, Header.GetPaymentReference);
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init;
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert;
        end;
    end;

    local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        ArrLength: Integer;
        iL: integer;
        BreakL: Boolean;
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        //FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        FormatAddr.SalesInvSellTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);


        if ShipToVATRegNo <> '' then begin
            CompressArray(ShipToAddr);

            iL := 8;
            repeat
                if ShipToAddr[iL] <> '' then
                    BreakL := true
                else
                    iL -= 1;

                if iL < 1 then
                    BreakL := true;
            until BreakL;

            if (iL < 8) and (iL > 0) then
                ShipToAddr[iL + 1] := ShipToVATRegNo;
        end;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        with SalesInvoiceHeader do begin
            FormatDocument.SetTotalLabels(GetCurrencySymbol, TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    local procedure GetJobTaskDescription(JobNo: Code[20]; JobTaskNo: Code[20]): Text[100]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SetRange("Job No.", JobNo);
        JobTask.SetRange("Job Task No.", JobTaskNo);
        if JobTask.FindFirst then
            exit(JobTask.Description);

        exit('');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(TRUE, FALSE)]
    local procedure OnAfterGetSalesHeader(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    local procedure ShowVATClause(VATClauseCode: Code[20]): Boolean
    begin
        if VATClauseCode = '' then
            exit(false);

        exit(true);
    end;

    var
        ClerkName: text;
        ClerkPosition: Text;
        ClerkEmail: Text;
        ClerkPhone: Text;
        HeadlineTextG: Text;
        HeaderTextG: Text;
        HeaderText2G: Text;
        ClosingTextG: Text;
        ClosingText2G: Text;
        TelephoneTextG: Text;
        FooterText1G: Text;
        FooterText2G: Text;
        CEOTextG: Text;
        NewLineG: Text;
        // Ab hier Hyperlink
        HyperlinkForFooterURL_Url: Text;
        HyperlinkForFooterURL_UrlText: Text;
}
