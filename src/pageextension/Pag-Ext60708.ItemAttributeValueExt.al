pageextension 60708 "ItemAttributeValueExt" extends "Item Attribute Values"
{
    layout
    {

    }

    actions
    {
        addlast(Processing)
        {
            group(Dataverse)
            {
                // action(CRMSynchronizeNow)
                // {
                //     AccessByPermission = TableData "CRM Integration Record" = IM;
                //     ApplicationArea = Suite;
                //     Caption = 'Synchronize';
                //     Image = Refresh;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ToolTip = 'Send or get updated data to or from Dataverse.';
                //     Visible = (Rec."Attribute ID" = 19) OR (Rec."Attribute ID" = 22);

                //     trigger OnAction()
                //     var
                //         CRMIntegrationManagement: Codeunit "CRM Integration Management";
                //     begin
                //         CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                //     end;
                // }
                // group(Coupling)
                // {
                //     Caption = 'Coupling', Comment = 'Coupling is a noun';
                //     Image = LinkAccount;
                //     ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Dataverse record.';
                //     action(ManageCRMCoupling)
                //     {
                //         AccessByPermission = TableData "CRM Integration Record" = IM;
                //         ApplicationArea = Suite;
                //         Caption = 'Set Up Coupling';
                //         Image = LinkAccount;
                //         Promoted = true;
                //         PromotedCategory = Category9;
                //         ToolTip = 'Create or modify the coupling to a Dataverse account.';
                //         Visible = true;

                //         trigger OnAction()
                //         var
                //             CRMIntegrationManagement: Codeunit "CRM Integration Management";
                //         begin
                //             CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                //         end;
                //     }
                //     action(DeleteCRMCoupling)
                //     {
                //         AccessByPermission = TableData "CRM Integration Record" = D;
                //         ApplicationArea = Suite;
                //         Caption = 'Delete Coupling';
                //         Enabled = CRMIsCoupledToRecord;
                //         Image = UnLinkAccount;
                //         ToolTip = 'Delete the coupling to a Dataverse account.';
                //         Visible = true;

                //         trigger OnAction()
                //         var
                //             CRMCouplingManagement: Codeunit "CRM Coupling Management";
                //         begin
                //             CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                //         end;
                //     }
                // }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
    end;


    var
        CRMIsCoupledToRecord: booleaN;
}