tableextension 60701 "Item" extends Item
{
    fields
    {
        field(60700; "Subscription"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("Item Category Code" = field("Item Category Filter"));
            trigger
            OnValidate()
            var
                ItemVariantL: Record "Item Variant";
                ItemVariantL2: Record "Item Variant";
                ItemL: Record Item;
            begin
                ItemVariantL.SetRange("Item No.", Rec."No.");
                ItemVariantL.DeleteAll();
                ItemVariantL.SetRange("Item No.", Subscription);
                If ItemVariantL.FindSet() then
                    repeat
                        ItemVariantL2.Init();
                        ItemVariantL2."Item No." := Rec."No.";
                        ItemVariantL2.Code := ItemVariantL.Code;
                        ItemVariantL2.Validate("Unit Price", ItemVariantL."Unit Price");
                        ItemVariantL2.Description := ItemVariantL.Description;
                        ItemVariantL2."Description 2" := ItemVariantL."Description 2";
                        ItemVariantL2.Insert();
                    until ItemVariantL.Next() = 0;
                If ItemL.Get(Subscription) then
                    "Subscription Description" := Iteml.Description
                else
                    "Subscription Description" := '';
            end;

        }
        field(60701; "Issue Qty."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Item where(Subscription = field("No.")));
        }
        field(60702; "Issue Status"; Option)
        {
            OptionMembers = Open,Order,Invoiced;
            DataClassification = ToBeClassified;
        }

        field(60703; "Total Ads (Available)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60704; "Total Ads (Open)"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Issue Ad" where(Status = filter(Open), "Item No." = field("No.")));

        }
        field(60705; "Total Ads (Released)"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Issue Ad" where(Status = filter(Released), "Item No." = field("No.")));
        }
        field(60706; "Template Item"; Code[20])
        {
            TableRelation = Item where("Item Category Code" = field("Item Category Filter"));
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                ItemVariantL: Record "Item Variant";
                ItemVariantL2: Record "Item Variant";
                ItemL: Record Item;
            begin
                ItemVariantL.SetRange("Item No.", Rec."No.");
                ItemVariantL.DeleteAll();
                ItemVariantL.SetRange("Item No.", "Template Item");
                If ItemVariantL.FindSet() then
                    repeat
                        ItemVariantL2.Init();
                        ItemVariantL2."Item No." := Rec."No.";
                        ItemVariantL2.Code := ItemVariantL.Code;
                        ItemVariantL2.validate("Unit Price", ItemVariantL."Unit Price");
                        ItemVariantL2.Description := ItemVariantL.Description;
                        ItemVariantL2."Description 2" := ItemVariantL."Description 2";
                        ItemVariantL2."Gen. Product Posting Group" := ItemVariantL."Gen. Product Posting Group";
                        ItemVariantL2."VAT Product Posting Group" := ItemVariantL."VAT Product Posting Group";
                        ItemVariantL2.Insert();
                    until ItemVariantL.Next() = 0;
                If ItemL.Get("Template Item") then begin
                    "Template Item Description" := Iteml.Description;
                    "Magazine Type" := ItemL."Magazine Type";
                end else
                    "Template Item Description" := '';
            end;
        }
        field(60707; "Subscription Description"; Text[100])
        {
            Caption = 'Beschreibung';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60708; "Template Item Description"; Text[100])
        {
            Caption = 'Beschreibung';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(60709; "Item Category Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
        field(60710; "Magazine Type"; Code[10])
        {
            Caption = 'Magazine Type';
            DataClassification = ToBeClassified;
            TableRelation = "Magazine Type";
        }
        field(60711; "Item Issue Closing Date"; Date)
        {
            Caption = 'Anzeigenschlusstermin';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                IssueAdL.SetRange("Item No.", "No.");
                If IssueAdL.FindSet() then
                    repeat
                        IssueAdL."Print Documents Enddate" := Rec."Item Issue Closing Date";
                        IssueAdL.Modify(true);
                    until IssueAdL.Next() = 0;
            end;
        }
        field(60712; "CRM GUID"; Guid)
        {
            Caption = 'CRM ID';
            DataClassification = ToBeClassified;
        }
        field(60713; "Planned Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planwert';
        }
        field(60714; "Marked for Update IssueList"; Boolean)
        {
            Caption = 'Markiert für Dispolisten Update';
            DataClassification = ToBeClassified;
        }
        field(60715; "ItemDescriptionUploaded"; Boolean)
        {
            Caption = 'ItemDescriptionUploaded';
            DataClassification = ToBeClassified;
        }
        field(60716; "Basic Product"; code[20])
        {
            Caption = 'Basic Product';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }


        modify("Publication Date")
        {
            trigger
            OnAfterValidate()
            var
                IssueAdL: Record "Issue Ad";
                SalesHeaderL: Record "Sales Header";
                VulkanFunctionsL: Codeunit "Vulkan Functions";
            begin
                IssueAdL.SetRange("Item No.", "No.");
                IssueAdL.SetFilter("Invoice No.", '');
                IssueAdL.SetFilter("Sales Order No.", '<>%1', '');
                If IssueAdL.FindSet() then
                    repeat
                        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
                        SalesHeaderL.SetRange("No.", IssueAdL."Sales Order No.");
                        If SalesHeaderL.FindFirst() then
                            VulkanFunctionsL.GetEarliestPublicationdDate(SalesHeaderL, Rec."Publication Date", Rec."No.");
                    until IssueAdL.Next() = 0;
            end;
        }

    }

    var
        myInt: Integer;
}