page 60718 "Customer Characteristics List"
{
    Caption = 'Merkmale';
    PageType = List;
    SourceTable = "Customer Characteristics CRM";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Sparten Description"; Rec."Sparten Description")
                {
                    ApplicationArea = All;
                }
                field("Item Attribute Value ID"; Rec."Item Attribute Value ID")
                {
                    ApplicationArea = All;
                }


                field(Synced; Rec.Synced)
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
                caption = 'Sync Merkmale(Customer) to CRM';

                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                    CustomerCharacteristicsCRM: Record "Customer Characteristics CRM";
                begin
                    CurrPage.SetSelectionFilter(CustomerCharacteristicsCRM);
                    CustomCRMSynchronizationL.SynchronizeCharacteristicsToCustomerRelation(CustomerCharacteristicsCRM, true);
                end;
            }
        }
    }
}