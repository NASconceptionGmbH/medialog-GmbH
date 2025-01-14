pageextension 60722 "Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field(Placement; Rec.Placement)
            {
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            trigger
            OnAfterValidate()
            var
                ItemL: Record Item;
                ItemCategoryL: Record "Item Category";
                SalesLineL: Record "Sales Line";

            begin
                If Rec.Type = Rec.Type::Item then begin
                    Iteml.Get(Rec."No.");
                    If ItemCategoryL.Get(ItemL."Item Category Code") then
                        If ItemCategoryL."Show Retail Price" then begin
                            SalesLineL.Init();
                            SalesLineL."Document Type" := Rec."Document Type";
                            SalesLineL."Document No." := Rec."Document No.";
                            SalesLineL."Line No." := Rec."Line No." + 250;
                            SalesLineL.Type := SalesLineL.Type::" ";
                            SalesLineL.Description := StrSubstNo(Label0001, ItemL."Unit Price");
                            SalesLineL.Insert();
                            CurrPage.Update();
                        end;
                end;
            end;
        }
        modify("Variant Code")
        {
            Visible = true;
            trigger
            OnAfterValidate()
            begin
                CurrPage.Update();
            end;

        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        Label0001: Label 'Ladenpreis: € %1';
}