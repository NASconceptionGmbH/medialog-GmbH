tableextension 60700 "Sales Line" extends "Sales Line"
{
    fields
    {
        field(60700; Placement; Text[80])
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                If IssueAdL.Get("Document No.", "Line No.") then begin
                    IssueAdL.Placement := Placement;
                    IssueAdL.Modify(true);
                end
            end;
        }
        field(60701; "Motive"; Text[80])
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                If IssueAdL.Get("Document No.", "Line No.") then begin
                    IssueAdL.Motive := Motive;
                    IssueAdL.Modify(true);
                end

            end;
        }
        field(60702; "Print Documents"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                If IssueAdL.Get("Document No.", "Line No.") then begin
                    IssueAdL."Print Documents" := "Print Documents";
                    IssueAdL.Modify(true);
                end

            end;
        }
        field(60703; "Print Documents Enddate"; Date)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                If IssueAdL.Get("Document No.", "Line No.") then begin
                    IssueAdL."Print Documents Enddate" := "Print Documents Enddate";
                    IssueAdL.Modify(true);
                end

            end;
        }
        field(60704; "Confirmation Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                IssueAdL: Record "Issue Ad";
            begin
                If IssueAdL.Get("Document No.", "Line No.") then begin
                    IssueAdL."Confirmation Date" := "Confirmation Date";
                    IssueAdL.Modify(true);
                end

            end;
        }
        field(60705; "Type of Business"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Type of Business".Code;
            Caption = 'Art des Geschäfts';
            trigger OnValidate()
            var
                CustomerTypeL: Record "Customer Type";
                SalesHeaderL: Record "Sales Header";
                IssueAdL: Record "Issue Ad";
            begin
                if Rec.Type = Rec.Type::Item then begin
                    IF SalesHeaderL.Get(Rec."Document Type", Rec."Document No.") then begin
                        CustomerTypeL.Init();
                        CustomerTypeL."Customer No." := SalesHeaderL."Sell-to Customer No.";
                        CustomerTypeL."Type of Business Code" := Rec."Type of Business";
                        IF NOT CustomerTypeL.Insert() then
                            ;
                        CustomerTypeL.Init();
                        CustomerTypeL."Customer No." := SalesHeaderL."Ship-To Customer No.";
                        CustomerTypeL."Type of Business Code" := Rec."Type of Business";
                        IF not CustomerTypeL.Insert() then
                            ;
                        CustomerTypeL.Init();
                        CustomerTypeL."Customer No." := SalesHeaderL."Bill-to Customer No.";
                        CustomerTypeL."Type of Business Code" := Rec."Type of Business";
                        if Not CustomerTypeL.Insert() then
                            ;
                        IssueAdL.SetRange("Sales Order No.", "Document No.");
                        IssueAdL.SetRange("Sales Line No.", "Line No.");
                        If IssueAdL.FindFirst() then begin
                            IssueAdL."Type of Business" := Rec."Type of Business";
                            IssueAdL.Modify(true);
                        end;
                    end

                end;
            end;
        }
        field(60708; "CRM Order ID"; Guid)
        {
            Caption = 'CRM Order ID';
            DataClassification = ToBeClassified;
        }
        field(60706; "Is Handled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            var
                IssueAdL: Record "Issue Ad";
                Item: Record Item;
                IssueSetup: Record "Issue Setup";
                SalesHeaderL: Record "Sales Header";
                ItemVariantL: Record "Item Variant";
                CustomReportSelectionL: Record "Custom Report Selection";
                SelectionUsage: Enum "Report Selection Usage";
                SalesLineL, SalesLine2L : Record "Sales Line";
                LastLineNo: Integer;
                IssueDateENU: label 'Issue Closing Date %1';
                IssueDateDEU: label 'Anzeigenschluss %1';
                IssueDateText: Text;
            begin
                IssueSetup.Get();
                If Rec.Type = Rec.Type::Item then begin
                    if Rec."Variant Code" <> '' then begin
                        Item.Get(Rec."No.");
                        ItemVariantL.SetRange("Item No.", Rec."No.");
                        ItemVariantL.SetRange(Code, Rec."Variant Code");
                        If ItemVariantL.FindFirst() then begin
                            Rec."Location Code" := '';
                            Rec."Bin Code" := '';
                            Rec."Gen. Prod. Posting Group" := ItemVariantL."Gen. Product Posting Group";
                            Rec.Validate("VAT Prod. Posting Group", ItemVariantL."VAT Product Posting Group");
                            Rec.Validate("Unit Price", ItemVariantL."Unit Price");
                        end;
                        case "Document Type" of
                            "Document Type"::Order, "Document Type"::Quote:
                                Begin
                                    SalesHeaderL.Get(Rec."Document Type", Rec."Document No.");
                                    If NOT SalesHeaderL."Issue Posting Date" then
                                        SalesHeaderL.Validate("Posting Date", Item."Publication Date")
                                    else
                                        If item."Publication Date" < SalesHeaderL."Posting Date" then
                                            SalesHeaderL.validate("Posting Date", Item."Publication Date");
                                    SalesHeaderL."Location Code" := '';
                                    If "Document Type" = "Document Type"::Order then
                                        SalesHeaderL."Is Issue" := true;
                                    SalesHeaderL.Modify();
                                    Rec.Description := Item.Description;
                                    Rec."Description 2" := Item."Description 2";
                                    Rec."Print Documents Enddate" := Item."Item Issue Closing Date";
                                    SalesLine2L.SetRange("Document Type", Rec."Document Type");
                                    SalesLine2L.SetRange("Document No.", Rec."Document No.");
                                    IF SalesLine2L.FindLast() then
                                        LastLineNo := SalesLine2L."Line No.";
                                    SalesLineL.Init();
                                    SalesLineL."Document Type" := Rec."Document Type";
                                    SalesLineL."Document No." := Rec."Document No.";
                                    SalesLineL."Line No." := LastLineNo + 10000 + 500;
                                    SalesLineL."Attached to Line No." := Rec."Line No.";
                                    SalesLineL.Type := SalesLineL.Type::" ";
                                    SalesLineL.Description := GetItemTranslation(ItemVariantL.Description, SalesHeaderL."Language Code", Item."No.", ItemVariantL.Code, DescType::"Description 1");
                                    SalesLineL.Insert();
                                    SalesLineL.Init();
                                    SalesLineL."Document Type" := Rec."Document Type";
                                    SalesLineL."Document No." := Rec."Document No.";
                                    SalesLineL."Attached to Line No." := Rec."Line No.";
                                    SalesLineL."Line No." := LastLineNo + 10000 + 600;
                                    SalesLineL.Type := SalesLineL.Type::" ";
                                    SalesLineL.Description := GetItemTranslation(ItemVariantL."Description 2", SalesHeaderL."Language Code", Item."No.", ItemVariantL.Code, DescType::"Description 2");
                                    ;
                                    SalesLineL.Insert();
                                    If "Document Type" = "Document Type"::Quote then begin
                                        SalesLineL.Init();
                                        SalesLineL."Document Type" := Rec."Document Type";
                                        SalesLineL."Document No." := Rec."Document No.";
                                        SalesLineL."Line No." := LastLineNo + 10000 + 700;
                                        SalesLineL."Attached to Line No." := Rec."Line No.";
                                        SalesLineL.Type := SalesLineL.Type::" ";
                                        if SalesHeaderL."Language Code" = '' then
                                            IssueDateText := IssueDateDEU
                                        else
                                            IssueDateText := IssueDateENU;
                                        SalesLineL.Description := StrSubstNo(IssueDateText, Item."Item Issue Closing Date");
                                        SalesLineL.Insert();
                                    end;
                                    //Insert Dispo List
                                    IF "Document Type" = "Document Type"::Order then begin
                                        IssueAdL.Init();
                                        IssueAdL.Validate("Sales Order No.", Rec."Document No.");
                                        IssueAdL.Validate("Sales Line No.", Rec."Line No.");
                                        IssueAdL.Validate("Item No.", Rec."No.");
                                        IssueAdL.Validate("Variant Code", Rec."Variant Code");
                                        IssueAdL.Validate("Unit Price", Rec."Unit Price");
                                        IssueAdL.Validate("Line Amount Excl. VAT", Rec.Amount);
                                        IssueAdL.Validate("Created Date", Today);
                                        IssueAdL.Validate("Sell-to Customer No.", Rec."Sell-to Customer No.");
                                        IssueAdL.Validate("Sales Person Code", SalesHeaderL."Salesperson Code");
                                        IssueAdL.Validate("Salesperson 2", SalesHeaderL."Salesperson Code 2");
                                        IssueAdL.Validate(Clerk, SalesHeaderL.Clerk);
                                        IssueAdL."Line Amount" := Rec."Amount Including VAT";
                                        IssueAdL."Ship-to Customer No." := SalesHeaderL."Ship-To Customer No.";
                                        IssueAdL."Ship-to Name" := SalesHeaderL."Ship-to Name";
                                        IF Item."Item Issue Closing Date" <> 0D then
                                            IssueAdL.Validate("Print Documents Enddate", item."Item Issue Closing Date")
                                        else
                                            IssueAdL.Validate("Print Documents Enddate", SalesHeaderL."Posting Date");
                                        IssueAdL.Validate(Format, ItemVariantL.Description);
                                        IssueAdL."Commission %" := SalesHeaderL."Commission Salesperson";
                                        IssueAdL."Commission 2 %" := SalesHeaderL."Commission Salesperson 2";
                                        IF SalesHeaderL."Commission Salesperson" <> 0 then
                                            IssueAdL."Commission Amount" := IssueAdL.CalcCommission(Rec.Amount, SalesHeaderL."Commission Salesperson");
                                        If SalesHeaderL."Commission Salesperson 2" <> 0 then
                                            IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(Rec.Amount, SalesHeaderL."Commission Salesperson 2");
                                        CustomReportSelectionL.SetRange("Source Type", 18);
                                        CustomReportSelectionL.SetRange("Source No.", Rec."Sell-to Customer No.");
                                        CustomReportSelectionL.SetRange(Usage, SelectionUsage::"Print Doc Reminder");
                                        If CustomReportSelectionL.FindFirst() then
                                            IssueAdL.Email := CustomReportSelectionL."Send To Email"
                                        Else
                                            IssueAdL.Email := SalesHeaderL."Sell-to E-Mail";
                                        IssueAdL.Insert(true);
                                    end;
                                end;
                        end;
                    end;
                end;
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            var
                IssueAdL: Record "Issue Ad";
                SalesHeaderL: Record "Sales Header";
            begin
                case "Document Type" of
                    "Document Type"::Order:
                        IF Type = Type::Item then
                            if "Variant Code" <> '' then begin
                                IF SalesHeaderL.GEt(SalesHeaderL."Document Type"::Order, Rec."Document No.") then begin
                                    IssueAdL.SetRange("Sales Order No.", "Document No.");
                                    IssueAdL.SetRange("Sales Line No.", "Line No.");
                                    If IssueAdL.FindFirst() then begin
                                        IssueAdL."Line Amount Excl. VAT" := Rec.Amount;
                                        IF SalesHeaderL."Commission Salesperson" <> 0 then
                                            IssueAdL."Commission Amount" := IssueAdL.CalcCommission(Rec.Amount, SalesHeaderL."Commission Salesperson");
                                        If SalesHeaderL."Commission Salesperson 2" <> 0 then
                                            IssueAdL."Commission Amount 2" := IssueAdL.CalcCommission(Rec.Amount, SalesHeaderL."Commission Salesperson 2");
                                        IssueAdL.Modify(true);
                                    end;
                                end;
                            end;
                end;
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                itemL: Record Item;
            begin
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                itemL: Record Item;
            begin
                if rec.Type = REC.Type::Item then begin
                    if ItemL.Get(Rec."No.") then begin
                        Rec.validate("Shortcut Dimension 1 Code", itemL."Global Dimension 1 Code");
                    end;
                end;
            end;
        }
    }
    trigger OnAfterInsert()
    var
        SalesHeaderL: Record "Sales Header";
        SalesLineL: Record "Sales Line";
        ContactL: Record Contact;
    begin
        IF Type = Type::Item then begin
            SalesLineL.SetRange("Document No.", Rec."Document No.");
            SalesLineL.SetRange(Type, SalesLineL.Type::Item);
            if SalesLineL.Count = 1 then
                if SalesHeaderL.GEt(Rec."Document Type", Rec."Document No.") then begin
                    SalesHeaderL.SetHideValidationDialog(true);
                    SalesHeaderL.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    SalesHeaderL.Modify(true);
                end;
            InsertSparte();
            InsertCharacteristics();
            if SalesHeaderL.GEt(Rec."Document Type", Rec."Document No.") then
                if ContactL.Get(SalesHeaderL."Sell-to Contact No.") then
                    InsertCharacteristicsContact(ContactL);
        end;
        if SalesHeaderL.GEt(SalesHeaderL."Document Type"::Order, Rec."Document No.") then begin
            Rec."CRM Order ID" := SalesHeaderL."CRM Order ID";
        end;
    end;

    trigger
    OnDelete()
    var
        SalesHeaderL: Record "Sales Header";
        IssueAdL: Record "Issue Ad";
    begin
        IF "Document Type" = "Document Type"::Order then begin
            IssueAdL.SetRange("Sales Order No.", Rec."Document No.");
            IssueAdL.SetRange("Sales Line No.", Rec."Line No.");
            If IssueAdL.FindFirst() then
                IssueAdL.Delete(true);
        end;
    end;

    local procedure InsertSparte()
    var
        CustomerSpartentoCRML: Record "Customer Sparten CRM";
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
    begin
        // ItemL.Get("No.");
        if ItemAttributeValueMappingL.Get(27, "No.", 19) then begin
            CustomerSpartentoCRML.Init();
            CustomerSpartentoCRML."Customer No." := "Sell-to Customer No.";
            CustomerSpartentoCRML.validate("Item Attribute Value ID", ItemAttributeValueMappingL."Item Attribute Value ID");
            if NOT CustomerSpartentoCRML.Insert() then;
        end;
    end;

    local procedure InsertCharacteristics()
    var
        CustomerCharacteristicsCRML: Record "Customer Characteristics CRM";
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemAttributeValue2L: Record "Item Attribute Value";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        // ItemL.Get("No.");
        //21|26|27|28
        ItemAttributeValueMappingL.SetRange("Table ID", 27);
        ItemAttributeValueMappingL.SetRange("No.", "No.");
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '21|26|27|28') //prod
        else //prod
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '22|23|24'); //sandbox
        if ItemAttributeValueMappingL.FindSet() then
            repeat
                if ItemAttributeValueL.get(ItemAttributeValueMappingL."Item Attribute ID", ItemAttributeValueMappingL."Item Attribute Value ID") then
                    if ItemAttributeValueL.Value <> '' then begin
                        ItemAttributeValue2L.Reset();
                        if EnvironmentInformationL.IsProduction() then
                            ItemAttributeValue2L.SetRange("Attribute ID", 21) //prod
                        else
                            ItemAttributeValue2L.SetRange("Attribute ID", 22); //sandbox
                        ItemAttributeValue2L.SetRange(Value, ItemAttributeValueL.Value);
                        if ItemAttributeValue2L.FindFirst() then begin
                            CustomerCharacteristicsCRML.Init();
                            CustomerCharacteristicsCRML."Customer No." := "Sell-to Customer No.";
                            CustomerCharacteristicsCRML.validate("Item Attribute Value ID", ItemAttributeValue2L."ID");
                            if NOT CustomerCharacteristicsCRML.Insert() then;
                        end;
                    end
            until ItemAttributeValueMappingL.Next() = 0;
    end;

    local procedure InsertCharacteristicsContact(ContactV: record Contact)
    var
        ContactCharacteristicsCRML: Record "Contact Characteristics CRM";
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemAttributeValue2L: Record "Item Attribute Value";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        // ItemL.Get("No.");
        //21|26|27|28
        ItemAttributeValueMappingL.SetRange("Table ID", 27);
        ItemAttributeValueMappingL.SetRange("No.", "No.");
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '21|26|27|28') //prod
        else //prod
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '22|23|24'); //sandbox
        if ItemAttributeValueMappingL.FindSet() then
            repeat
                if ItemAttributeValueL.get(ItemAttributeValueMappingL."Item Attribute ID", ItemAttributeValueMappingL."Item Attribute Value ID") then
                    if ItemAttributeValueL.Value <> '' then begin
                        ItemAttributeValue2L.Reset();
                        if EnvironmentInformationL.IsProduction() then
                            ItemAttributeValue2L.SetRange("Attribute ID", 21) //prod
                        else
                            ItemAttributeValue2L.SetRange("Attribute ID", 22); //sandbox
                        ItemAttributeValue2L.SetRange(Value, ItemAttributeValueL.Value);
                        if ItemAttributeValue2L.FindFirst() then begin
                            ContactCharacteristicsCRML.Init();
                            ContactCharacteristicsCRML."Contact No." := ContactV."No.";
                            ContactCharacteristicsCRML.validate("Item Attribute Value ID", ItemAttributeValue2L."ID");
                            if NOT ContactCharacteristicsCRML.Insert() then;
                        end;
                    end
            until ItemAttributeValueMappingL.Next() = 0;
    end;

    local procedure GetItemTranslation(DescriptionV: Text[100]; LanguageCodeV: Code[10]; ItemNoV: Code[20]; VariantCode: Code[10]; DescType: option "Description 1","Description 2"): text
    var
        ItemTranslationL: Record "Item Translation";
    begin
        if LanguageCodeV <> '' then
            if ItemTranslationL.Get(ItemNoV, "Variant Code", LanguageCodeV) then begin
                case DescType of
                    DescType::"Description 1":
                        begin
                            if ItemTranslationL.Description <> '' then
                                exit(ItemTranslationL.Description)
                        end;
                    DescType::"Description 2":
                        begin
                            if ItemTranslationL."Description 2" <> '' then
                                exit(ItemTranslationL."Description 2")
                        end;
                end;
            end;

        exit(DescriptionV)
    end;

    var
        DescType: option "Description 1","Description 2";
}

