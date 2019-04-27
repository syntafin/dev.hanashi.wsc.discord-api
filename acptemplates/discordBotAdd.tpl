{include file='header' pageTitle='wcf.acp.menu.link.configuration.discord.discordBotList.'|concat:$action}

<header class="contentHeader">
	<div class="contentHeaderTitle">
		<h1 class="contentTitle">{lang}wcf.acp.menu.link.configuration.discord.discordBotList.{$action}{/lang}</h1>
	</div>

    <nav class="contentHeaderNavigation">
		<ul>
			<li><a href="{link controller='DiscordBotList'}{/link}" class="button"><span class="icon icon16 fa-list"></span> <span>{lang}wcf.acp.menu.link.configuration.discord.discordBotList{/lang}</span></a></li>
			{event name='contentHeaderNavigation'}
		</ul>
	</nav>
</header>

{include file='formError'}

{if $success|isset}
	<p class="success">{lang}wcf.global.success.{$action}{/lang}</p>
{/if}

<form method="post" action="{if $action == 'add'}{link controller='DiscordBotAdd'}{/link}{else}{link controller='DiscordBotEdit' id=$discordBotID}{/link}{/if}">
	<section class="section">
        <h2 class="sectionTitle">Bot-Einstellungen</h2>
		<dl{if $errorField == 'botName'} class="formError"{/if}>
			<dt><label for="botName">Bot-Name</label></dt>
			<dd>
				<input type="text" name="botName" id="botName" value="{$botName}" class="long" required>
				{if $errorField == 'botName'}
					<small class="innerError">
						{if $errorType == 'empty'}
							{lang}wcf.global.form.error.empty{/lang}
						{else if $errorType == 'tooLong'}
							Der eingegebene Bot-Name ist zu lang. Die maximale Länge beträgt 50 Zeichen.
						{/if}
					</small>
				{/if}
                <small>Wählen Sie einen Anzeigenamen für diesen Bot aus. Dies dient lediglich dazu die Bots im ACP auseinanderhalten zu können.</small>
			</dd>
		</dl>
		<dl{if $errorField == 'botToken'} class="formError"{/if}>
			<dt><label for="botToken">Bot-Token</label></dt>
			<dd>
				<input type="password" name="botToken" id="botToken" value="{$botToken}" class="long" required>
				{if $errorField == 'botToken'}
					<small class="innerError">
						{if $errorType == 'empty'}
							{lang}wcf.global.form.error.empty{/lang}
						{/if}
					</small>
				{/if}
			</dd>
		</dl>
		<dl{if $errorField == 'guildID'} class="formError"{/if}>
			<dt><label for="guildID">Server-ID</label></dt>
			<dd>
				<input type="number" name="guildID" id="guildID" value="{$guildID}" class="long" required>
				{if $errorField == 'guildID'}
					<small class="innerError">
						{if $errorType == 'empty'}
							{lang}wcf.global.form.error.empty{/lang}
						{else if $errorType == 'invalid'}
							Die eingetrage Server-ID ist ungültig.
						{/if}
					</small>
				{/if}
                <small>Geben Sie die ID Ihres Discord-Servers ein. Diese wird für einige Funktionen verschiedener Plugins benötigt.</small>
			</dd>
		</dl>
		<dl{if $errorField == 'webhookName'} class="formError"{/if}>
			<dt><label for="webhookName">Webhook-Name</label></dt>
			<dd>
				<input type="text" name="webhookName" id="webhookName" value="{$webhookName}" class="long" required>
				{if $errorField == 'webhookName'}
					<small class="innerError">
						{if $errorType == 'empty'}
							{lang}wcf.global.form.error.empty{/lang}
						{else if $errorType == 'tooLong'}
							Der eingegebene Webhook-Name ist zu lang. Die maximale Länge beträgt 50 Zeichen.
						{/if}
					</small>
				{/if}
                <small>Wenn durch diesen Bot ein Webhook erstellt wird, wird der Webhook automatisch den hier eingestellten Namen erhalten.</small>
			</dd>
		</dl>

        {event name='generalSettings'}
    </section>

    <section class="section">
        <h2 class="sectionTitle">OAuth2-Einstellungen</h2>
        
		<dl{if $errorField == 'clientID'} class="formError"{/if}>
			<dt><label for="clientID">Client-ID</label></dt>
			<dd>
				<input type="number" name="clientID" id="clientID" value="{$clientID}" class="long">
				{if $errorField == 'clientID'}
					<small class="innerError">
						{if $errorType == 'empty'}
							{lang}wcf.global.form.error.empty{/lang}
						{else if $errorType == 'invalid'}
							Die eingetrage Client-ID ist ungültig.
						{/if}
					</small>
				{/if}
                <small>Geben Sie die Client-ID Ihrer Anwendung ein um diese für OAuth2-Funktionen zu nutzen.</small>
			</dd>
		</dl>
		<dl{if $errorField == 'clientSecret'} class="formError"{/if}>
			<dt><label for="clientSecret">Client-Secret</label></dt>
			<dd>
				<input type="password" name="clientSecret" id="clientSecret" value="{$clientSecret}" class="long">
				{if $errorField == 'clientSecret'}
					<small class="innerError">
						{if $errorType == 'empty'}
							{lang}wcf.global.form.error.empty{/lang}
						{/if}
					</small>
				{/if}
			</dd>
		</dl>

        {event name='oauth2Settings'}
    </section>

    {event name='moreSections'}

    <div class="formSubmit">
		<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s">
		{@SECURITY_TOKEN_INPUT_TAG}
	</div>
</form>

{include file='footer'}