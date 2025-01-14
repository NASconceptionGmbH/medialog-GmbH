page 60717 "Customer Sparten List"
{
    Caption = 'Sparten';
    PageType = List;
    SourceTable = "Customer Sparten CRM";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Sparten Description"; Rec."Sparten Description")
                {
                    ApplicationArea = All;
                    Caption = 'Sparten';
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
                caption = 'Sync Sparten(Customer) to CRM';

                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                    CustomerSpartentoCRML: Record "Customer Sparten CRM";
                begin
                    CurrPage.SetSelectionFilter(CustomerSpartentoCRML);
                    CustomCRMSynchronizationL.SynchronizeSparteToCustomerRelation(CustomerSpartentoCRML, true);
                end;
            }
        }
    }
}