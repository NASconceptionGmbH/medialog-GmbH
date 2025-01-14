pageextension 60729 "Posted Purchase Invoices" extends "Posted Purchase Invoices"
{


    actions
    {
        addafter("&Print")
        {
            action(Email)
            {
                ApplicationArea = all;
                Caption = 'Send by &Email';
                Image = Email;
                ToolTip = 'Prepare to send the document by email. The Send Email window opens prefilled for the vendor where you can add or change information before you send the email.';
                trigger OnAction()
                var
                    PurchInvHeaderL: Record "Purch. Inv. Header";
                begin
                    PurchInvHeaderL := Rec;
                    CurrPage.SetSelectionFilter(PurchInvHeaderL);
                    PurchInvHeaderL.EmailRecords(true);
                end;
            }
            action(SendCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                trigger OnAction()
                var
                    PurchInvHeaderL: Record "Purch. Inv. Header";
                begin
                    PurchInvHeaderL := Rec;
                    CurrPage.SetSelectionFilter(PurchInvHeaderL);
                    PurchInvHeaderL.SendRecords();
                end;
            }
        }

        addafter("&Print_Promoted")
        {
            actionref(EmailRef; Email)
            {

            }
            actionRef(SendCustomRef; SendCustom)
            {

            }
        }
    }

}
