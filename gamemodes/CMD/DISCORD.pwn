forward DCC_DM(str[]);
public DCC_DM(str[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();
	DCC_SendChannelMessage(PM, str);
	return 1;
}
forward CheckDiscordUCP(DiscordID[], Nama_UCP[]);
public CheckDiscordUCP(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows();
	new DCC_Role: WARGA, DCC_Guild: guild, DCC_User: user;
	new verifycode = RandomEx(111111, 988888);
	if(rows > 0)
	{
		//cache_get_value_name(0, "ucp", ucp);
		new DCC_Channel:Info;
		Info = DCC_FindChannelById("1276775256073441290");
		new DCC_Embed:dc = DCC_CreateEmbed(.title="Levana Pride ROLEPLAY");
		new str1[526],str2[526];
		format(str1, sizeof str1, "**Information**");
		format(str2, sizeof str2, "**[UCP]:** %s Telah Terdaftar Coba Register Dengan Nama Lain.", Nama_UCP);
		DCC_AddEmbedField(dc, str1, str2, false);
		DCC_SetEmbedColor(dc, 0x00FFD5);
		new y, m, d, timestamp[200];
		getdate(y, m , d);
		format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
		DCC_SetEmbedTimestamp(dc, timestamp);
		DCC_SetEmbedFooter(dc, "ALL TEAM Levana Pride.");
		DCC_SendChannelEmbedMessage(Info, dc);
	}
	else 
	{
		//guild = DCC_FindGuildById("1088705294806306838");
		//WARGA = DCC_FindRoleById("973736821525708840");
		//user = DCC_FindUserById(DiscordID);
		//DCC_SetGuildMemberNickname(guild, user, Nama_UCP);
		//DCC_AddGuildMemberRole(guild, user, WARGA);

        new ns[32];
		//ch = DCC_FindChannelById("974133121308033084");
        guild = DCC_FindGuildById("1276773703530578004");
        WARGA = DCC_FindRoleById("1276775150423113729");
        user = DCC_FindUserById(DiscordID);
        format(ns, sizeof(ns), "Warga | %s ", Nama_UCP);
        DCC_SetGuildMemberNickname(guild, user, ns);
        DCC_AddGuildMemberRole(guild, user, WARGA);

		new DCC_Channel:Info;
		Info = DCC_FindChannelById("1276775256073441290");
		new DCC_Embed:dc = DCC_CreateEmbed(.title="Levana Pride ROLEPLAY", .image_url="https://cdn.discordapp.com/attachments/1311311719267827752/1313394543508455445/20241122_222334.png?ex=674ff97c&is=674ea7fc&hm=f526a3dd0deda99c4569e087ab6183b5d13ca97551843a8cf6bc6c08a6e628bf&");
		new str1[526],str2[526];
		format(str1, sizeof str1, "**Information**");
		format(str2, sizeof str2, "**[UCP]:** __%s__ Selamat UCP kamu telah terdaftar di Levana Pride Roleplay.", Nama_UCP);
		DCC_AddEmbedField(dc, str1, str2, false);
		DCC_SetEmbedColor(dc, 0x00FFD5);
		new y, m, d, timestamp[200];
		getdate(y, m , d);
		format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
		DCC_SetEmbedTimestamp(dc, timestamp);
		DCC_SetEmbedFooter(dc, "Levana Pride.");
		DCC_SendChannelEmbedMessage(Info, dc);

		DCC_CreatePrivateChannel(user, "DCC_DM_EMBED", "sds", Nama_UCP, verifycode, DiscordID);
	}
	return 1;
}
forward DCC_DM_EMBED(str[], pin, id[]);
public DCC_DM_EMBED(str[], pin, id[])
{

    new DCC_Channel:PM, query[200];
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="Levana Pride", .image_url="https://cdn.discordapp.com/attachments/1311311719267827752/1313394543508455445/20241122_222334.png?ex=674ff97c&is=674ea7fc&hm=f526a3dd0deda99c4569e087ab6183b5d13ca97551843a8cf6bc6c08a6e628bf&");
	new str1[100], str2[100];

	format(str1, sizeof str1, "```\nHalo!\nUCP kamu berhasil terverifikasi,\nGunakan PIN dibawah ini untuk login ke Game```");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP");
	format(str2, sizeof str2, "\n```%s```", str);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "PIN");
	format(str2, sizeof str2, "\n```%d```", pin);
	DCC_AddEmbedField(embed, str1, str2, bool:1);

	DCC_SendChannelEmbedMessage(PM, embed);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `playerucp` (`ucp`, `verifycode`, `DiscordID`) VALUES ('%e', '%d', '%e')", str, pin, id);
	mysql_tquery(g_SQL, query);
	return 1;
}
forward CheckDiscordID(DiscordID[], Nama_UCP[]);
public CheckDiscordID(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows(), ucp[20];
	if(rows > 0)
	{
		cache_get_value_name(0, "ucp", ucp);
		new DCC_Channel:Info;
		Info = DCC_FindChannelById("1276775256073441290");
		new DCC_Embed:dc = DCC_CreateEmbed(.title="Levana Pride ROLEPLAY", .image_url="https://cdn.discordapp.com/attachments/1311311719267827752/1313394543508455445/20241122_222334.png?ex=674ff97c&is=674ea7fc&hm=f526a3dd0deda99c4569e087ab6183b5d13ca97551843a8cf6bc6c08a6e628bf&");
		new str1[526],str2[526];
		format(str1, sizeof str1, "**Information**");
		format(str2, sizeof str2, "**[INFO]:** Kamu sudah mendaftar UCP sebelumnya dengan nama **%s**\nGunakan !reucp [UCP] Untuk Mendapatkan Role", ucp);
		DCC_AddEmbedField(dc, str1, str2, false);
		DCC_SetEmbedColor(dc, 0x00FFD5);
		new y, m, d, timestamp[200];
		getdate(y, m , d);
		format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
		DCC_SetEmbedTimestamp(dc, timestamp);
		DCC_SetEmbedFooter(dc, "Levana Pride.");
		DCC_SendChannelEmbedMessage(Info, dc);

	}
	else 
	{
		new characterQuery[178];
		mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `ucp` = '%s'", Nama_UCP);
		mysql_tquery(g_SQL, characterQuery, "CheckDiscordUCP", "ss", DiscordID, Nama_UCP);
	}
	return 1;
}
function CheckReverify(DiscordID[])
{
	new DCC_Role: WARGA, DCC_Guild: guild, DCC_User: user;
	new rows = cache_num_rows(), Nama_UCP[20], PIN;
	if(rows > 0)
	{
		// ketika player ada di database !
		cache_get_value_name(0, "ucp", Nama_UCP);
		cache_get_value_name_int(0, "verifycode", PIN);

		//ch = DCC_FindChannelById("974133121308033084");
		//guild = DCC_FindGuildById("1088705294806306838");
		//WARGA = DCC_FindRoleById("973736821525708840");
		//user = DCC_FindUserById(DiscordID);
		//DCC_SetGuildMemberNickname(guild, user, Nama_UCP);
		//DCC_AddGuildMemberRole(guild, user, WARGA);

        new ns[32];
		//ch = DCC_FindChannelById("974133121308033084");
        guild = DCC_FindGuildById("1276773703530578004");
        WARGA = DCC_FindRoleById("1276775150423113729");
        user = DCC_FindUserById(DiscordID);
        format(ns, sizeof(ns), "Warga | %s ", Nama_UCP);
        DCC_SetGuildMemberNickname(guild, user, ns);
        DCC_AddGuildMemberRole(guild, user, WARGA);

		new DCC_Channel:Info;
		Info = DCC_FindChannelById("1276775256073441290");
		new str[5260], string[5260];
		new DCC_Embed:dc;
		format(str, sizeof(str), "**[UCP]:** __%s__ Selamat UCP kamu telah reverif akun anda .", Nama_UCP);
		dc = DCC_CreateEmbed("BOT PANEL","**Information**","","",0x00ffff,"Levana Pride","","","");
		DCC_AddEmbedField(dc, str, string, true);
		DCC_SendChannelEmbedMessage(Info, dc);
		DCC_CreatePrivateChannel(user, "Embed_Reverify", "sds", Nama_UCP, PIN, DiscordID);
	}
	else 
	{
		new DCC_Channel:Info;
		Info = DCC_FindChannelById("1276775256073441290");
		new str[5260], string[5260];
		new DCC_Embed:dc;
		format(str, sizeof(str), "**[UCP]:** Akun anda belum terdaftar .");
		dc = DCC_CreateEmbed("BOT PANEL","**Information**","","",0x00ffff,"Levana Pride","","","");
		DCC_AddEmbedField(dc, str, string, true);
		DCC_SendChannelEmbedMessage(Info, dc);
	}
	return 1;
}

function Embed_Reverify(str[], pin, id[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="Levana Pride ROLEPLAY", .image_url="https://cdn.discordapp.com/attachments/1311311719267827752/1313394543508455445/20241122_222334.png?ex=674ff97c&is=674ea7fc&hm=f526a3dd0deda99c4569e087ab6183b5d13ca97551843a8cf6bc6c08a6e628bf&");
	new str1[100], str2[100];

	format(str1, sizeof str1, "```\nHalo!\nKamu berhasil reverif Akun,\nGunakan PIN dibawah ini jika kamu dimintai pin saat login```");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP");
	format(str2, sizeof str2, "\n```%s```", str);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "PIN");
	format(str2, sizeof str2, "\n```%d```", pin);
	DCC_AddEmbedField(embed, str1, str2, bool:1);

	DCC_SendChannelEmbedMessage(PM, embed);
	return 1;
}
DCMD:reucp(user, channel, params[])
{
	new id[21];
    if(channel != DCC_FindChannelById("1276775256073441290"))
		return 1;
    if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**USAGE**: !reucp NamaUCP");
	if(!IsValidNameUCP(params))
		return DCC_SendChannelMessage(channel, "`gunakan nama UCP bukan nama IC!`");
	

	DCC_GetUserId(user, id, sizeof id);

	// Pengecekan id discord apakah ada di dalam database
	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `DiscordID` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckReverify", "ss", id, params);
	return 1;
}
DCMD:ucp(user, channel, params[])
{
	new id[21];
    if(channel != DCC_FindChannelById("1276775256073441290"))
		return 1;
    if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**[CONTOH]:** **__!UCP__ [NAME UCP]**");
	if(!IsValidNameUCP(params))
		return DCC_SendChannelMessage(channel, "**Gunakan nama UCP bukan nama IC!**");
	
	DCC_GetUserId(user, id, sizeof id);

	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `DiscordID` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckDiscordID", "ss", id, params);
	return 1;
}
