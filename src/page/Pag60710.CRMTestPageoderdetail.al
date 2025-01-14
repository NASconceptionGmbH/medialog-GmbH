page 60710 "CRM TestPage oderdetail"
{

    ApplicationArea = All;
    Caption = 'CRM TestPage oderdetail';
    PageType = List;
    SourceTable = "CRM Salesorderdetail";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(BaseAmount; Rec.BaseAmount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field(BaseAmount_Base; Rec.BaseAmount_Base)
                {
                    ToolTip = 'Specifies the value of the Amount (Base) field';
                    ApplicationArea = All;
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the Created By field';
                    ApplicationArea = All;
                }
                field(CreatedByName; Rec.CreatedByName)
                {
                    ToolTip = 'Specifies the value of the CreatedByName field';
                    ApplicationArea = All;
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the Created On field';
                    ApplicationArea = All;
                }
                field(CreatedOnBehalfBy; Rec.CreatedOnBehalfBy)
                {
                    ToolTip = 'Specifies the value of the Created By (Delegate) field';
                    ApplicationArea = All;
                }
                field(CreatedOnBehalfByName; Rec.CreatedOnBehalfByName)
                {
                    ToolTip = 'Specifies the value of the CreatedOnBehalfByName field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field';
                    ApplicationArea = All;
                }
                field(ExtendedAmount; Rec.ExtendedAmount)
                {
                    ToolTip = 'Specifies the value of the Extended Amount field';
                    ApplicationArea = All;
                }
                field(ExtendedAmount_Base; Rec.ExtendedAmount_Base)
                {
                    ToolTip = 'Specifies the value of the Extended Amount (Base) field';
                    ApplicationArea = All;
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                    ToolTip = 'Specifies the value of the Import Sequence Number field';
                    ApplicationArea = All;
                }
                field(IsCopied; Rec.IsCopied)
                {
                    ToolTip = 'Specifies the value of the Copied field';
                    ApplicationArea = All;
                }
                field(IsPriceOverridden; Rec.IsPriceOverridden)
                {
                    ToolTip = 'Specifies the value of the Pricing field';
                    ApplicationArea = All;
                }
                field(IsProductOverridden; Rec.IsProductOverridden)
                {
                    ToolTip = 'Specifies the value of the Select Product field';
                    ApplicationArea = All;
                }
                field(LineItemNumber; Rec.LineItemNumber)
                {
                    ToolTip = 'Specifies the value of the Line Item Number field';
                    ApplicationArea = All;
                }
                field(ManualDiscountAmount; Rec.ManualDiscountAmount)
                {
                    ToolTip = 'Specifies the value of the Manual Discount field';
                    ApplicationArea = All;
                }
                field(ManualDiscountAmount_Base; Rec.ManualDiscountAmount_Base)
                {
                    ToolTip = 'Specifies the value of the Manual Discount (Base) field';
                    ApplicationArea = All;
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'Specifies the value of the Modified By field';
                    ApplicationArea = All;
                }
                field(ModifiedByName; Rec.ModifiedByName)
                {
                    ToolTip = 'Specifies the value of the ModifiedByName field';
                    ApplicationArea = All;
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Modified On field';
                    ApplicationArea = All;
                }
                field(ModifiedOnBehalfBy; Rec.ModifiedOnBehalfBy)
                {
                    ToolTip = 'Specifies the value of the Modified By (Delegate) field';
                    ApplicationArea = All;
                }
                field(ModifiedOnBehalfByName; Rec.ModifiedOnBehalfByName)
                {
                    ToolTip = 'Specifies the value of the ModifiedOnBehalfByName field';
                    ApplicationArea = All;
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ToolTip = 'Specifies the value of the Record Created On field';
                    ApplicationArea = All;
                }
                field(OwnerId; Rec.OwnerId)
                {
                    ToolTip = 'Specifies the value of the Owner field';
                    ApplicationArea = All;
                }
                field(OwnerIdType; Rec.OwnerIdType)
                {
                    ToolTip = 'Specifies the value of the OwnerIdType field';
                    ApplicationArea = All;
                }
                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                    ToolTip = 'Specifies the value of the Owning Business Unit field';
                    ApplicationArea = All;
                }
                field(OwningUser; Rec.OwningUser)
                {
                    ToolTip = 'Specifies the value of the Owning User field';
                    ApplicationArea = All;
                }
                field(ParentBundleId; Rec.ParentBundleId)
                {
                    ToolTip = 'Specifies the value of the Parent Bundle field';
                    ApplicationArea = All;
                }
                field(PricePerUnit; Rec.PricePerUnit)
                {
                    ToolTip = 'Specifies the value of the Price Per Unit field';
                    ApplicationArea = All;
                }
                field(PricePerUnit_Base; Rec.PricePerUnit_Base)
                {
                    ToolTip = 'Specifies the value of the Price Per Unit (Base) field';
                    ApplicationArea = All;
                }
                field(PricingErrorCode; Rec.PricingErrorCode)
                {
                    ToolTip = 'Specifies the value of the Pricing Error  field';
                    ApplicationArea = All;
                }
                field(ProductAssociationId; Rec.ProductAssociationId)
                {
                    ToolTip = 'Specifies the value of the Bundle Item Association field';
                    ApplicationArea = All;
                }
                field(ProductDescription; Rec.ProductDescription)
                {
                    ToolTip = 'Specifies the value of the Write-In Product field';
                    ApplicationArea = All;
                }
                field(ProductId; Rec.ProductId)
                {
                    ToolTip = 'Specifies the value of the Existing Product field';
                    ApplicationArea = All;
                }
                field(ProductIdName; Rec.ProductIdName)
                {
                    ToolTip = 'Specifies the value of the ProductIdName field';
                    ApplicationArea = All;
                }
                field(ProductTypeCode; Rec.ProductTypeCode)
                {
                    ToolTip = 'Specifies the value of the Product type field';
                    ApplicationArea = All;
                }
                field(PropertyConfigurationStatus; Rec.PropertyConfigurationStatus)
                {
                    ToolTip = 'Specifies the value of the Property Configuration field';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field';
                    ApplicationArea = All;
                }
                field(QuantityBackordered; Rec.QuantityBackordered)
                {
                    ToolTip = 'Specifies the value of the Quantity Back Ordered field';
                    ApplicationArea = All;
                }
                field(QuantityCancelled; Rec.QuantityCancelled)
                {
                    ToolTip = 'Specifies the value of the Quantity Canceled field';
                    ApplicationArea = All;
                }
                field(QuantityShipped; Rec.QuantityShipped)
                {
                    ToolTip = 'Specifies the value of the Quantity Shipped field';
                    ApplicationArea = All;
                }
                field(RequestDeliveryBy; Rec.RequestDeliveryBy)
                {
                    ToolTip = 'Specifies the value of the Requested Delivery Date field';
                    ApplicationArea = All;
                }
                field(SalesOrderDetailId; Rec.SalesOrderDetailId)
                {
                    ToolTip = 'Specifies the value of the Order Product field';
                    ApplicationArea = All;
                }
                field(SalesOrderId; Rec.SalesOrderId)
                {
                    ToolTip = 'Specifies the value of the Order field';
                    ApplicationArea = All;
                }
                field(SalesOrderIsPriceLocked; Rec.SalesOrderIsPriceLocked)
                {
                    ToolTip = 'Specifies the value of the Order Is Price Locked field';
                    ApplicationArea = All;
                }
                field(SalesOrderStateCode; Rec.SalesOrderStateCode)
                {
                    ToolTip = 'Specifies the value of the Order Status field';
                    ApplicationArea = All;
                }
                field(SalesRepId; Rec.SalesRepId)
                {
                    ToolTip = 'Specifies the value of the Salesperson field';
                    ApplicationArea = All;
                }
                field(SalesRepIdName; Rec.SalesRepIdName)
                {
                    ToolTip = 'Specifies the value of the SalesRepIdName field';
                    ApplicationArea = All;
                }
                field(SequenceNumber; Rec.SequenceNumber)
                {
                    ToolTip = 'Specifies the value of the Sequence Number field';
                    ApplicationArea = All;
                }
                field(ShipTo_AddressId; Rec.ShipTo_AddressId)
                {
                    ToolTip = 'Specifies the value of the Ship To Address ID field';
                    ApplicationArea = All;
                }
                field(ShipTo_City; Rec.ShipTo_City)
                {
                    ToolTip = 'Specifies the value of the Ship To City field';
                    ApplicationArea = All;
                }
                field(ShipTo_ContactName; Rec.ShipTo_ContactName)
                {
                    ToolTip = 'Specifies the value of the Ship To Contact Name field';
                    ApplicationArea = All;
                }
                field(ShipTo_Country; Rec.ShipTo_Country)
                {
                    ToolTip = 'Specifies the value of the Ship To Country/Region field';
                    ApplicationArea = All;
                }
                field(ShipTo_Fax; Rec.ShipTo_Fax)
                {
                    ToolTip = 'Specifies the value of the Ship To Fax field';
                    ApplicationArea = All;
                }
                field(ShipTo_FreightTermsCode; Rec.ShipTo_FreightTermsCode)
                {
                    ToolTip = 'Specifies the value of the Freight Terms field';
                    ApplicationArea = All;
                }
                field(ShipTo_Line1; Rec.ShipTo_Line1)
                {
                    ToolTip = 'Specifies the value of the Ship To Street 1 field';
                    ApplicationArea = All;
                }
                field(ShipTo_Line2; Rec.ShipTo_Line2)
                {
                    ToolTip = 'Specifies the value of the Ship To Street 2 field';
                    ApplicationArea = All;
                }
                field(ShipTo_Line3; Rec.ShipTo_Line3)
                {
                    ToolTip = 'Specifies the value of the Ship To Street 3 field';
                    ApplicationArea = All;
                }
                field(ShipTo_Name; Rec.ShipTo_Name)
                {
                    ToolTip = 'Specifies the value of the Ship To Name field';
                    ApplicationArea = All;
                }
                field(ShipTo_PostalCode; Rec.ShipTo_PostalCode)
                {
                    ToolTip = 'Specifies the value of the Ship To ZIP/Postal Code field';
                    ApplicationArea = All;
                }
                field(ShipTo_StateOrProvince; Rec.ShipTo_StateOrProvince)
                {
                    ToolTip = 'Specifies the value of the Ship To State/Province field';
                    ApplicationArea = All;
                }
                field(ShipTo_Telephone; Rec.ShipTo_Telephone)
                {
                    ToolTip = 'Specifies the value of the Ship To Phone field';
                    ApplicationArea = All;
                }

                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field';
                    ApplicationArea = All;
                }

                field(Tax; Rec.Tax)
                {
                    ToolTip = 'Specifies the value of the Tax field';
                    ApplicationArea = All;
                }
                field(Tax_Base; Rec.Tax_Base)
                {
                    ToolTip = 'Specifies the value of the Tax (Base) field';
                    ApplicationArea = All;
                }
                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                    ToolTip = 'Specifies the value of the Time Zone Rule Version Number field';
                    ApplicationArea = All;
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                    ToolTip = 'Specifies the value of the Currency field';
                    ApplicationArea = All;
                }
                field(TransactionCurrencyIdName; Rec.TransactionCurrencyIdName)
                {
                    ToolTip = 'Specifies the value of the TransactionCurrencyIdName field';
                    ApplicationArea = All;
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                    ToolTip = 'Specifies the value of the UTC Conversion Time Zone Code field';
                    ApplicationArea = All;
                }
                field(UoMId; Rec.UoMId)
                {
                    ToolTip = 'Specifies the value of the Unit field';
                    ApplicationArea = All;
                }
                field(UoMIdName; Rec.UoMIdName)
                {
                    ToolTip = 'Specifies the value of the UoMIdName field';
                    ApplicationArea = All;
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                    ToolTip = 'Specifies the value of the Version Number field';
                    ApplicationArea = All;
                }
                field(VolumeDiscountAmount; Rec.VolumeDiscountAmount)
                {
                    ToolTip = 'Specifies the value of the Volume Discount field';
                    ApplicationArea = All;
                }
                field(VolumeDiscountAmount_Base; Rec.VolumeDiscountAmount_Base)
                {
                    ToolTip = 'Specifies the value of the Volume Discount (Base) field';
                    ApplicationArea = All;
                }
                field(WillCall; Rec.WillCall)
                {
                    ToolTip = 'Specifies the value of the Ship To field';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

}





