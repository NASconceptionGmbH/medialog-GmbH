// report 60725 CorrectAbos
// {
//     Caption = 'Abo Korrektur Belegnummer';
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Sales Header"; "sales header")
//         {
//             trigger OnPreDataItem()
//             begin
//                 "Sales Header".SetRange("Subscription Order", true);
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 "Sales Header"."External Document No." := "Sales Header"."Subscription No.";
//                 "Sales Header".modify();
//             end;
//         }
//     }


// }