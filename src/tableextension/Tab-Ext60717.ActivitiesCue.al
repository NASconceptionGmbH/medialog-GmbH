tableextension 60717 "Activities Cue" extends "Activities Cue"
{
    fields
    {
        field(60700; "Job Queue Entry"; Integer)
        {
            Caption = 'Job Queue Entry';
            FieldClass = FlowField;
            CalcFormula = Count("Job Queue Entry" WHERE("Object ID to Run" = FILTER(>= 50000 & <= 99999), Status = filter(Error)));
        }
    }

}
