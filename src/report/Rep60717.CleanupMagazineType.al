report 60717 "Cleanup Magazine Type"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;
    dataset
    {
        dataitem("Standard Customer Sales Code"; "Standard Customer Sales Code")
        {
            trigger
            OnAfterGetRecord()
            var
                StandardSalesCodeL: Record "Standard Sales Code";
            begin
                IF StandardSalesCodeL.Get(Code) then begin
                    "Magazine Type" := StandardSalesCodeL."Magazine Type";
                    "Salesperson Code" := StandardSalesCodeL."Salesperson Code";
                    "Salesperson Code 2" := StandardSalesCodeL."Salesperson Code 2";
                    Commission := StandardSalesCodeL.Commission;
                    "Commission 2" := StandardSalesCodeL."Commission 2";
                    Modify();
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