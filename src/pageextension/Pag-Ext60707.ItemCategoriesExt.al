pageextension 60707 "Item Categories Ext." extends "Item Categories"
{
    layout
    {
        addafter(Description)
        {
            field("Item Category Template Code"; Rec."Item Category Template Code")
            {
                ApplicationArea = All;
            }
            field(Subscription; Rec.Subscription)
            {
                ApplicationArea = All;
            }
            field(Issue; Rec.Issue)
            {
                ApplicationArea = All;
            }
            field("Show Retail Price"; "Show Retail Price")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        addlast(Navigation)
        {
            group(Dataverse)
            {
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
                    ApplicationArea = Suite;
                    Caption = 'Synchronize';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Send or get updated data to or from Dataverse.';
                    Visible = true;

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }

                action(Testaction)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                    begin
                        message(format(CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId)))
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}