page 60728 "Contact Characteristics List"
{
    Caption = 'Merkmale';
    PageType = List;
    SourceTable = "Contact Characteristics CRM";

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
                caption = 'Sync Merkmale(Contact) to CRM';

                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                    ContactCharacteristicsCRM: Record "Contact Characteristics CRM";
                begin
                    CurrPage.SetSelectionFilter(ContactCharacteristicsCRM);
                    CustomCRMSynchronizationL.SynchronizeCharacteristicsToContactRelation(ContactCharacteristicsCRM, true);
                end;
            }
        }
    }
}