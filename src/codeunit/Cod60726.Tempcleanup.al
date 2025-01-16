// codeunit 60730 CleanUp
// {
//     trigger OnRun()
//     var
//         // CustomerL: Record Customer;
//         CRMIntegrationRecordL: Record "CRM Integration Record";
//     begin
//         // CustomerL.DeleteAll();

//         Codeunit.Run(Codeunit::"CRM Integration Management");
//         CRMIntegrationRecordL.SetRange("Table ID", 18);
//         CRMIntegrationRecordL.DeleteAll();

//     end;

//     var
//         myInt: Integer;
// }