page 60711 "CRM Custom Sync Setup"
{

    Caption = 'CRM Custom Sync Setup';
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = CRMCustomSyncSetup;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("CRM URL"; Rec."CRM URL")
                {
                    ToolTip = 'Specifies the value of the MyField field';
                    ApplicationArea = All;
                }
                field("API URL"; Rec."API URL")
                {
                    ApplicationArea = All;
                }

                field("Token URL"; Rec."Token URL")
                {
                    ApplicationArea = All;
                }
                field("Tenant ID"; Rec."Tenant ID")
                {
                    ToolTip = 'Specifies the value of the Tenant ID field';
                    ApplicationArea = All;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ToolTip = 'Specifies the value of the Client ID field';
                    ApplicationArea = All;
                }

                field("Secret ID"; Rec."Secret ID")
                {
                    ToolTip = 'Specifies the value of the Secret ID field';
                    ApplicationArea = All;
                }

                field("Access Token"; Rec."Access Token")
                {
                    ToolTip = 'Specifies the value of the Access Token field';
                    ApplicationArea = All;
                }
                field("Sharepoint Doc Location GUID"; Rec."Sharepoint Doc Location GUID")
                {
                    ApplicationArea = All;
                }
                field(DriveID; Rec.DriveID)
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
            action("Update Token")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomCRMSynchronization: Codeunit CustomCRMSynchronization;
                begin
                    CustomCRMSynchronization.GetLoginCredentials();
                end;
            }
            action(UpdateIDs)
            {
                ApplicationArea = All;
                Caption = 'Update CRM IDs';

                trigger OnAction()
                var
                    CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
                begin
                    CustomCRMSynchronizationL.UpdateGUIDSFromCRMIntegration()
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.init();
            Rec.insert();
        end;
    end;

}
