pageextension 60712 "Customer Report Selection Ext." extends "Customer Report Selections"
{
    layout
    {
        modify(Usage2)
        {
            Visible = false;
        }
        addbefore(ReportID)
        {
            field(UsageCustom; UsageCustom)
            {
                ApplicationArea = ALL;
                OptionCaption = 'Angebot,Auftragsbestätigung,Rechnung,Gutschrift,Kontoauszug,Projekt Angebot,Mahnung,Lieferung,Druck Erinnerung';
                trigger
                OnValidate()
                begin
                    case UsageCustom of
                        UsageCustom::Quote:
                            Rec.Usage := Rec.Usage::"S.Quote";
                        UsageCustom::"Confirmation Order":
                            Rec.Usage := Rec.Usage::"S.Order";
                        UsageCustom::Invoice:
                            Rec.Usage := Rec.Usage::"S.Invoice";
                        UsageCustom::"Credit Memo":
                            Rec.Usage := Rec.Usage::"S.Cr.Memo";
                        UsageCustom::"Customer Statement":
                            Rec.Usage := Rec.Usage::"C.Statement";
                        UsageCustom::"Job Quote":
                            Rec.Usage := Rec.Usage::JQ;
                        UsageCustom::Reminder:
                            Rec.Usage := Rec.Usage::Reminder;
                        UsageCustom::Shipment:
                            Rec.Usage := Rec.Usage::"S.Shipment";
                        UsageCustom::PrintReminder:
                            Rec.Usage := Rec.Usage::"Print Doc Reminder";
                    end;
                end;
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger
    OnAfterGetRecord()
    begin
        MapTableUsageValueToPageValueCustom();
    end;

    trigger
    OnNewRecord(BelowxRec: Boolean)
    begin
        MapTableUsageValueToPageValueCustom();
    end;

    local procedure MapTableUsageValueToPageValueCustom()
    var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        case Rec.Usage of
            CustomReportSelection.Usage::"S.Quote":
                UsageCustom := UsageCustom::Quote;
            CustomReportSelection.Usage::"S.Order":
                UsageCustom := UsageCustom::"Confirmation Order";
            CustomReportSelection.Usage::"S.Invoice":
                UsageCustom := UsageCustom::Invoice;
            CustomReportSelection.Usage::"S.Cr.Memo":
                UsageCustom := UsageCustom::"Credit Memo";
            CustomReportSelection.Usage::"C.Statement":
                UsageCustom := UsageCustom::"Customer Statement";
            CustomReportSelection.Usage::JQ:
                UsageCustom := UsageCustom::"Job Quote";
            CustomReportSelection.Usage::Reminder:
                UsageCustom := UsageCustom::Reminder;
            CustomReportSelection.Usage::"S.Shipment":
                UsageCustom := UsageCustom::Shipment;
            CustomReportSelection.Usage::"Print Doc Reminder":
                UsageCustom := UsageCustom::PrintReminder;
        end;
    end;

    var
        myInt: Integer;
        UsageCustom: Option Quote,"Confirmation Order",Invoice,"Credit Memo","Customer Statement","Job Quote",Reminder,Shipment,PrintReminder;
}