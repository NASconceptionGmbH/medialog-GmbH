page 60709 "Type of Business List"
{

    ApplicationArea = All;
    Caption = 'Kundenarten';
    PageType = List;
    SourceTable = "Type of Business";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(ManageCRMCoupling)
            {
                AccessByPermission = TableData "CRM Integration Record" = IM;
                ApplicationArea = Suite;
                Caption = 'Set Up Coupling';
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'Create or modify the coupling to a Dataverse account.';
                //        Visible = CRMIntegrationEnabled or CDSIntegrationEnabled;

                trigger OnAction()
                var
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
    begin
        if IntegrationTableMapping.Get('KUNDENARTEN') then;
    end;
}
