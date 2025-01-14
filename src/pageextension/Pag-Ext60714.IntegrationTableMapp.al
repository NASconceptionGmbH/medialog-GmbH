pageextension 60714 "IntegrationTableMapp" extends "Integration Table Mapping List"
{
    layout
    {

    }

    actions
    {
        addafter(FieldMapping)
        {
            action(FieldMappingEditable)
            {
                ApplicationArea = Suite;
                Caption = 'Fields EDITABLE';
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "IntegrationFieldMappingListNAS";
                RunPageLink = "Integration Table Mapping Name" = FIELD(Name);
                RunPageMode = View;
                ToolTip = 'View fields in Dynamics 365 Sales integration tables that are mapped to fields in Business Central.';
            }
        }
    }
}