xmlport 60700 "OrderImportBuffer"
{
    Caption = 'OrderImportBuffer';
    Direction = Import;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MediaSuiteImportBuffer; MediaSuiteImportBuffer)
            {
                fieldelement(ShiptoCustomerName; MediaSuiteImportBuffer."Ship-to Customer Name")
                {
                }
                fieldelement(ShiptoCustomerNo; MediaSuiteImportBuffer."Ship-to Customer No.")
                {
                }
                fieldelement(SelltoCustomerName; MediaSuiteImportBuffer."Sell-to Customer Name")
                {
                }
                fieldelement(SelltoCustomerNo; MediaSuiteImportBuffer."Sell-to Customer No.")
                {
                }
                fieldelement(SelltoCustomerName2; MediaSuiteImportBuffer."Sell-to Customer Name 2")
                {
                }
                fieldelement(SelltoCustomerCountryCode; MediaSuiteImportBuffer."Sell-to Customer Country Code")
                {
                }
                fieldelement(SelltoCustomerPostCode; MediaSuiteImportBuffer."Sell-to Customer Post Code")
                {
                }
                fieldelement(SelltoCity; MediaSuiteImportBuffer."Sell-to City")
                {
                }
                fieldelement(SelltoAddress; MediaSuiteImportBuffer."Sell-to Address")
                {
                }
                fieldelement(Orderdate; MediaSuiteImportBuffer.Orderdate)
                {
                }
                fieldelement(InvoiceDiscount; MediaSuiteImportBuffer."Invoice Discount")
                {
                }
                fieldelement(MwSt; MediaSuiteImportBuffer.MwSt)
                {
                }
                fieldelement(UnitPrice; MediaSuiteImportBuffer."Unit Price")
                {
                }
                fieldelement(LineDiscount; MediaSuiteImportBuffer."Line Discount")
                {
                }
                fieldelement(ExternalDocumentNo; MediaSuiteImportBuffer."External Document No.")
                {
                }
                fieldelement(Contact; MediaSuiteImportBuffer.Contact)
                {
                }
                fieldelement(Commission; MediaSuiteImportBuffer.Commission)
                {
                }
                fieldelement(Salesperson; MediaSuiteImportBuffer.Salesperson)
                {
                }
                fieldelement(Commission2; MediaSuiteImportBuffer."Commission 2")
                {
                }
                fieldelement(Salesperson2; MediaSuiteImportBuffer."Salesperson 2")
                {
                }
                fieldelement(ItemNo; MediaSuiteImportBuffer."Item No.")
                {
                }
                fieldelement(Object; MediaSuiteImportBuffer.Object)
                {
                }
                fieldelement(VariantCode; MediaSuiteImportBuffer."Variant Code")
                {
                }
                fieldelement(TypeofBusiness; MediaSuiteImportBuffer."Type of Business")
                {
                }
                fieldelement(Format; MediaSuiteImportBuffer.Format)
                {
                }
                fieldelement(Motiv; MediaSuiteImportBuffer.Motiv)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
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
            }
        }
    }
}
