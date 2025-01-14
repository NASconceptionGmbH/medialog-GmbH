page 60719 "CRM  Merkmale"
{

    ApplicationArea = All;
    Caption = 'CRM  Merkmale';
    PageType = List;
    SourceTable = "CDS cos_characteristic";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CreatedBy; Rec.CreatedBy)
                {
                    ApplicationArea = All;
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ApplicationArea = All;
                }
                field(CreatedOnBehalfBy; Rec.CreatedOnBehalfBy)
                {
                    ApplicationArea = All;
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                    ApplicationArea = All;
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ApplicationArea = All;
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ApplicationArea = All;
                }
                field(ModifiedOnBehalfBy; Rec.ModifiedOnBehalfBy)
                {
                    ApplicationArea = All;
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ApplicationArea = All;
                }
                field(OwnerId; Rec.OwnerId)
                {
                    ApplicationArea = All;
                }
                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                    ApplicationArea = All;
                }
                field(OwningTeam; Rec.OwningTeam)
                {
                    ApplicationArea = All;
                }
                field(OwningUser; Rec.OwningUser)
                {
                    ApplicationArea = All;
                }

                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                }

                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                    ApplicationArea = All;
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                    ApplicationArea = All;
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                    ApplicationArea = All;
                }
                field(cos_characteristicId; Rec.cos_characteristicId)
                {
                    ApplicationArea = All;
                }
                field(cos_name; Rec.cos_name)
                {
                    ApplicationArea = All;
                }
                field(statecode; Rec.statecode)
                {
                    ApplicationArea = All;
                }
                field(statuscode; Rec.statuscode)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;
}
