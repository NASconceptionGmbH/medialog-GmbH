reportextension 60703 "Create Recurring Sales Inv." extends "Create Recurring Sales Inv."
{

    dataset
    {
        // Add changes to dataitems and columns here
    }

    requestpage
    {
        // Add changes to the requestpage here
    }
    trigger
    OnPreReport()
    begin
        Error('Bitte Wiederkehrende Verkaufsrechnung Vulkan nutzen');
    end;
}