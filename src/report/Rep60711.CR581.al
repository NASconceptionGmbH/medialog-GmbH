report 60711 "CR-581"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("SalesCrMemoLine"; "Sales Cr.Memo Line")
        {
            trigger
            OnAfterGetRecord()
            var
                SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
                ItemVariantL: Record "Item Variant";
                IssueAdL: Record "Issue Ad";
            begin
                IF "Variant Code" <> '' then begin
                    SalesCrMemoHeaderL.Get(SalesCrMemoLine."Document No.");
                    ItemVariantL.SetRange("Item No.", SalesCrMemoLine."No.");
                    ItemVariantL.SetRange(Code, SalesCrMemoLine."Variant Code");
                    ItemVariantL.FindFirst();
                    IssueAdL.Init();
                    IssueAdL.Validate("Sales Order No.", SalesCrMemoLine."Document No.");
                    IssueAdL.Validate("Sales Line No.", SalesCrMemoLine."Line No.");
                    IssueAdL.Validate("Item No.", SalesCrMemoLine."No.");
                    IssueAdL.Validate("Variant Code", SalesCrMemoLine."Variant Code");
                    IssueAdL.Validate("Unit Price", SalesCrMemoLine."Unit Price" * -1);
                    IssueAdL.Validate("Line Amount Excl. VAT", SalesCrMemoLine.Amount * -1);
                    IssueAdL.Validate("Created Date", Today);
                    IssueAdL.Validate("Sell-to Customer No.", SalesCrMemoLine."Sell-to Customer No.");
                    IssueAdL.Validate("Sales Person Code", SalesCrMemoHeaderL."Salesperson Code");
                    IssueAdL.Validate("Salesperson 2", SalesCrMemoHeaderL."Salesperson Code 2");
                    IssueAdL.Validate(Clerk, SalesCrMemoHeaderL.Clerk);
                    IssueAdL."Line Amount" := SalesCrMemoLine."Amount Including VAT" * -1;
                    IssueAdL."Ship-to Customer No." := SalesCrMemoHeaderL."Sell-to Customer No.";
                    IssueAdL."Ship-to Name" := SalesCrMemoHeaderL."Ship-to Name";
                    IssueAdL."Print Documents" := true;
                    IssueAdL.Validate(Format, ItemVariantL.Description);
                    IssueAdL."Commission %" := SalesCrMemoHeaderL."Commission Salesperson";
                    IssueAdL."Credit Memo No." := SalesCrMemoHeaderL."No.";
                    IF SalesCrMemoHeaderL."Commission Salesperson" <> 0 then
                        IssueAdL."Commission Amount" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson") * -1;
                    If SalesCrMemoHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(SalesCrMemoLine.Amount, SalesCrMemoHeaderL."Commission Salesperson 2") * -1;
                    IF IssueAdL.Insert(true) then
                        ;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}