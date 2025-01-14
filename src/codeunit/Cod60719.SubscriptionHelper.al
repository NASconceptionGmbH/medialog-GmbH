codeunit 60719 "SubscriptionHelper"
{



    procedure GetItemForYear(ItemNoV: Code[20]; YearV: integer; SmallBusinessCampusV: boolean): code[20]
    var
        ItemL: Record Item;
    begin
        if SmallBusinessCampusV then
            ItemL.SetRange("Item Category Code", 'ABO SMALL-CAMPUS')
        else
            ItemL.SetRange("Item Category Code", 'ABO');
        ItemL.SetRange("Basic Product", ItemNoV);
        if ItemL.FindSet() then
            repeat
                if Date2DMY(ItemL."Publication Date", 3) = yearv then
                    exit(ItemL."No.")
            until ItemL.Next() = 0;

        exit('');
    end;
}