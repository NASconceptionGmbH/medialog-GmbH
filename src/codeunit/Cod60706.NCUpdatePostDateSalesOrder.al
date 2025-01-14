codeunit 60706 "NC UpdatePostDateSalesOrder"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SetDateBoo: Boolean;
        Item: Record Item;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Posting Date", Today - 1);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        IF SalesHeader.FindSet() then
            repeat
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if SalesLine.FindSet() then
                    repeat
                        if Item.get(SalesLine."No.") then
                            if (Item."Item Category Code" = 'ARTIKEL') OR (Item."Item Category Code" = 'BUCH') OR (Item."Item Category Code" = 'EBOOK') then
                                SetDateBoo := true;
                    until SalesLine.Next() = 0;
                if SetDateBoo then begin
                    SalesHeader.Validate("Posting Date", Today);
                    Salesheader.Modify();
                end;
                SetDateBoo := false;
            until SalesHeader.Next() = 0;
    end;
}
