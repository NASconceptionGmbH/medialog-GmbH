pageextension 60704 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Subscription No."; Rec."Subscription No.")
            {
                ApplicationArea = All;
            }
            field(cos_endofdeliveryyear; Rec.cos_endofdeliveryyear)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addbefore("Salesperson Code")
        {
            field(Clerk; Rec.Clerk)
            {
                ApplicationArea = All;
            }

        }
        addafter("Salesperson Code")
        {
            field("Commission Salesperson"; Rec."Commission Salesperson")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
            }
            field("Commission Salesperson 2"; Rec."Commission Salesperson 2")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {

            part(SharePointConnect; "Sharepoint Connect VV")
            {
                ApplicationArea = All;
                Caption = 'NC365 SharePoint Connect';
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
            }

        }
        addafter(ShippingOptions)
        {
            field("Ship-To Customer No."; Rec."Ship-To Customer No.")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    ShipToOptions := ShipToOptions::"Custom Address";
                end;
            }

        }
        addafter("Ship-to Name")
        {
            field("Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addfirst("F&unctions")
        {
            action(SendToCRM)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomCRMSynchronization: Codeunit CustomCRMSynchronization;
                begin
                    CustomCRMSynchronization.SendOrderConfirmationPDFtoCRM(Rec."No.");
                    // CustomCRMSynchronization.SendOrderConfirmationPDFtoCRM(Rec);
                end;
            }
        }
        addafter(Statistics)
        {
            action("Shipping Addresses")
            {

                ApplicationArea = All;
                Image = Addresses;
                Caption = 'Versandadressen';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = page "Shipping Addresses";
                RunPageLink = "Sales Order No." = field("No.");


            }
        }
        modify(SendEmailConfirmation)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField(Clerk);
            end;
        }
    }
}