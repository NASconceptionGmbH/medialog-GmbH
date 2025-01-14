pageextension 60718 "O365 Activities" extends "O365 Activities"
{

    layout
    {
        addbefore("Ongoing Sales")
        {
            cuegroup(job)
            {
                Caption = 'Job Queue';
                field("Job Queue Entry"; rec."Job Queue Entry")
                {
                    ApplicationArea = all;
                }
            }
        }


    }
}