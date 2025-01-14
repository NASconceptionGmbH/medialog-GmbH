pageextension 60705 "Sales Line Sub Ext." extends "Sales Order Subform"
{
    layout
    {
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
        addafter(Description)
        {
            field("Type of Business"; Rec."Type of Business")
            {
                ApplicationArea = All;
            }

            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = ALL;
                Visible = false;
                Enabled = false;
            }
            field(Motive; Rec.Motive)
            {
                ApplicationArea = All;
            }
            field(Placement; Rec.Placement)
            {
                ApplicationArea = All;
            }
            field("Confirmation Date"; Rec."Confirmation Date")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Print Documents"; Rec."Print Documents")
            {
                ApplicationArea = ALL;
            }
            field("Print Documents Enddate"; Rec."Print Documents Enddate")
            {
                ApplicationArea = All;
            }
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