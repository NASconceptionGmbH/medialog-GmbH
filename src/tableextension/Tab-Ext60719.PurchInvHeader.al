tableextension 60719 "Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(60700; "Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson Code';
        }
        field(60701; "Salesperson Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson Code 2';
        }
        field(60702; "Related Sales Order"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Related Sales Order', Comment = 'DEU="Verknüpfter Verkaufsauftrag"';
        }
        field(60703; "Commission Salesperson"; Decimal)
        {
            Caption = 'Commission Salesperson', Comment = 'DEU="Provision Verkäufer"';
            DataClassification = ToBeClassified;
        }
        field(60704; "Commission Salesperson 2"; Decimal)
        {
            Caption = 'Commission Salesperson 2', Comment = 'DEU="Provision Verkäufer 2"';
            DataClassification = ToBeClassified;
        }
    }


    procedure EmailRecords(ShowDialog: Boolean)
    var
        DocumentSendingProfileL: Record "Document Sending Profile";
        DummyReportSelectionsL: Record "Report Selections";
        ReportDistributionMgtL: Codeunit "Report Distribution Management";
        DocumentTypeTxtL: Text[50];
        IsHandledL: Boolean;
    begin
        DocumentTypeTxtL := ReportDistributionMgtL.GetFullDocumentTypeText(Rec);

        IsHandledL := false;
        OnBeforeEmailRecords(DummyReportSelectionsL, Rec, DocumentTypeTxtL, ShowDialog, IsHandledL);
        if not IsHandledL then
            DocumentSendingProfileL.TrySendToEMail(
              DummyReportSelectionsL.Usage::"P.Invoice".AsInteger(), Rec, FieldNo("No."), DocumentTypeTxtL,
              FieldNo("Buy-from Vendor No."), ShowDialog);
    end;

    procedure SendRecords()
    var
        DocumentSendingProfileL: Record "Document Sending Profile";
        DummyReportSelectionsL: Record "Report Selections";
        ReportDistributionMgtL: Codeunit "Report Distribution Management";
        DocumentTypeTxtL: Text[50];
        IsHandledL: Boolean;
    begin
        DocumentTypeTxtL := ReportDistributionMgtL.GetFullDocumentTypeText(Rec);

        IsHandledL := false;
        OnBeforeSendRecords(DummyReportSelectionsL, Rec, DocumentTypeTxtL, IsHandledL);
        if not IsHandledL then
            DocumentSendingProfileL.SendVendorRecords(DummyReportSelectionsL.Usage::"P.Invoice".AsInteger(), Rec, DocumentTypeTxtL, "Buy-from Vendor No.", "No.",
              FieldNo("Buy-from Vendor No."), FieldNo("No."));
    end;


    var
        myInt: Integer;



    [IntegrationEvent(false, false)]
    local procedure OnBeforeEmailRecords(var ReportSelectionsR: Record "Report Selections"; var PurchInvHeaderR: Record "Purch. Inv. Header"; DocTxtV: Text; var ShowDialogR: Boolean; var IsHandledR: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSendRecords(var ReportSelectionsR: Record "Report Selections"; var PurchInvHeaderR: Record "Purch. Inv. Header"; DocTxtV: Text; var IsHandledR: Boolean)
    begin
    end;


}