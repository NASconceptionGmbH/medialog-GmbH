report 60718 CorrectSalesLInes
{
    Caption = 'CorrectSalesLInes';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {


            trigger OnPreDataItem()
            begin
                "Sales Line".SetRange("Document Type", "Sales Line"."Document Type"::Order);
                "Sales Line".SetRange(Type, "Sales Line".Type::Item);
                "Sales Line".Setfilter("Variant Code", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                ItemVariantL: Record "Item Variant";
            begin
                ItemVariantL.get("Sales Line"."No.", "Sales Line"."Variant Code");
                "Sales Line".validate("VAT Prod. Posting Group", ItemVariantL."VAT Product Posting Group");
                "Sales Line".validate("Gen. Prod. Posting Group", ItemVariantL."Gen. Product Posting Group");
                "Sales Line".modify(false);
            end;
        }
    }


}