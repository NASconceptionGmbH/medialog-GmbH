report 60713 "NC-6640 FixEmptyCustomersCRM"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnAfterGetRecord()
            var
                CRMAccountL: Record "CRM Account";
            begin
                CRMAccountL.SetRange(new_bccustomerno, Customer."No.");
                CRMAccountL.SetFilter(Name, '');
                if CRMAccountL.FindFirst() then
                    Customer.Modify();
            end;
        }
    }

    trigger OnInitReport()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;
}