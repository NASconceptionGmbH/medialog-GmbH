reportextension 60701 "PostedSalesInvoiceExt" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Header)
        {
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
            column(HeaderTextG; HeaderTextG)
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

        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";

            begin
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
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    var
        ClerkName: text;
        ClerkPosition: Text;
        ClerkEmail: Text;
        ClerkPhone: Text;
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