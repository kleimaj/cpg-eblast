<cfparam name="isPersonal" default="no" type="any">
<cfparam name="ecode" default="I1276" type="any">
<cfparam name="textonly" default="0" type="any">
<cfparam name="datafile" default="test" type="any">

<cfparam name="chkSendLive" default="0" type="any">
<cfparam name="txtShortcut" default="bobh@communicationpartners.com" type="any">

<cfsetting showdebugoutput="no">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CPG Toolbox Email Blast Invites</title>

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
<h3>P2-016-Wecast-Reg-Blast</h3>
<h4>Targeted emails</h4>

<cfset ecodeList = "ProgramComm_1">
<!---
UserTesting-1,UserTesting-2,UserTesting-3,UserTesting-4A,UserTesting-4B,Preview_Dempster,Preview_Singer,Preview_McClung,Preview_Tough,Preview_Cosman
--->

<cfdirectory action="list" directory="#ExpandPath('.')#" recurse="yes" name="qryListFiles" filter="ready_*.json.txt">

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

<p>Send Test to:<input type="text" id="txtShortcut" name="txtShortcut" value="GouriK@communicationpartners.com" size="50"><br>
  <input type="checkbox" id="chkSendLive" name="chkSendLive" value="1"><label for="chkSendLive">No, send to live addresses</label>
  </p>
  

<div align="left">
<input type="button" name="sendBtn" value="Send Emails" onclick="submitIt(1);" />
&nbsp;&nbsp;&nbsp;
<input type="button" name="resBtn" value="Reset/Load Data" onclick="submitIt(0);" />
</div>

</cfform>


<cfif ecode eq "ProgramComm_1">
	<cfset htmlFile= "CPG_Toolbox_161.html">
  <cfset textFile= "STRC_ProgramComm_1.txt">
  <cfset subj = "CPG Toolbox Webcast">
  <cfset emailFrom = "cpgtoolbox@communicationpartners.com">
  <cfset batchnum = "P2016-001">
  <cfset campaign = "BB8889E9D5">
<cfelse>
	<cfset htmlFile= "CPG_Toolbox_161.html">
  <cfset textFile= "STRC_ProgramComm_1.txt">
  <cfset subj = "CPG Toolbox Webcast">
  <cfset emailFrom = "cpgtoolbox@communicationpartners.com">
  <cfset batchnum = "P2016-001">
  <cfset campaign = "BB8889E9D5">
</cfif>

<!--- <cfset datafile= "coded list"> --->
<cfset lstEmails = "">

<!---

<cfset datafile = "data_2022-03-09/ready_data_test.json.txt">
  --->
<cfif FileExists(ExpandPath('#datafile#'))>
<cffile action="read" file="#ExpandPath('#datafile#')#" variable="lstEmails">
<cfelse>
</body>
</html>
  <cfabort>

</cfif>

<cftry>

<cfset EmailData = deserializeJSON(lstEmails)>
<cfset EmailCount = ArrayLen(EmailData)>

<p><cfoutput>#EmailCount# addresses loaded from <strong style="color:red;">#datafile#</strong>
<br />Sending:<a href="#htmlFile#" target="_blank"><strong>#htmlFile#</strong></a> and <a href="#textFile#" target="_blank"><strong>#textFile#</strong></a><br />
<br />From: #HTMLEditFormat(emailFrom)#
<br />
</cfoutput></p>
<cfcatch type="any">
  <p style="color:red;"><cfoutput>#cfcatch.Message#</cfoutput></p>
  </cfcatch>
</cftry>

<div style="height:500px; width:300px; float:left; overflow:auto; border:solid 1px #000000; background-color:#F0F0C0; margin:15px; padding:10px;">
<cfoutput>
<ol><cfloop from="1" to="#EmailCount#" index="i">
  <cftry>
<li>#EmailData[i].LastName# (#EmailData[i].Email#)</li>

<cfcatch type="any">
  <p style="color:red;"><cfoutput>#cfcatch.Message#</cfoutput></p>
  </cfcatch>
</cftry>

</cfloop>
</ol>
</cfoutput>
</div>


<cfif isDefined("FORM.Sendit") and FORM.Sendit eq 1>
<div style="height:500px; width:300px; float:left; overflow:auto; border:solid 1px #000000; background-color:#C0F0C0; margin:15px; padding:10px;">
<ol>


  
<cfloop from="1" to="#EmailCount#" index="idx">
<cftry>

<cfset addr = EmailData[idx].Email>
<cfset Lname = EmailData[idx].Salutation & " " & EmailData[idx].LastName>
<cfset ccaddr = "">

<cfset ProgramDate = EmailData[idx].DateOfProgram>
<cfset ProgramTitle = EmailData[idx].ProgramTitle>
<cfset Paragraph2 = EmailData[idx].Paragraph2>

<cfset Replays = arrayNew(1)>
<cfloop index="replayIdx" from="1" to="15">
  <cfif structKeyExists(EmailData[idx], "Replay#replayIdx#") AND TRIM(EmailData[idx]["Replay#replayIdx#"]) neq "">
    <cfset x = arrayAppend(Replays, EmailData[idx]["Replay#replayIdx#"])>
  </cfif>
</cfloop>
<cfset Replay1 = EmailData[idx].Replay1>


<cfset usrname = EmailData[idx].Username>
<cfset pword = EmailData[idx].Password>
<cfset Notes = EmailData[idx].Notes>
<cfset subj = "CPG Toolbox Webcast on #ProgramDate#">

<!---cfif NOT ArrayIsEmpty(Replays)>
  <strong>PRESENTATION VIDEO REPLAYS</strong><ul>
      <cfloop array="#Replays#" item="replayItem">
          <li><cfoutput>#replayItem#</cfoutput></li>
      </cfloop>
</ul>
</cfif--->


<!---
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
</cfif>
--->
<cfset login = addr>

<!--- <cfset addr = "JenniferM@communicationpartners.com"> --->

<cfset logstr = "batch=#batchnum#&campaign=#campaign#&emstr=#addr#">

<cfif NOT(isDefined("chkSendLive") AND chkSendLive eq 1)>
  <cfset emailTo = txtShortcut>
  <cfoutput><p>Shortcut:#emailTo#</p></cfoutput>
<cfelse>
  <cfset emailTo = addr>
</cfif>


<cfif textonly eq 1>
  <cfmail 
    to="#emailTo#"
    from="#emailFrom#"
    cc="#ccaddr#"
    subject="#subj#"
  ><cfinclude template="#textFile#"> 
  </cfmail>
<cfelse>
	<cfmail 
    to="#emailTo#"
    from="#emailFrom#"
    cc="#ccaddr#"
    bcc="bobh@communicationpartners.com;gourik@communicationpartners.com"
    subject="#subj#">
    
    <cfmailpart type="text">
    <cfinclude template="#textFile#"> 
    </cfmailpart>
    
    <cfmailpart type="html">
    <cfinclude template="#htmlFile#"> 
    </cfmailpart>
  
  </cfmail>
</cfif>

<li><cfoutput>#addr# <br>[#emailTo#]</cfoutput></li>
<cfcatch type="any">
<li style="color:red;"><cfoutput>#person# [#cfcatch.Message#]</cfoutput></li>
</cfcatch>
</cftry>

</cfloop>


<cfmail to="bobh@communicationpartners.com;gourik@communicationpartners.com"
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

</body>
</html>
