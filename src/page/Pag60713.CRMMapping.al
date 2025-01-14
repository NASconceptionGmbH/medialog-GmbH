page 60713 "CRMMapping"
{

    ApplicationArea = All;
    Caption = 'CRMMapping';
    PageType = List;
    SourceTable = "CRM Integration Record";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CRMName; GetName())
                {
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("CRM ID"; Rec."CRM ID")
                {
                    ApplicationArea = All;
                }
                field("Integration ID"; Rec."Integration ID")
                {
                    ApplicationArea = All;
                }
                field("Last Synch. CRM Job ID"; Rec."Last Synch. CRM Job ID")
                {
                    ApplicationArea = All;
                }
                field("Last Synch. CRM Modified On"; Rec."Last Synch. CRM Modified On")
                {
                    ApplicationArea = All;
                }
                field("Last Synch. CRM Result"; Rec."Last Synch. CRM Result")
                {
                    ApplicationArea = All;
                }
                field("Last Synch. Job ID"; Rec."Last Synch. Job ID")
                {
                    ApplicationArea = All;
                }
                field("Last Synch. Modified On"; Rec."Last Synch. Modified On")
                {
                    ApplicationArea = All;
                }
                field("Last Synch. Result"; Rec."Last Synch. Result")
                {
                    ApplicationArea = All;
                }
                // field("Option Mapping Failure"; Rec."Option Mapping Failure")
                // {
                //     ApplicationArea = All;
                // }
                field(Skipped; Rec.Skipped)
                {
                    ApplicationArea = All;
                }
                field("Statistics Uploaded"; Rec."Statistics Uploaded")
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
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
            action(DeleteOldTypofBusinesses)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TypeofBusinessL: Record "Type of Business";
                    ZeroGuid: Guid;
                begin
                    TypeofBusinessL.Reset();
                    if TypeofBusinessL.FindSet() then
                        repeat
                            TypeofBusinessL."CRM GUID" := ZeroGuid;
                            TypeofBusinessL.Modify();
                        until TypeofBusinessL.Next() = 0;

                end;
            }
        }
    }

    procedure GetName(): Text
    var
        TypeofBusinessL: Record "Type of Business";
    begin
        if Rec."Table ID" = 60706 then begin
            TypeofBusinessL.SetRange("CRM GUID", Rec."CRM ID");
            if TypeofBusinessL.FindFirst() then
                exit(TypeofBusinessL.Code);
        end;

        exit('');
    end;



}
