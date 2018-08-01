{*
Copyright 2011-2015 Nick Korbel

This file is part of Booked Scheduler.

Booked Scheduler is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Booked Scheduler is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Booked Scheduler.  If not, see <http://www.gnu.org/licenses/>.
*}
{include file='globalheader.tpl' cssFiles='scripts/css/colorbox.css'}

{if $PageLoadException}
	<div class="error">There was an error loading this page. Please double check that the Booked database is created and configured properly.</div>
{/if}

<div class="validationSummary error" id="validationErrors">
	<ul>
	{async_validator id="fname" key="FirstNameRequired"}
        {async_validator id="lname" key="LastNameRequired"}
		{async_validator id="username" key="UserNameRequired"}
        {async_validator id="passwordmatch" key="PwMustMatch"}
        {async_validator id="passwordcomplexity" key="PwComplexity"}
        {async_validator id="emailformat" key="ValidEmailRequired"}
        {async_validator id="uniqueemail" key="UniqueEmailRequired"}
        {async_validator id="uniqueusername" key="UniqueUsernameRequired"}
        {async_validator id="captcha" key="CaptchaMustMatch"}
        {async_validator id="additionalattributes" key=""}
	</ul>
</div>

<div class="error" id="registrationError" style="display:none;">
	{translate key=UnknownError}
</div>

<div id="registrationbox">
	<form class="register" method="post" ajaxAction="{RegisterActions::Register}" id="frmRegister"
		  action="{$smarty.server.SCRIPT_NAME}">

		<div id="registerLoginFields">
			<div class="registrationHeader"><h3>{translate key=Login} ({translate key=AllFieldsAreRequired})</h3></div>
			<p>
				<label class="reg">*{translate key="Username"}<br/>
				{textbox name="LOGIN" class="input" value="Login" size="20"}
				</label>
			</p>

			<p>
				<label class="reg">*{translate key="Password"}(至少六碼)<br/>
				{textbox type="password" name="PASSWORD" class="input" value="" size="20"}
				</label>
			</p>

			<p>
				<label class="reg">*{translate key="PasswordConfirmation"}<br/>
				{textbox type="password" name="PASSWORD_CONFIRM" class="input" value="" size="20"}
				</label>
			</p>

			<input type="hidden" name="defaultHomepage" value="2"><!--預設默認主頁改為時間表且改用隱藏預設，讓使用者一註冊完即可進到預約畫面-->
			<!--<p>
				<label class="reg">*{translate key="DefaultPage"}<br/>
					<select {formname key='DEFAULT_HOMEPAGE'} class="input">
					{html_options values=$HomepageValues output=$HomepageOutput selected=$Homepage}
					</select>
				</label>
			</p>-->
		</div>

		<div id="registerProfileFields">
			<div class="registrationHeader"><h3>{translate key=Profile} ({translate key=AllFieldsAreRequired})</h3></div>
			<p>
				<label class="reg">*{translate key="LastName"}<br/>
				{textbox name="LAST_NAME" class="input" value="LastName" size="20"}
				</label>
			</p>
            
			<p>
				<label class="reg">*{translate key="FirstName"}<br/>
				{textbox name="FIRST_NAME" class="input" value="FirstName" size="20"}
				</label>
			</p>


			<p>
				<label class="reg">*{translate key="Email"}<br/>
				{textbox name="EMAIL" class="input" value="Email" size="20"}
				</label>
			</p>
            
            <!--自訂屬性移至這-->
            {if $Attributes|count > 0}
                <div id="registerAttributeFields">
                    <!--<div class="registrationHeader"><h3>{translate key=AdditionalAttributes}</h3></div>-->
                    {foreach from=$Attributes item=attribute}
                        <p class="customAttribute">
                            *{control type="AttributeControl" attribute=$attribute}
                        </p>
                    {/foreach}
                </div>
            {/if}
			
            <p style="font-size:16px;">我同意 青年創業圓夢網 <a href="https://sme.moeasmea.gov.tw/startup/modules/aboutus/useragreement.php" target="_blank" title="連結:服務條款">服務條款</a>和<a href="https://sme.moeasmea.gov.tw/startup/modules/aboutus/privacy.php" target="_blank" title="連結:隱私權">隱私權</a></p>
            
            <input type="hidden" name="timezone" value="Asia/Taipei"><!--系統時間預設台北但下拉選單停在上海，故改用隱藏預設-->
			<!--<p>
				<label class="reg">{translate key="Timezone"}<br/>
					<select {formname key='TIMEZONE'} class="input" id="timezoneDropDown">
					{html_options values=$TimezoneValues output=$TimezoneOutput selected=$Timezone}
					</select>
				</label>
			</p>-->

			<p style="display:none">
				<label class="reg">{translate key="Language"}<br/>
					<select {formname key='LANGUAGE'} class="input">
					{html_options values=$LanguageValues output=$LanguageOutput selected=$Language}
					</select>
				</label>
			</p>

		</div>

		<div id="registerAdditionalFields">
			<div class="registrationHeader"><h3>{translate key="AdditionalInformation"} ({translate key=Optional})</h3>
			</div>
			<p>
				<label class="reg">{translate key="Phone"}<br/>
				{textbox name="PHONE" class="input" value="Phone" size="20"}
				</label>
			</p>

			<p>
				<label class="reg">{translate key="Organization"}<br/>
				{textbox name="ORGANIZATION" class="input" value="Organization" size="20"}
				</label>
			</p>

			<p>
				<label class="reg">{translate key="Position"}<br/>
				{textbox name="POSITION" class="input" value="Position" size="20"}
				</label>
			</p>
		</div>
        
	<!--自訂屬性移到必填區域-->
	<!--{if $Attributes|count > 0}
		<div id="registerAttributeFields">
			<div class="registrationHeader"><h3>{translate key=AdditionalAttributes}</h3></div>
			{foreach from=$Attributes item=attribute}
				<p class="customAttribute">
					{control type="AttributeControl" attribute=$attribute}
				</p>
			{/foreach}
		</div>
	{/if}-->

	{if $EnableCaptcha}
		<div class="registrationHeader"><h3>{translate key=SecurityCode}</h3></div>
		<p>
			{control type="CaptchaControl"}
		</p>
		{else}
		<input type="hidden" {formname key=CAPTCHA} value=""/>
	{/if}

		<p class="regsubmit">
			<button type="button" name="{Actions::REGISTER}" value="{translate key='Register'}"
					class="button" id="btnUpdate">
				<img src="img/tick-circle.png"/> {translate key='Register'}
			</button>
		</p>
	</form>
</div>
{setfocus key='LOGIN'}

{jsfile src="js/jstz.min.js"}
{jsfile src="admin/edit.js"}
{jsfile src="js/jquery.form-3.09.min.js"}
{jsfile src="js/jquery.colorbox-min.js"}
{jsfile src="profile.js"}
{jsfile src="registration.js"}


<script type="text/javascript">
	$(document).ready(function () {
		var timezone = jstz.determine_timezone();
		$('#timezoneDropDown').val(timezone.name());

		var registrationPage = new Registration()
		registrationPage.init();
	});
</script>

<div id="modalDiv" style="display:none;text-align:center; top:15%;position:relative;">
	<h3>{translate key=Working}</h3>
{html_image src="reservation_submitting.gif"}
</div>

{include file='globalfooter.tpl'}