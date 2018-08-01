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
<div id="reservationCreated" class="reservationResponseMessage">
	{if $RequiresApproval}
		{html_image src="dialog-warning.png" id="imgApprovalWarning"}
	{else}
		{html_image src="dialog-success.png" id="imgReservationSuccess"}
	{/if}
	<br/>
	<div class="createdMessage">{translate key=ReservationCreated}</div>
	<!--<div class="referenceNumber">{translate key=YourReferenceNumber args=$ReferenceNumber}</div>-->
	
	<div class="dates">
		{foreach from=$Instances item=instance name=date_list}
			<span class="date">{format_date date=$instance->StartDate() timezone=$Timezone}{if !$smarty.foreach.date_list.last}, {/if}</span>
		{/foreach}
	</div>

	<div class="resources">
		{translate key=Resources}:
		{foreach from=$Resources item=resource name=resource_list}
			<span class="resource">{$resource->GetName()}{if !$smarty.foreach.resource_list.last}, {/if}</span>
		{/foreach}
	</div>

	{if $RequiresApproval}
		<!--<div class="approvalMessage">{translate key=ReservationRequiresApproval}</div>-->
	{/if}
	<!--<p><img src="../Web/img/payment.png"><br><span style="font-size:18px;">{translate key="Payment"} QR Code</span></p><br>-->
    <div class="referenceNumber" style="font-size:18px; letter-spacing:1px; line-height:150%;">
		場地使用切結書請以Email方式處理或直接活動前十分鐘到辦公室簽名<br><span style="color:red;">(*<strong>如借用場地人未到場，則停權一個月</strong>)</span>
    </div>
    <div class="referenceNumber" style="font-size:18px; letter-spacing:1px; line-height:150%;">若有任何疑問，請洽營運服務中心<br>電話：(02)6631-5055；<br>服務信箱:socialinnovationlab1018@gmail.com</div>
	<br><input type="button" id="btnSaveSuccessful" value="{translate key='Close'}" class="button" />

</div>