codeunit 60703 "RC Notification SP Connect"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Role Center Notification Mgt.", 'OnBeforeShowNotifications', '', true, true)]
    local procedure ShowNotifications()
    begin
        InstallApp();
    end;



    local procedure InstallApp()
    var
        SharepointSetup: Record "SharePoint Setup";
        Notif: Notification;
        NotifMsgTxt: Label 'NC365 SharePoint Connect is not configured yet', comment = 'DEU="NC365 Sharepoint Connect ist noch nicht eingerichtet."';
        NotifActTxt: Label 'configure...', comment = 'DEU="einrichten..."';
        NotificationIdTxt: Label '32b2e04a-2665-41dc-8af4-0993652ed457', Locked = true;
    begin
        //   if AreNotificationsSupported() then begin
        if SharepointSetup.Get() then
            if NOT SharepointSetup.InBearbeitung then
                exit;

        Notif.Id := NotificationIdTxt;
        Notif.Message := NotifMsgTxt;
        Notif.Scope := NotificationScope::LocalScope;
        Notif.AddAction(NotifActTxt, Codeunit::"RC Notification SP Connect", 'OpenWiz');
        Notif.Send();
    end;

    procedure OpenWiz(Notif: Notification)
    var
        Pag: Page "Install Sharepoint Connect";
    begin
        Pag.RunModal();
    end;

}