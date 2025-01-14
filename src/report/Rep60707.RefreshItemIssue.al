report 60707 "Refresh Item Issue"
{

    ProcessingOnly = true;
    dataset
    {
        dataitem(IssueAd; "Issue Ad")
        {
            trigger OnAfterGetRecord()
            var
                SalesLineL: Record "Sales Line";
                SalesHeaderL: Record "Sales Header";
                ItemL: Record Item;
            begin
                SalesLineL.SetRange("Document No.", IssueAd."Sales Order No.");
                SalesLineL.SetRange("Line No.", IssueAd."Sales Line No.");
                If SalesLineL.FindFirst() then begin
                    Iteml.Get(IssueAd."Item No.");
                    IssueAd."Line Amount Excl. VAT" := SalesLineL.Amount;
                    SalesHeaderL.Get(SalesLineL."Document Type"::Order, SalesLineL."Document No.");
                    If SalesHeaderL."Commission Salesperson" <> 0 then
                        IssueAd."Commission Amount" := IssueAd.CalcCommission(SalesLineL.Amount, SalesHeaderL."Commission Salesperson");
                    IF SalesHeaderL."Commission Salesperson 2" <> 0 then
                        IssueAd."Commission Amount 2" := IssueAd.CalcCommission(SalesLineL.Amount, SalesHeaderL."Commission Salesperson 2");
                    IssueAd."Ship-to Customer No." := SalesHeaderL."Ship-To Customer No.";
                    IssueAd."Ship-to Name" := SalesHeaderL."Ship-to Name";
                    IssueAd."Type of Business" := SalesLineL."Type of Business";
                    If ItemL."Item Issue Closing Date" <> 0D then
                        IssueAd."Print Documents Enddate" := ItemL."Item Issue Closing Date";
                    IssueAd.Modify();

                end
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