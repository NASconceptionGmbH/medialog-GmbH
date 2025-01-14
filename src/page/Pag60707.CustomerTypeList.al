page 60707 "Customer Type List"
{
    Caption = 'Kundenarten';
    PageType = List;
    SourceTable = "Customer Type";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type of Business Code"; Rec."Type of Business Code")
                {
                    ApplicationArea = All;
                    Caption = 'Kundenart';
                }
                field("Type of Business Description"; Rec."Type of Business Description")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(SendToCRM)
            {
                ApplicationArea = All;
                caption = 'Sync Kundenarten to CRM';

                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                    CustomerTypeL: Record "Customer Type";
                begin
                    CurrPage.SetSelectionFilter(CustomerTypeL);
                    CustomCRMSynchronizationL.SynchronizeCustomerTypeRelation(CustomerTypeL, true);
                end;
            }
        }
    }
}