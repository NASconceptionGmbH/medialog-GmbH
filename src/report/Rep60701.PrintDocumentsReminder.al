report 60701 "Print Documents Reminder"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    WordLayout = 'src\layouts\PrintDocumentsReminder.docx';
    DefaultLayout = Word;
    Caption = 'Druckunterlagen Erinnerung';

    dataset
    {
        dataitem(IssueAd; "Issue Ad")
        {
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(CustomerName; Customer.Name)
            { }
            column(Sales_Order_No_; "Sales Order No.")
            { }
            column(MagazineType; Item."Magazine Type")
            { }
            column(Item_No_; "Item No.")
            { }
            column(Item_PubDate; format(Item."Publication Date", 0, 1))
            { }
            column(Print_Documents_Enddate; format("Print Documents Enddate", 0, 1))
            { }
            column(ItemDesc; Item.Description)
            { }
            column(Motive; Motive)
            { }
            column(Placement; Placement)
            { }
            column(Format; ItemVariant.Description)
            { }
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
            column(EmailBody01; EmailBody01)
            {

            }
            column(EmailBody02; StrSubstNo(EmailBody02, "Sales Order No."))
            {

            }
            column(EmailBody03; EmailBody03)
            {

            }
            column(EmailBody04; strsubstno(EmailBody04, Item.Description, format(Item."Publication Date", 0, 1)))
            {

            }
            column(EmailBody05; strsubstno(EmailBody05, format("Print Documents Enddate", 0, 1)))
            {

            }
            column(EmailBody06; EmailBody06)
            {

            }
            column(EmailBody07; EmailBody07)
            {

            }
            column(EmailBody08; EmailBody08)
            {

            }
            column(EmailBody09; EmailBody09)
            {

            }
            column(EmailBody10; EmailBody10)
            {

            }
            column(EmailBody11; StrSubstNo(EmailBody11, ClerkPhone))
            {

            }
            column(EmailBody12; EmailBody12)
            {

            }
            column(EmailBody13; EmailBody13)
            {

            }
            column(EmailBody14; EmailBody14)
            {

            }
            column(EmailBody15; EmailBody15)
            {

            }
            column(EmailBody16; EmailBody16)
            {

            }
            column(EmailBody17; EmailBody17)
            {

            }
            column(EmailBody18; EmailBody18)
            {

            }
            column(EmailBody19_Url; EmailBodyLink)
            {

            }

            trigger
                OnAfterGetRecord()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
                LanguageL: Codeunit Language;
            begin
                IF not Customer.get(IssueAd."Sell-to Customer No.") then
                    Customer.Init();
                If Not Item.Get(IssueAd."Item No.") then
                    Item.Init();
                IF not ItemVariant.Get(IssueAd."Item No.", Issuead."Variant Code") then
                    ItemVariant.Init();


                if SalespersonPurchaserL.Get(IssueAd.Clerk) then begin
                    ClerkName := SalespersonPurchaserL.Name;
                    ClerkPosition := SalespersonPurchaserL."Job Title";
                    ClerkEmail := SalespersonPurchaserL."E-Mail";
                    ClerkPhone := SalespersonPurchaserL."Phone No.";
                end else
                    if SalespersonPurchaserL.Get(IssueAd."Sales Person Code") then begin
                        ClerkName := SalespersonPurchaserL.Name;
                        ClerkPosition := SalespersonPurchaserL."Job Title";
                        ClerkEmail := SalespersonPurchaserL."E-Mail";
                        ClerkPhone := SalespersonPurchaserL."Phone No.";
                    end;

                if Customer."Language Code" = 'ENU' then
                    CurrReport.Language := LanguageL.GetLanguageIdOrDefault(Customer."Language Code")
                else
                    CurrReport.Language := LanguageL.GetLanguageIdOrDefault('DEU');
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

    trigger OnPreReport()
    var
    begin

    end;

    var
        myInt: Integer;
        Customer: Record Customer;
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ClerkName: text;
        ClerkPosition: Text;
        ClerkEmail: Text;
        ClerkPhone: Text;

        EmailBody01: Label 'Dear Sir or Madam,';
        EmailBody02: Label 'up until today, we have not yet received any ad material for your order: %1.';
        EmailBody03: Label 'Magazine:';
        EmailBody04: Label 'Issue: %1, publication date %2,';
        EmailBody05: Label 'ad-closing date: %1';
        EmailBody06: Label 'Ad dimensions:';
        EmailBody07: Label 'Subject:';
        EmailBody08: Label 'Placement:';
        EmailBody09: Label 'Please submit all required ad material by simply replying to this email.';
        EmailBody10: Label 'For trimmed ads we strongly recommend keeping live matter 7 mm from trim on each side.';
        EmailBody11: Label ' ';
        EmailBody12: Label 'Kind regards';
        EmailBody13: Label 'pp';
        EmailBody14: Label 'Phone:';
        EmailBody15: Label 'E-Mail:';
        EmailBody16: Label 'You can find our complete legal notice at';
        EmailBody17: label 'You can find our information on handling personal data at';
        EmailBody18: Label 'This email contains confidential or legally protected information. If you are not the intended recipient, please inform us immediately and delete this e-mail and its attachments. The unauthorized copying of this email and the unauthorized disclosure of the information contained therein are not permitted. Many Thanks.';
        EmailBodyLink: Label 'https://www.vulkan-verlag.de/service/impressum/';
}