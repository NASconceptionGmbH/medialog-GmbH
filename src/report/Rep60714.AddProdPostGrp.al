report 60714 "AddProdPostGrp"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            trigger OnPreDataItem()
            begin
                "Sales Line".SetRange("Document Type", "Document Type"::Order);
            end;

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                ItemVariantL: Record "Item Variant";
            begin

                if ("Sales Line"."Document Type" = "Sales Line"."Document Type"::Order) and ("Sales Line".Type = "Sales Line".Type::Item) and (ItemVariantL.Get("Sales Line"."No.", "Sales Line"."Variant Code")) and ("Sales Line"."Gen. Prod. Posting Group" = '') then begin
                    "Sales Line"."Gen. Prod. Posting Group" := ItemVariantL."Gen. Product Posting Group";
                    "Sales Line".Modify();
                end;
            end;
        }
    }
}