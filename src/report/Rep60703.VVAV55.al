report 60703 "VVAV-55"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Fill Item Variant Description';
    ProcessingOnly = true;
    dataset
    {
        dataitem(DataItemVariant; "Item Variant")
        {

            trigger
            OnAfterGetRecord()
            var
                ItemL: Record Item;
                ItemVariantL: Record "Item Variant";
                stop: text;
            begin

                Iteml.Get(DataItemVariant."Item No.");
                If ItemL."Template Item" <> '' then begin
                    ItemVariantL.SetRange("Item No.", ItemL."Template Item");
                    ItemVariantL.SetRange(Code, DataItemVariant.Code);
                    If ItemVariantL.FindFirst() then begin
                        DataItemVariant.Description := ItemVariantL.Description;
                        DataItemVariant."Description 2" := ItemVariantL."Description 2";
                        DataItemVariant."VAT Product Posting Group" := ItemVariantL."VAT Product Posting Group";
                        DataItemVariant."Gen. Product Posting Group" := ItemVariantL."Gen. Product Posting Group";
                        DataItemVariant.Modify();
                    end;
                end;
                If ItemL.Subscription <> '' then begin
                    ItemVariantL.SetRange("Item No.", ItemL.Subscription);
                    ItemVariantL.SetRange(Code, DataItemVariant.Code);
                    If ItemVariantL.FindFirst() then begin
                        DataItemVariant.Description := ItemVariantL.Description;
                        DataItemVariant."Description 2" := ItemVariantL."Description 2";
                        DataItemVariant."VAT Product Posting Group" := ItemVariantL."VAT Product Posting Group";
                        DataItemVariant."Gen. Product Posting Group" := ItemVariantL."Gen. Product Posting Group";
                        DataItemVariant.Modify();
                    end;
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

    trigger
    OnPostReport()
    begin
        Message('done');
    end;

    var
        myInt: Integer;
}