<cfparam name="isPersonal" default="no" type="any">
<cfparam name="ecode" default="I1276" type="any">
<cfparam name="textonly" default="0" type="any">
<cfparam name="datafile" default="test" type="any">

<cfsetting showdebugoutput="no">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<script language="javascript">
function submitIt(doSend) {
	var frm = document.sendForm;
	//console.log("doSend: %d",doSend);
	
	frm.sendit.value = doSend;
	frm.submit();
}
</script>

</head>

<body>
<h3>CPG Toolbox invite</h3>

<cfset ecodeList = "Announcement,Reminder,Survey,Prolia_Update">
<!---
UserTesting-1,UserTesting-2,UserTesting-3,UserTesting-4A,UserTesting-4B,Preview_Dempster,Preview_Singer,Preview_McClung,Preview_Tough,Preview_Cosman
--->

<cfdirectory action="list" directory="#ExpandPath('.')#" recurse="yes" name="qryListFiles" filter="ready_*.txt">

<cfform name="sendForm" action="#CGI.SCRIPT_NAME#?t=#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#" method="post">
<cfinput type="hidden" name="sendit" value="0">
<p><select name="ecode" size="1">
<cfloop list="#ecodeList#" index="eIdx">
<cfoutput><option value="#eIdx#" <cfif ecode eq eIdx>selected="selected"</cfif>>#eIdx#</option></cfoutput>
</cfloop>
</select></p>
<p><input type="checkbox" name="textonly" value="1" />Text Only?</p>
<p><cfinput type="checkbox" name="isPersonal" value="yes">Personal?</p>


<cfset tmpDir ="">
<cfset currDir ="">
<cfset path ="">

<p>Datafile:<select name="datafile" size="1">
<option value="test">Test</option>
<cfloop query="qryListFiles">

<cfset tmpDir = ListLast(qryListFiles.Directory,"\")>

<cfset path = tmpDir & "/" & qryListFiles.name>

<cfif currDir neq tmpDir>
  <cfif currDir neq ""></optgroup></cfif>
  <optgroup label="<cfoutput>#tmpDir#</cfoutput>">
  <cfset currDir = tmpDir>
</cfif>  
<cfoutput><option value="#path#" <cfif datafile eq path>selected="selected"</cfif>>#qryListFiles.name#</option></cfoutput>
</cfloop>


</select></p>

<div align="left">
<input type="button" name="sendBtn" value="Send Emails" onclick="submitIt(1);" />
&nbsp;&nbsp;&nbsp;
<input type="button" name="resBtn" value="Reset/Load Data" onclick="submitIt(0);" />
</div>

</cfform>


<cfset htmlFile= "STRC_#ecode#.html">
<cfset textFile= "STRC_#ecode#.txt">

<cfif ecode eq "Announcement">
  <cfset subj = "Launch of Bone Health Speaker Training Resource Center">
  <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
  <cfset batchnum = "I0425-001">
  <cfset campaign = "C2880BAD13">
<cfelseif ecode contains "Reminder">
  <cfset subj = "Reminder: Speaker Training Resource Center Login Details">
  <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
  <cfset batchnum = "I0425-003">
  <cfset campaign = "2E6EABAE48">
<cfelseif ecode contains "Prolia_Update">
  <cfset subj = "=?utf-8?q?Prolia=C2=AE Prescribing Information Update?=">
  <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
  <cfset batchnum = "I0425-005">
  <cfset campaign = "35465CD21F">
<cfelseif ecode contains "Survey">
  <cfset subj = "Feedback Requested: Speaker Training Resource Center">
  <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
  <cfset batchnum = "I0425-004">
  <cfset campaign = "9E64C9BB18">
<cfelseif ecode contains "Preview_">
  <cfset htmlFile= "STRC_#ecode#.html">
  <cfset textFile= "STRC_Test.txt">
  <cfset subj = "Launch of the Speaker Training Resource Center">
  <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
  <cfset batchnum = "I0425-002">
  <cfset campaign = "E618F3D6A3">
<cfelseif ecode eq "UserTesting-1">
    <cfset htmlFile= "STRC_Test.html">
    <cfset textFile= "STRC_Test.txt">
    <cfset subj = "Speaker Resource Center Testing Volunteers (Group 1)">
    <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
    <cfset batchnum = "I0425-001">
    <cfset campaign = "E618F3D6A3">
<cfelseif ecode eq "UserTesting-2">
    <cfset htmlFile= "STRC_Test_2.html">
    <cfset textFile= "STRC_Test.txt">
    <cfset subj = "Speaker Resource Center Testing Volunteers (Group 2)">
    <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
    <cfset batchnum = "I0425-002">
    <cfset campaign = "E618F3D6A3">
<cfelseif ecode eq "UserTesting-3">
    <cfset htmlFile= "STRC_Test_3.html">
    <cfset textFile= "STRC_Test.txt">
    <cfset subj = "Speaker Resource Center Testing Volunteers (Group 3)">
    <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
    <cfset batchnum = "I0425-003">
    <cfset campaign = "E618F3D6A3">
<cfelseif ecode eq "UserTesting-4A">
    <cfset htmlFile= "STRC_Test_4.html">
    <cfset textFile= "STRC_Test.txt">
    <cfset subj = "Speaker Resource Center Testing Volunteers (Group 4A)">
    <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
    <cfset batchnum = "I0425-004">
    <cfset campaign = "E618F3D6A3">
<cfelseif ecode eq "UserTesting-4B">
    <cfset htmlFile= "STRC_Test_4b.html">
    <cfset textFile= "STRC_Test.txt">
    <cfset subj = "Please do not open the email: Speaker Resource Center Testing Volunteers (Group 4)">
    <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
    <cfset batchnum = "I0425-004b">
    <cfset campaign = "E618F3D6A3">
<cfelse>
	<cfset htmlFile= "STRC_announcement.html">
  <cfset textFile= "STRC_announcement.txt">
  <cfset subj = "Launch of Bone Health Speaker Training Resource Center">
  <cfset emailFrom = "Bone Health Team<bonehealthspeakers@communicationpartners.com>">
  <cfset batchnum = "I0425-001">
</cfif>

<!--- <cfset datafile= "coded list"> --->
<cfset lstEmails = "">

<!---  --->
<cfif FileExists(ExpandPath('#datafile#'))>
<cffile action="read" file="#ExpandPath('#datafile#')#" variable="lstEmails">
</cfif>

<cfset lstEmails = ListAppend(lstEmails,"Bob Hood|bobh@communicationpartners.com|Impact3604",";")>
<!---cfset lstEmails = ListAppend(lstEmails,"Tuan Doan|TuanD@communicationpartners.com|Impact01",";")>
<cfset lstEmails = ListAppend(lstEmails,"Denise Zubrod|Denise.Zubrod@Communicationpartners.com|Impact01",";")--->




<!--- 
<cfset lstEmails = ListAppend(lstEmails,"Dr. Hood|bhood2k@yahoo.com|x0086",";")>
<cfset lstEmails = ListAppend(lstEmails,"Dr. Hood|bhood2k@gmail.com|x0077",";")>

 --->
<!--- 
<cfset lstEmails = ListAppend(lstEmails,"Juli Svercl|JuliS@communicationpartners.com",";")> 
<cfset lstEmails = ListAppend(lstEmails,"Kelly Gilbert|KellyG@communicationpartners.com",";")>
<cfset lstEmails = ListAppend(lstEmails,"Galperin|Elena.Galperin@CommunicationPartners.com",";")> 
<cfset lstEmails = ListAppend(lstEmails,"Ms. Smith-Montano|tsm@communicationpartners.com",";")>
--->

<!--- 
<cfset lstEmails = ListAppend(lstEmails,"Heaton|heaton@amgen.com",";")>

<cfdump var="#lstEmails#"></cfdump>

 --->


<p><cfoutput>#ListLen(lstEmails,";")# addresses loaded from <strong style="color:red;">#datafile#</strong>
<br />Sending:<a href="#htmlFile#" target="_blank"><strong>#htmlFile#</strong></a> and <a href="#textFile#" target="_blank"><strong>#textFile#</strong></a><br />
<br />From: #HTMLEditFormat(emailFrom)#
<br />Subject: #subj#
<br />
</cfoutput></p>


<cfset lstEmails = ListSort(lstEmails,"textnocase","asc",";")>
<div style="height:500px; width:300px; float:left; overflow:auto; border:solid 1px #000000; background-color:#F0F0C0; margin:15px; padding:10px;">
<cfoutput>
<ol><cfloop list="#lstEmails#" delimiters=";" index="idx">
<li>#Replace(idx,"|",", ","ALL")#</li></cfloop>
</ol>
</cfoutput>
</div>


<cfif isDefined("FORM.Sendit") and FORM.Sendit eq 1>
<div style="height:500px; width:300px; float:left; overflow:auto; border:solid 1px #000000; background-color:#C0F0C0; margin:15px; padding:10px;">
<ol>

<cfloop list="#lstEmails#" index="person" delimiters=";">
<cftry>

<cfset addr = "">
<cfset Lname = "">
<cfset ccaddr = "">
<cfset pword = "">

<cfif ListLen(person,"|") eq 1>
	<cfset addr = person>
  <cfset Lname = "">
  <cfset ccaddr = "">
<cfelse>

	<cfset addr = ListGetAt(person,2,"|")>
  <cfset Lname = ListGetAt(person,1,"|")>
  <cfif ListLen(person,"|") ge 3>
    <cfset pword = ListGetAt(person,3,"|")>
  <cfelse>
    <cfset pword = "">
  </cfif>
  <cfif ListLen(person,"|") ge 4>
    <cfset ccaddr = Replace(ListGetAt(person,4,"|"),",",";","ALL")>
  <cfelse>
    <cfset ccaddr = "">
  </cfif>

 <!---  
  <cfset addr = ListGetAt(person,1,"|")> --->
  <!--- <cfset ccaddr = ListGetAt(person,2,"|")> --->
  
</cfif>

<cfset login = addr>

<!--- <cfset addr = "JenniferM@communicationpartners.com"> --->

<cfset logstr = "batch=#batchnum#&campaign=#campaign#&emstr=#addr#">

<!--- <cfset addr = "bobh@communicationpartners.com"> --->

<cfif textonly eq 1>
  <cfmail 
    to="#addr#"
    from="#emailFrom#"
    cc="#ccaddr#"
    subject="#subj#"
  ><cfinclude template="#textFile#"> 
  </cfmail>
<cfelse>
	<cfmail 
    to="#addr#"
    from="#emailFrom#"
    cc="#ccaddr#"
    subject="#subj#">
    
    <cfmailpart type="text">
    <cfinclude template="#textFile#"> 
    </cfmailpart>
    
    <cfmailpart type="html">
    <cfinclude template="#htmlFile#"> 
    </cfmailpart>
  
  </cfmail>
</cfif>

<li><cfoutput>#addr#</cfoutput></li>
<cfcatch type="any">
<li style="color:red;"><cfoutput>#person# [#cfcatch.Message#]</cfoutput></li>
</cfcatch>
</cftry>

</cfloop>


<cfmail to="bobh@communicationpartners.com"
        from="#emailFrom#"
        subject="Email Blast #ecode#" type="html">
<h3>Email Blast #ecode#</h3>
#ListLen(lstEmails,";")# emails sent
<cfif isdefined("datafile")>
<br /><br />
Datafile:#datafile#
</cfif>

</cfmail>

</ol></div>
</cfif>


<!--- 
<cfif isDefined("URL.Sendit") and URL.Sendit eq 1>
<div style="height:500px; width:300px; float:left; overflow:auto; border:solid 1px #000000; background-color:#C0F0C0; margin:15px; padding:10px;">
<ol>

<cfloop list="#lstEmails#" index="addr" delimiters=";">

<cfif isPersonal eq "yes">
	<cfset tmpaddr = ListGetAt(addr,2,"|")>
	<cfset tmpLname = ListGetAt(addr,1,"|")>
<cfelse>
	<cfset tmpaddr = addr>
	<cfset tmpLname = "">
</cfif>

<cfmail 
to="#tmpaddr#"
from="#emailFrom#"
subject="#subj#">
<cfmailpart type="text">
<cfinclude template="#textFile#"> 
</cfmailpart>

<cfmailpart type="html">
<cfinclude template="#htmlFile#"> 
</cfmailpart>


</cfmail>

<li><cfoutput>#tmpLname#, #tmpaddr#</cfoutput></li>

</cfloop>
</ol></div>
</cfif> --->

<!--- <cfmailpart type="html">
 <cfinclude template="pre_provider_ltr_v4.html">
</cfmailpart> 
 
<cfmailpart type="text">
<cfinclude template="pre_provider_ltr_text.txt">
</cfmailpart> --->

</body>
</html>