page 60722 "CRM Invoice Temp"
{
    ApplicationArea = All;
    Caption = 'CRM Invoice Temp';
    PageType = List;
    SourceTable = "CRM Invoice";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(InvoiceId; Rec.InvoiceId)
                {
                }
                field(OpportunityId; Rec.OpportunityId)
                {
                }
                field(PriorityCode; Rec.PriorityCode)
                {
                }
                field(SalesOrderId; Rec.SalesOrderId)
                {
                }
                field(OwningUser; Rec.OwningUser)
                {
                }
                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                }
                field(LastBackofficeSubmit; Rec.LastBackofficeSubmit)
                {
                }
                field(PriceLevelId; Rec.PriceLevelId)
                {
                }
                field(AccountId; Rec.AccountId)
                {
                }
                field(ContactId; Rec.ContactId)
                {
                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(DiscountAmount; Rec.DiscountAmount)
                {
                }
                field(FreightAmount; Rec.FreightAmount)
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                field(TotalLineItemAmount; Rec.TotalLineItemAmount)
                {
                }
                field(TotalLineItemDiscountAmount; Rec.TotalLineItemDiscountAmount)
                {
                }
                field(TotalAmountLessFreight; Rec.TotalAmountLessFreight)
                {
                }
                field(TotalDiscountAmount; Rec.TotalDiscountAmount)
                {
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                }
                field(TotalTax; Rec.TotalTax)
                {
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                }
                field(StateCode; Rec.StateCode)
                {
                }
                field(StatusCode; Rec.StatusCode)
                {
                }
                field(ShipTo_Name; Rec.ShipTo_Name)
                {
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                }
                field(PricingErrorCode; Rec.PricingErrorCode)
                {
                }
                field(ShipTo_Line1; Rec.ShipTo_Line1)
                {
                }
                field(ShipTo_Line2; Rec.ShipTo_Line2)
                {
                }
                field(ShipTo_Line3; Rec.ShipTo_Line3)
                {
                }
                field(ShipTo_City; Rec.ShipTo_City)
                {
                }
                field(ShipTo_StateOrProvince; Rec.ShipTo_StateOrProvince)
                {
                }
                field(ShipTo_Country; Rec.ShipTo_Country)
                {
                }
                field(ShipTo_PostalCode; Rec.ShipTo_PostalCode)
                {
                }
                field(WillCall; Rec.WillCall)
                {
                }
                field(ShipTo_Telephone; Rec.ShipTo_Telephone)
                {
                }
                field(BillTo_Name; Rec.BillTo_Name)
                {
                }
                field(ShipTo_FreightTermsCode; Rec.ShipTo_FreightTermsCode)
                {
                }
                field(ShipTo_Fax; Rec.ShipTo_Fax)
                {
                }
                field(BillTo_Line1; Rec.BillTo_Line1)
                {
                }
                field(BillTo_Line2; Rec.BillTo_Line2)
                {
                }
                field(BillTo_Line3; Rec.BillTo_Line3)
                {
                }
                field(BillTo_City; Rec.BillTo_City)
                {
                }
                field(BillTo_StateOrProvince; Rec.BillTo_StateOrProvince)
                {
                }
                field(BillTo_Country; Rec.BillTo_Country)
                {
                }
                field(BillTo_PostalCode; Rec.BillTo_PostalCode)
                {
                }
                field(BillTo_Telephone; Rec.BillTo_Telephone)
                {
                }
                field(BillTo_Fax; Rec.BillTo_Fax)
                {
                }
                field(DiscountPercentage; Rec.DiscountPercentage)
                {
                }
                field(ContactIdName; Rec.ContactIdName)
                {
                }
                field(AccountIdName; Rec.AccountIdName)
                {
                }
                field(OpportunityIdName; Rec.OpportunityIdName)
                {
                }
                field(SalesOrderIdName; Rec.SalesOrderIdName)
                {
                }
                field(PriceLevelIdName; Rec.PriceLevelIdName)
                {
                }
                field(CreatedByName; Rec.CreatedByName)
                {
                }
                field(ModifiedByName; Rec.ModifiedByName)
                {
                }
                field(CustomerId; Rec.CustomerId)
                {
                }
                field(CustomerIdType; Rec.CustomerIdType)
                {
                }
                field(OwnerId; Rec.OwnerId)
                {
                }
                field(OwnerIdType; Rec.OwnerIdType)
                {
                }
                field(IsPriceLocked; Rec.IsPriceLocked)
                {
                }
                field(DateDelivered; Rec.DateDelivered)
                {
                }
                field(DueDate; Rec.DueDate)
                {
                }
                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                }
                field(TransactionCurrencyIdName; Rec.TransactionCurrencyIdName)
                {
                }
                field(TotalLineItemAmount_Base; Rec.TotalLineItemAmount_Base)
                {
                }
                field(TotalLineItemDiscountAmount_Ba; Rec.TotalLineItemDiscountAmount_Ba)
                {
                }
                field(TotalTax_Base; Rec.TotalTax_Base)
                {
                }
                field(TotalAmountLessFreight_Base; Rec.TotalAmountLessFreight_Base)
                {
                }
                field(DiscountAmount_Base; Rec.DiscountAmount_Base)
                {
                }
                field(TotalAmount_Base; Rec.TotalAmount_Base)
                {
                }
                field(FreightAmount_Base; Rec.FreightAmount_Base)
                {
                }
                field(TotalDiscountAmount_Base; Rec.TotalDiscountAmount_Base)
                {
                }
                field(CreatedOnBehalfBy; Rec.CreatedOnBehalfBy)
                {
                }
                field(CreatedOnBehalfByName; Rec.CreatedOnBehalfByName)
                {
                }
                field(ModifiedOnBehalfBy; Rec.ModifiedOnBehalfBy)
                {
                }
                field(ModifiedOnBehalfByName; Rec.ModifiedOnBehalfByName)
                {
                }
                field(OwningTeam; Rec.OwningTeam)
                {
                }
                field(BillTo_Composite; Rec.BillTo_Composite)
                {
                }
                field(ShipTo_Composite; Rec.ShipTo_Composite)
                {
                }
                field(ProcessId; Rec.ProcessId)
                {
                }
                field(StageId; Rec.StageId)
                {
                }
                field(EntityImageId; Rec.EntityImageId)
                {
                }
                field(TraversedPath; Rec.TraversedPath)
                {
                }
                field(CompanyId; Rec.CompanyId)
                {
                }
                field(PaymentTermsCodeEnum; Rec.PaymentTermsCodeEnum)
                {
                }
                field(ShippingMethodCodeEnum; Rec.ShippingMethodCodeEnum)
                {
                }
                field(new_bcrechnungslink; Rec.new_bcrechnungslink)
                {
                }
                field(new_buchungsdatum; Rec.new_buchungsdatum)
                {

                }
                field(new_urlsaveprocessed; Rec.new_urlsaveprocessed)
                {

                }
            }
        }
    }

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

}
