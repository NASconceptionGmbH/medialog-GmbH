var URL = '';
$(document).ready(function(){
    // createElement('ACButton','controlAddIn','button',{onclick:"OpenPage()"},'Give Permissions');
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('getLang',null);
});
async function OpenPage(){
    var test = window.open(URL + encodeURI('https://www.office.com'),'SignIn');
};
async function gotLang(Lang, Link){
    switch (Lang){
        case 1031: //DE-DE
            createElement('ACButton','controlAddIn','button',{onclick:"OpenPage()"},'Berechtigungen');
            break;
        default:
            createElement('ACButton','controlAddIn','button',{onclick:"OpenPage()"},'Give Permissions');
            break;
    }
    URL = Link;
};
async function createElement(ElementID, ElementParentID, ElementTag, ElementAttr, InnerText) {
    var Prom = jQuery.Deferred();
    var ParentElement = document.getElementById(ElementParentID);
    if (ParentElement && !document.getElementById(ElementID)) {
        var NewElement = document.createElement(ElementTag);
        NewElement.setAttribute('id', ElementID);
        if (ElementAttr != null)
            Object.keys(ElementAttr).forEach(function (key) {
                NewElement.setAttribute(key, ElementAttr[key]);
            });
        if (InnerText != null)
            NewElement.appendChild(document.createTextNode(InnerText));
        ParentElement.appendChild(NewElement);
        Prom.resolve();
    }
    else {
        Prom.reject();
    }
    return Prom.promise();
};