report 60706 "Set Posting Date"
{
    Caption = 'Set Posting Date';
    //UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            trigger
            OnAfterGetRecord()
            var
                VulkanFunctionsL: Codeunit "Vulkan Functions";
            begin
                VulkanFunctionsL.GetEarliestPublicationdDate(SalesHeader, 0D, '');
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
    }
}