page 60716 "Media Suite Buffer"
{

    ApplicationArea = All;
    Caption = 'Import Buffer';
    PageType = List;
    SourceTable = MediaSuiteImportBuffer;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Customer Name"; Rec."Ship-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Customer No."; Rec."Ship-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }

                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Country Code"; Rec."Sell-to Customer Country Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Post Code"; Rec."Sell-to Customer Post Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }

                field(Orderdate; Rec.Orderdate)
                {
                    ApplicationArea = All;
                }

                field("Invoice Discount"; Rec."Invoice Discount")
                {
                    ApplicationArea = All;
                }
                field(MwSt; Rec.MwSt)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount"; Rec."Line Discount")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field(Commission; Rec.Commission)
                {
                    ApplicationArea = All;
                }

                field(Salesperson; Rec.Salesperson)
                {
                    ApplicationArea = All;
                }

                field("Commission 2"; Rec."Commission 2")
                {
                    ApplicationArea = All;
                }

                field("Salesperson 2"; Rec."Salesperson 2")
                {
                    ApplicationArea = All;
                }


                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Object; Rec.Object)
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }


                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = All;
                }

                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
                }
                field(Motiv; Rec.Motiv)
                {
                    ApplicationArea = All;
                }
                field("Comment Sales Line"; Rec."Comment Sales Line")
                {
                    ToolTip = 'Specifies the value of the Comment Sales Line field.';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                    ApplicationArea = All;
                }
                field("Salesperson Code 2"; Rec."Salesperson Code 2")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code 2 field.';
                    ApplicationArea = All;
                }
                field("Sell-to Contact LN"; Rec."Sell-to Contact LN")
                {
                    ToolTip = 'Specifies the value of the Sell-to Contact LN field.';
                    ApplicationArea = All;
                }
                field("Sell-to Contact VN"; Rec."Sell-to Contact VN")
                {
                    ToolTip = 'Specifies the value of the Sell-to Contact VN field.';
                    ApplicationArea = All;
                }
                field("Sell-To CRM ID"; Rec."Sell-To CRM ID")
                {
                    ToolTip = 'Specifies the value of the Sell-To CRM ID field.';
                    ApplicationArea = All;
                }
                field("Ship-to Address 1"; Rec."Ship-to Address 1")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address 1 field.';
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field.';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                    ApplicationArea = All;
                }
                field("Ship-to Contact LN"; Rec."Ship-to Contact LN")
                {
                    ToolTip = 'Specifies the value of the Ship-to Contact LN field.';
                    ApplicationArea = All;
                }
                field("Ship-to Contact VN"; Rec."Ship-to Contact VN")
                {
                    ToolTip = 'Specifies the value of the Ship-to Contact VN field.';
                    ApplicationArea = All;
                }
                field("Ship-To County Code"; Rec."Ship-To County Code")
                {
                    ToolTip = 'Specifies the value of the Ship-To County Code field.';
                    ApplicationArea = All;
                }
                field("Ship-To CRM ID"; Rec."Ship-To CRM ID")
                {
                    ToolTip = 'Specifies the value of the Ship-To CRM ID field.';
                    ApplicationArea = All;
                }
                field("Youre Reference"; Rec."Youre Reference")
                {
                    ToolTip = 'Specifies the value of the Youre Reference field.';
                    ApplicationArea = All;
                }
                field("Ship-To Post Code"; "Ship-To Post Code")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; "Item Description")
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
            action(DeleteAll)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.FindSet();
                    Rec.DeleteAll();
                end;
            }
            action(Import)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(60700, false, true);
                    CurrPage.Update(false);
                end;
            }
            action(CreateOrders)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MediaSuiteImportBufferL: Record MediaSuiteImportBuffer;
                    SalesHeaderL: Record "Sales Header";
                    SalesLineL: Record "Sales Line";
                    UnitPriceL: Decimal;
                    LineDisc: Decimal;
                    SalesCalcDiscountByTypeL: Codeunit "Sales - Calc Discount By Type";
                    InvDisc: Decimal;
                    CustomerL: Record Customer;
                    CRMIntegrationRecordL: Record "CRM Integration Record";
                    CountryRegionL: Record "Country/Region";
                    VATBusinessPostingGroupL: Record "VAT Business Posting Group";
                    GenBusinessPostingGroupL: Record "Gen. Business Posting Group";
                    ImportBufferProcesserL: Codeunit "Import Buffer Processer";
                begin
                    CurrPage.SetSelectionFilter(MediaSuiteImportBufferL);
                    If MediaSuiteImportBufferL.FindSet() then
                        repeat
                            Commit;
                            IF NoT ImportBufferProcesserL.Run(MediaSuiteImportBufferL) then begin
                                MediaSuiteImportBufferL."Error Text" := GetLastErrorText();
                                MediaSuiteImportBufferL.Modify();
                            end;
                        until MediaSuiteImportBufferL.Next() = 0;
                end;
            }
        }
    }

}
