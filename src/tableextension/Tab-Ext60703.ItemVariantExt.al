tableextension 60703 "Item Variant Ext." extends "Item Variant"
{
    fields
    {
        field(60700; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var

            begin

            end;
        }
        field(60701; "Gen. Product Posting Group"; Code[20])
        {
            Caption = 'Produktbuchungsgruppe';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(60702; "VAT Product Posting Group"; Code[20])
        {
            Caption = 'MwSt. Produktbuchungsgruppe';
            TableRelation = "VAT Product Posting Group";
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }
    trigger
    OnModify()
    var
        ItemL: Record Item;
        ItemVariantL: Record "Item Variant";
    begin
        ItemL.SetRange(Subscription, Rec."Item No.");
        If ItemL.FindSet() then
            repeat
                ItemVariantL.SetRange("Item No.", ItemL."No.");
                ItemVariantL.SetRange(Code, Rec.Code);
                IF ItemVariantL.FindFirst() then begin
                    ItemVariantL.Description := Rec.Description;
                    ItemVariantL."Description 2" := Rec."Description 2";
                    ItemVariantL."Unit Price" := Rec."Unit Price";
                    ItemVariantL."Gen. Product Posting Group" := rec."Gen. Product Posting Group";
                    ItemVariantL."VAT Product Posting Group" := Rec."VAT Product Posting Group";
                    ItemVariantL.Modify(true);
                end;
            until Iteml.Next() = 0;
        ItemL.Reset();
        ItemL.SetRange("Template Item", Rec."Item No.");
        If ItemL.FindSet() then
            repeat
                ItemVariantL.SetRange("Item No.", ItemL."No.");
                ItemVariantL.SetRange(Code, Rec.Code);
                IF ItemVariantL.FindFirst() then begin
                    ItemVariantL.Description := Rec.Description;
                    ItemVariantL."Description 2" := Rec."Description 2";
                    ItemVariantL."Unit Price" := Rec."Unit Price";
                    ItemVariantL."Gen. Product Posting Group" := rec."Gen. Product Posting Group";
                    ItemVariantL."VAT Product Posting Group" := Rec."VAT Product Posting Group";
                    ItemVariantL.Modify(true);
                end;
            until Iteml.Next() = 0;
    end;

    trigger
    OnRename()
    var
        ItemL: Record Item;
        ItemVariantL: Record "Item Variant";
    begin
        ItemL.SetRange(Subscription, Rec."Item No.");
        If ItemL.FindSet() then
            repeat
                ItemVariantL.SetRange("Item No.", ItemL."No.");
                ItemVariantL.SetRange(Code, xRec.Code);
                IF ItemVariantL.FindFirst() then begin
                    ItemVariantL.Description := Rec.Description;
                    ItemVariantL."Description 2" := Rec."Description 2";
                    ItemVariantL."Unit Price" := Rec."Unit Price";
                    ItemVariantL."Gen. Product Posting Group" := rec."Gen. Product Posting Group";
                    ItemVariantL."VAT Product Posting Group" := Rec."VAT Product Posting Group";
                    ItemVariantL.Rename(Rec."Item No.", Rec.Code);
                end;
            until Iteml.Next() = 0;
        ItemL.Reset();
        ItemL.SetRange("Template Item", Rec."Item No.");
        If ItemL.FindSet() then
            repeat
                ItemVariantL.SetRange("Item No.", ItemL."No.");
                ItemVariantL.SetRange(Code, xRec.Code);
                IF ItemVariantL.FindFirst() then begin
                    ItemVariantL.Description := Rec.Description;
                    ItemVariantL."Description 2" := Rec."Description 2";
                    ItemVariantL."Unit Price" := Rec."Unit Price";
                    ItemVariantL."Gen. Product Posting Group" := rec."Gen. Product Posting Group";
                    ItemVariantL."VAT Product Posting Group" := Rec."VAT Product Posting Group";
                    ItemVariantL.Rename(ItemL."No.", Rec.Code);
                end;
            until Iteml.Next() = 0;
    end;

    trigger
    OnAfterInsert()
    var
        ItemL: Record Item;
        ItemVariantL: Record "Item Variant";
    begin
        ItemL.SetRange(Subscription, Rec."Item No.");
        If ItemL.FindSet() then
            repeat
                ItemVariantL."Item No." := ItemL."No.";
                ItemVariantL.Code := Rec.Code;
                ItemVariantL.Description := Rec.Description;
                ItemVariantL."Description 2" := Rec."Description 2";
                ItemVariantL."Unit Price" := Rec."Unit Price";
                ItemVariantL."Gen. Product Posting Group" := rec."Gen. Product Posting Group";
                ItemVariantL."VAT Product Posting Group" := Rec."VAT Product Posting Group";
                IF ItemVariantL.Insert(true) then
                    ;
            until Iteml.Next() = 0;
        ItemL.Reset();
        ItemL.SetRange("Template Item", Rec."Item No.");
        If ItemL.FindSet() then
            repeat
                ItemVariantL."Item No." := ItemL."No.";
                ItemVariantL.Code := Rec.Code;
                ItemVariantL.Description := Rec.Description;
                ItemVariantL."Description 2" := Rec."Description 2";
                ItemVariantL."Unit Price" := Rec."Unit Price";
                ItemVariantL."Gen. Product Posting Group" := rec."Gen. Product Posting Group";
                ItemVariantL."VAT Product Posting Group" := Rec."VAT Product Posting Group";
                IF ItemVariantL.Insert(true) then
                    ;
            until Iteml.Next() = 0;
    end;

    var
        myInt: Integer;
}