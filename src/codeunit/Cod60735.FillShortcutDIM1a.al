codeunit 60735 "FillShortcut DIM1a"
{
    trigger OnRun()
    var
        SalesLineL: Record "Sales Line";
        ItemL: Record Item;
        SalesHeaderL: Record "Sales Header";
        SalesHeaderL2: Record "Sales Header";
    begin
        SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        if SalesLineL.FindSet() then
            repeat
                if ItemL.Get(SalesLineL."No.") then begin
                    SalesLineL.SetHideValidationDialog(true);
                    SalesLineL.validate("Shortcut Dimension 1 Code", itemL."Global Dimension 1 Code");
                    SalesLineL.modify();
                end;
            until SalesLineL.next() = 0;



        clear(SalesLineL);
        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
        if SalesHeaderL.FindSet() then
            repeat
                SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
                SalesLineL.SetRange("Document No.", SalesHeaderL."No.");
                SalesLineL.SetRange(Type, SalesLineL.Type::Item);
                if SalesLineL.FindFirst() then begin
                    SalesHeaderL2.Get(SalesHeaderL."Document Type", SalesHeaderL."No.");
                    SalesHeaderL2.SetHideValidationDialog(true);
                    SalesHeaderL2.Validate("Shortcut Dimension 1 Code", SalesLineL."Shortcut Dimension 1 Code");
                    SalesHeaderL2.Modify(true);
                end;
            until SalesHeaderL.next() = 0;
    end;


    //         trigger OnAfterValidate()
    //         var
    //             itemL: Record Item;
    //         begin
    //             if rec.Type = REC.Type::Item then begin
    //                 if ItemL.Get(Rec."No.") then begin
    //                     Rec.validate("Shortcut Dimension 1 Code", itemL."Global Dimension 1 Code");
    //                 end;
    //             end;
    //         end;
    //     }
    // }
    // trigger OnAfterInsert()
    // var
    //     SalesHeaderL: Record "Sales Header";
    //     SalesLineL: Record "Sales Line";
    //     ContactL: Record Contact;
    // begin
    //     IF Type = Type::Item then begin
    //         SalesLineL.SetRange("Document No.", Rec."Document No.");
    //         SalesLineL.SetRange(Type, SalesLineL.Type::Item);
    //         if SalesLineL.Count = 1 then
    //             if SalesHeaderL.GEt(Rec."Document Type", Rec."Document No.") then begin
    //                 SalesHeaderL.SetHideValidationDialog(true);
    //                 SalesHeaderL.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
    //                 SalesHeaderL.Modify(true);
    //             end;
}