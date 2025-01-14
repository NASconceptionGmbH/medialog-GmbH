page 60723 "NAS Activities"
{
    Caption = 'NAS Aktivitäten';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "NAS Activities";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup("Abos")
            {

                field("Subscription Errors"; Rec."Subscription Errors")
                {
                    Caption = 'Abos enthalten Fehlermeldung';
                    ApplicationArea = All;
                    DrillDownPageId = "Abo Liste";
                    DrillDown = true;
                    ToolTip = 'Abo enthalten Fehlermeldung.';
                }
                field("Subscription without Sales Order"; Rec."Subscription without Sales Order")
                {
                    Caption = 'Abos ohne Verkaufsaufträge';
                    ApplicationArea = All;
                    DrillDownPageId = "Abo Liste";
                    DrillDown = true;
                    ToolTip = 'Abo ohne Verkaufsaufträge.';
                }
                field("Sales Order Type Abo"; Rec."Sales Order Type Abo")
                {
                    Caption = 'Verkaufsaufträge mit Art Abo';
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                    DrillDown = true;
                    ToolTip = 'Verkaufsaufträge mit Art Abo.';
                }
            }
        }
    }

}