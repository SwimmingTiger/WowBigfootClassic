local LoaderFrame = CreateFrame("FRAME")
LoaderFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

local function IsAddOnLoadable(name)
    return GetAddOnEnableState(nil, name) == 2
end

local CombuctorPatchVersion = '2019-12-12-13'
local function isCombuctorNeedReset()
    return type(Combuctor_Sets) == 'table' and Combuctor_Sets.CombuctorPatchVersion ~= CombuctorPatchVersion
end
local function resetCombuctor()
    Combuctor_Sets = {
        CombuctorPatchVersion = CombuctorPatchVersion
    }
end
-- 防止首次使用时弹出“背包整合插件已更新”
if Combuctor_Sets == nil and CombuctorAutoDisplay then
    resetCombuctor()
end

-- 全局函数，被 BigFoot/Config/RaidToolkit.lua 使用
function zzzAddonCheck_Init_Decursive()
    -- 禁止Decursive在聊天窗口和屏幕中央显示信息
    local patchVersion = '2020-05-12-18'
    if DecursiveDB and DecursiveDB.profiles and DecursiveDB.profiles.Default and DecursiveDB.profiles.Default.DecursivePatchVersion ~= patchVersion then
        DecursiveDB.profiles.Default.Print_ChatFrame = false
        DecursiveDB.profiles.Default.Print_CustomFrame = false
        DecursiveDB.profiles.Default.Print_Error = false
        DecursiveDB.profiles.Default.DecursivePatchVersion = patchVersion
    end
end

local function zzzAddonCheck_Init_DBM()
    -- 为DBM选择夏一可语音包
    local patchVersion = '2020-06-27-11'
    if DBM and DBM.Options and DBM.Options.DBMPatchVersion ~= patchVersion then
        DBM.Options.ChosenVoicePack = 'Yike'
        DBM.Options.CountdownVoice = 'VP:Yike'
        DBM.Options.CountdownVoice2 = 'VP:Yike'
        DBM.Options.CountdownVoice3 = 'VP:Yike'
        DBM.Options.DBMPatchVersion = patchVersion
    end
end

local function zzzAddonCheck_Init_ClassicCastbars()
    -- 禁用 ClassicCastbars 的姓名板施法条
    local patchVersion = '2020-06-27-14'
    if ClassicCastbars and ClassicCastbars.db and ClassicCastbars.db.nameplate and
       ClassicCastbars.db.nameplate.castbarPatchVersion ~= patchVersion
    then
        ClassicCastbars.db.nameplate.enabled = false
        ClassicCastbars.db.nameplate.castbarPatchVersion = patchVersion
    end
end

local function zzzAddonCheck_Init_NeatPlates()
    -- 姓名板：打开目标高亮和友方施法条，禁用仇恨指示器
    local patchVersion = '2020-06-27-15'
    if NeatPlatesOptions and NeatPlatesOptions.FirstSpecProfile and
       NeatPlatesHubSettings and NeatPlatesHubSettings['HubPanelProfile'..NeatPlatesOptions.FirstSpecProfile] and
       NeatPlatesHubSettings['HubPanelProfile'..NeatPlatesOptions.FirstSpecProfile].neatplatesPatchVersion ~= patchVersion
    then
        local db = NeatPlatesHubSettings['HubPanelProfile'..NeatPlatesOptions.FirstSpecProfile]
        db.HighlightTargetMode = 3
        db.SpellCastEnableFriendly = true
        db.WidgetThreatIndicator = false
        db.neatplatesPatchVersion = patchVersion
    end
end

local function zzzAddonCheck_Init_NovaWorldBuffs()
    -- 重新打开公会频道世界Buff信息发送
    local patchVersion = '2020-07-29-22'
    if NWB and NWB.db and NWB.db.global and NWB.db.global.nwbPatchVersion ~= patchVersion then
        NWB.db.global.disableAllGuildMsgs = 0
        NWB.db.global.filterDrops = false
        NWB.db.global.filterNpcKilled = false
        NWB.db.global.filterSongflowers = false
        NWB.db.global.filterTimers = false
        NWB.db.global.filterYells = false
        NWB.db.global.nwbPatchVersion = patchVersion
    end
end

local function zzzAddonCheck_Init_MonkeyQuest()
    -- 设置MonkeyQuest初始样式
    local patchVersion = '2020-07-29-22'
    if not MonkeyQuestConfig then
        return
    end
    if MonkeyQuestConfig.mqPatchVersion == patchVersion then
        return
    end
    if MonkeyBuddySlash_CmdDismiss then
        MonkeyBuddySlash_CmdDismiss()
    end
    if MonkeyQuestInit_ResetConfig then
        BigFoot_DelayCall(MonkeyQuestInit_ResetConfig, 1)
    end
    MonkeyQuestConfig.mqPatchVersion = patchVersion
end

local function zzzAddonCheck_Init_alaGearMan()
    -- 为有爱一键换装添加功能函数
    if not __ala_meta__ then return end
    local func = __ala_meta__.gear.func
    local ui = __ala_meta__.gear.ui

    -- 启用/禁用快捷栏
    function func.toggle_quick_panel(show)
        if show == nil then
            show = not ui.secure:IsShown()
        end
        if show then
            ui.secure:Show();
        else
            ui.secure:Hide();
        end
    end

    -- 打开/关闭套装配置
    function func.toggle_gear_win(show)
        if show == nil then
            show = not ui.gearWin:IsShown()
        end
        if show then
            ui.gearWin:Show()
        else
            ui.gearWin:Hide();
        end
    end
end

local function LoaderEvents(frame, event, arg1)
    frame:UnregisterEvent("PLAYER_ENTERING_WORLD")

    -- 禁止Decursive在聊天窗口和屏幕中央显示信息
    zzzAddonCheck_Init_Decursive()

    -- 为DBM选择夏一可语音包
    zzzAddonCheck_Init_DBM()

    -- 禁用 ClassicCastbars 的姓名板施法条
    zzzAddonCheck_Init_ClassicCastbars()

    -- 姓名板：打开目标高亮和友方施法条，禁用仇恨指示器
    zzzAddonCheck_Init_NeatPlates()

    -- 重新打开公会频道世界Buff信息发送
    zzzAddonCheck_Init_NovaWorldBuffs()

    -- 设置MonkeyQuest初始样式
    zzzAddonCheck_Init_MonkeyQuest()

    -- 为有爱一键换装添加功能函数
    zzzAddonCheck_Init_alaGearMan()

    -- 禁用DBM的过期提示
    if DBM and DBM.Options and not DBM.Options.DontShowReminders then
        DBM.Options.DontShowReminders = true
    end

    -- 禁止Details弹出天赋面板
    if Details and not Details.disable_talent_feature then
        Details.disable_talent_feature = true
    end

    -- 默认禁用RealMobHealth的血量共享，避免发送太多消息导致聊天窗口提示刷屏
	local patchVersion = '2019-12-17-23'
	if (type(RealMobHealth_Options) == 'table' and BF_Frames_Config.RealMobHealthPatchVersion ~= patchVersion) then
		RealMobHealth_Options.EnablePeerCache = false
		BF_Frames_Config.RealMobHealthPatchVersion = patchVersion
	end

	-- 防止背包内物品意外保存到银行
	local patchVersion = '2019-12-18-02'
	if (TDPack2Command and TDPack2Command.db and TDPack2Command.db.profile and TDPack2Command.db.profile.TDPack2PatchVersion ~= patchVersion) then
		TDPack2Command.db.profile.saving = false
		TDPack2Command.db.profile.TDPack2PatchVersion = patchVersion
	end

	-- 为Details添加默认配置文件
	local profileName = '默认-2020-01-02'
	if (Details and not Details:GetProfile(profileName)) then
		local profile = [[
vZv3pUows9)w4beZinDJTJJDcR4HKBNCV9C7oDtC37DhPwXT)4KeR2XoRTt33EqtEbecXdi4f0(csi0(ccjaTl8Ykq8pd3zx(VGQQZh(yNp6EgbdG092j2(8rDQQov9RQt5mZC2nZ8wxKppjLHFTCz(t(bfSSa)I8uMFsuE2SWzErbRR2uW8lybPy7wIFoeA)AwAAuqzfEXQKYO4GQa87bBkOpzzSIfpJFloyvWcg8TQzEfWSmpigg)my0MyoZd(YeRztmo1cFEzfmrRyf(W0ppzboJZHjbUXM1WmWkrA6NUjj6b)ywflQkHtMfSswLpqur(rbrlz49YY9dszfvuFItkdcH11QNRwMe5hVjBbJ31nLm)GSKvb4y5hefXs50AqAQ)60GNzfLiNXFrr(M1YEGlevVkXLzbBDErLpYG8ttYEOKtxRYFKZ9w5pViFLFgS848mO3Bw5dpUaNPO8vHbv(vjWJNyAamWhzzW1fbrpWkqgbiBGvqmoSZZHhfLNMxW5I4)SO)2H(Rn(xyja0bdOOKflRG74iUHEhno1uW)5DM(0g)Sdoa0evUmio)PzEtUAYi5Ts(AbzsxopiInZBCrYxV9()GnbXfGYW27VbLEf46vQGvLuLsREqoJ6lExC1hM5fclX4I81TjmhjL5ijnhbTz7sRUCG1q8d5sSJbqrpLexTe6AxdflOI9rulEM3zSQGK0YT37XaD9KQNN5LVMeH(skTI0t5cZQC)NwMpZd2hKguwskyLazMxexI0PJLIAT6A2VBhtRUcIUJBxjvJ3ZM3gySN40r1jQruZpuJXvHO1sUHLOTI2zkBOznNtrfhQT60DBcUDBRj3EcY1C)n0(qu6EwvDpcXUlhZ5yTw1yCfqdURQ5Yg7CKw3t1ANow9QNa3d3L(QUOeG9oCZDmoehCN22119isMtLT2rWg10)2dJH6NnVF4y3Z8ikE7m02hPXTgzlNUhHJVtJRLMo7YS3P1UhJxVtR7DSXEh1qN(huYStBDnogH0U5AT(WwgAl9nnSomtV5UnxZds5T4jMgDoSWP1GADWDWTupmnSpcJU1O25ykPTgyn1UD1KAZKnn6EezstQOwfDN12U7VDoIU)UBVnp4iVJ6zNJT7UzRRu4Z8ldameRZjygv55PvjRfyXIbKrLvbvBkddQ9C2ro0YbwmS9aJaG7Yjo4FCN59H8I0ypO7mWHyuo4Gu4YNCe7xqov1byaSznE7EGy4Qiq)vbF0VkOybdaGb91druYXnaK(h4T9D0hvn70AzpcYIwIKblfqz9idB1A4UHHfShtiGxAnJfdERjeLCOSRY3KvXXgqCjecWEGmzCAFtxN2lkKhudXbXNGG)YIRvK7RaN0xHoPVJIpJqz3eUILTX)jaD36G1agUH1dSajKcb1RalhaqCvqgH7OfdlimjnPkbahdswA4omESqa6cbVwdPfFL0MhiA5UqNggumKE2277Oes5ZNdiWBnIWOGSGs)Wf1JZ5zaCEKaVZ76rxCXWRU6935HrteMN)WjxdHkCcieH1vYkKrTIvTmpMeScksiySfCto40qfLugvWyz02fo101WfvBbk6KoD57TKTDDEsgTuRQYxPrS1i8mNnUB3Eg2DT60ZYONvhB7zZpbG6aJ34EDSaxFww296bc)og4tO9CJDDCTn7yB662PRJz)o4tOn3J7Aa4bmDT723WQth3(8rRsS)OMPtKaUvzkPKAzI218UaVWWLqP4DJ(fd1AwvJLIoM6EsJKcD2Es7PcdoqKon2Ebc4NqJeYWtskXiskxsHbrrKHyIzs5t(dRckEGVxtiMmrMTm6kQT(qOpWG8ieNfcLhODkih)Kk2k)u2Ju8xak(mqUwE0OftYaBFzrSsFANwukgxiGzpFnJcTtfBvklOWpJ9u0s4sge6hfA7MIcmeR41y)R(EhKfpQzzhh(Ibn1dKonIcvVVLbRwJw8PM297v4vHVQWR2ztVGNUBqvGNtvmvw0MAHKpb3j)yqk3fZ(dKctlaX)Z2S2pnFr(gYOCTKtgyo4)YFjmHP0KgskfLlX8aebZvg8FsMroMcFwKQIkwWkkPdn1WGvvN6q(XCkufTKh(nA3eDvQLsaCf7dscm8E)WnGPGmk29vqS7fp7dRgcwIQ9CntE6akBUyk3SEDbRuUjb4SEya9(vpVM5Nd(ttYq2LvnZIpyKemkG8iWnp1AhtWhL7yWfgBEWM0kC3Dq66LbCed1Zenbkfh0mg3CWEvHqzelOAPV0JIqudMkL0bdTPMNMscaARKGBXvzvlFUQfmB(cRVEz5fR45n6zWMOPTPPzhlxBdBJowO1sCZ)hNn(KUwMogUUDHODTSDbq8WJqtpZgB7cgE7y010Tp8fBQtGSyjyifUTzV(9bRS9SSnedh64f0r4tjYh(iz34jrUbqDyddUQjTLPg8eT4adivlHL2ILsjtiN55Z9yiTei8(ddssmXVrVil8lMn2bSh3RVPLby4VVtph0(o4vEj0oFq5hCukSLQPol05oQvgHIlLyoFkRDAEshehFvw5Dcx03LGjCR8o9UuI2bkanumTgXjfIuNH8gneLz6yj6GxZYyRexHSSNsWDsOnvmlHLGja9vJo7tm585U9dlal70oNfGgc4JNYTcioqUeE)1PBGTkL4ESNArTKWGpQe)AiYUgI03qKzneTAoKdX1RCnA4CYjwOWwatG03lbHoSda3zbdh1uszaMEKlH3qSlxTRKlbP0IoSwAWf)MKWFXbf(Wddp4df8umVHGN)Mm0Ad2aUHEoGMUnaFW1fdgL6nIc5apPZbFcIcX1Xg2X1Pp8yyZNnh5ckHFaCX6DjMCYG0KYQKi0usAAoWpw0YbjYaoS)ruND)yURBrvRLpoQE0osaKPhyWJqajSvIF9Sr3m48l889UzWn36nCWu)RV423E(e)Rp7ApSb4u(Mx2Nn2SFYLiUsd(fJjxSdIIabAwvq627VgmKJxe9mVfEvpNYnTIxna8tLP6TNkwb8QV6soG1QJrVdU5MPNp82BgHuDs57sIJ5Gw2DUKJNxjBbOVwDJ0g)3JvXXO7xMVDSv0BU4Q38(VlIaWDfFLyQVsC2hD(Dv6Ci5bMzxcFXlOi5LYM)kLEErm0m8lYy0GRkm430LYjwUc(e3vc3Z(yhhl3E9H4pm77cXFyYdKa8WwJtJ7EIAEZ9N5zGZ6h5myULwPXnY(jyddnLLNXxa8zMBLltDCesbKpehBjbSwGtvhHzdB7jz8(cZoD8p((LzbR5rTQGIUBuLVLhGDBcqcWbn5ccEFEAoATkFg7a)4zgYxC6ohp)nxnX7UZN8J9bUqsQ)natpzvdRR7ZW0IIGqFqkHjDieZZrynwnanZj29721The5NdyyhmRxdNPNB)E9C6zA42hSTArOzaq)IGnV5QRVy04wa(uWqGvYCc9Iq(VFd1uKnPbp)F7(gQ4sPI966fVdp5ks4PeHMHmZXqyA6wQRKot8J2usbxlg3KmG0ReAUjaUsmca8y2k9LyPK(e4hCylFIINbBKEO5d0qP5dIPSMq1oH8UfSbIoue3hQQaKsPmo3GQQIeyNj)0I0vYgQbFWt5XxpixlmAsCzY7R3FiEkFFJOnZpQXRMgbm5bO3rHpfTswSlsNkj15RpVHVOlxnd5O0uQSH9AkcpfZMhh5el6vIYKAkzqXxa3NgUl0hoX2DTa80gwiOewwC5ymSX7U98texFbG(4K3v3bonsmf6SM3hpznRiIo1uPzR5jFetm4lHdrGu8gP7b0Ed5ca)siR6jgltd5aUuQtkOp)Sb5JFyRvVF5k(P7(I5BtfWMGVpgtU1DdM((Ge)BoTQAET5ZwwapAk6SoMHo1KR0JRAMRcN60ayzwV4FDAgddYQYbsPUFcL12Dh28MhZsjeEqe0WwE6AaliMxqGjaBDgwqrPcpNv8wmdFNEPfMTINQBnLo77g9tUEWeVZVAIH1DND1vNn4mV7a4iXbffb39MRU4SbtNoaCjFR3PRSKZNEC08XuJ)YVHQjMYov3ez67ED8fsFbZwaQAi6j4T5zUdbLgutlkOoV53C627PV15BOpS(gE1iuVhuF3wTLxLgsTiPENb10dQFwjjhANx2MvH8mzZV5Hnc1AhGSlt37YA79FMy98fQf4V9N3Mi13YDS9tJ7ABA1TB3ooUyUd64WbnPSHCyIU1S86eNGBnB)cg6lHPKD1MeirIq5XCFtJ2(2Z(DsIQ2ScyhIX7ZvCTwdydl2VEJmz5Qk7Hu7ouA73ZWRYSPWF20T3)MINbGlPFD0gWiXBh(EybWwLecB20uc1jCc4yqbaRBowtpYOPXs8XFDPOgFQxELS1bamtyr59fY7fsfedqIF2UWvPuhKxMefK))9Z(u7uPWzjpLSMPbZrabIsiH6CK2X6V8ScQfInRqd6i2Aaz8G5YMJgXJmmjS8pUNbYzaKUU9SDS6JBNSDu60KntEsdhB33Tx3(M9CnrOVg2C(LOUUW1JiYhfikn0C02eeFgjtP8YCJWlCO0VmzPTfQrrGqd1tne391yxNUoMM972ZecIYYOVmlh1f4dQExsjAF9JR9dkRJIqK9xiQggy5lnMWiYZoYhY)W27vwf4C2cKOPIIljUKVvbGI4haONFmP6zchNpmh4J4Bjeek3hW3rxgGzywbOMN6xc7azRiDnETQH1fh2Z9Lzzb9pk9XBpNN(gLJbVhEMaRvvxzAnQiTUYeYtIiEzTXxl5BaZX8QeSUA)aj6dSmF0igEuhzliDAklYYu0BPH0qlh1yu74PDUeNAicmg4WjULk)Zs7wi8SpQFb2dQc78qmnzluPRxM5VG408f(uT1Hj10AphsuyEPiJL5OR1LjS0yXn4MYeNnO37UDYnJM26W)3TQciZcFaqDC(vhQX6v1GN37gC5Gj7wOa29Dm6VNIhH60LdE7OxQlnMLRhDZlofI6rGNjRP3E(z1vBHn)KgfhHEVEIcNANP5YRM8(DQOdWTSw7vLac)KlpB0GBE37NC(BF3EiW93LrtgD5xDi5G(I42jVFYvFyx6zFT96PNpYRMeQznwnya7rwC7K3o9QBV(6lg8v1QhhFYga2nWud96Mo9EckwIeV9YsMw05zJaPttLyPOXPrff1KB)omYIx381GFo4IbND(KdjMAohtV6T3o6vXmART5DKTKAKtL0cTMXy9dfeSiO8WuFsqsBfZtdwWJoQTLy4JvaaOsUVmvkBlffKcE60L8CY1JWcLbXLe7t2LvNUgelW6LjrO10L5vr5fzyjbKVM8fEdh0d3Ew7ZjScCtcWfKNvy36ZzKF6MS4ekVhHf5bXr8cRwZUkz5NYvNxEg)00FISdNhZlTMIG4eYgTJHImK9668s(belY6bc(QI8AsxldjVXX2lQshKqXczrEMlIIesg5PD36Q61UNb3qU6iq5OEXkHOVTPiDGOZ85fblAisBIbHEcl7z)Yi6iOyLLONwYpLsMH(6ajEj37zdOS7y))uhxzXviR7k79z6)uxzry4i3Fz3PToVQ4KKfxKT5ow5TnBvmh9jOwdMoAYa)VA0fxOS0z2UMtpOrkBPJa50220VPYtHOfg2TnZ300r)dzt31vvUCscRZogZH1KPPRESmNAiRZQ9zr3svEiIHChl57K6Nw2LovvzxDvMn602HzNwSPU7ZsCxPCURKz42)qMDDSvLtwJ2QsqjO(nz0T3mDWf7tMUlSbjbkPWEU16gVD6OrtAjYn1e4vABbwdMyIOeSuFOOIIYblLdEv5GFtRSCeBJHTlRwltSzpnzOfpGJtmTB8kHCWXRjcT6IibWQDitgMaZxAYOdhrjLNevDmiW)xgTKTIhyo(CaVBvkte9FjRaMyGdaXHZt5bDce7u)Hs7l83bfnRlyPVawAFqufDeM0MUd4UbQThcHNxFodH14vttwLiEdo0k2e5yPIacp1I08WGZ45hvuyhfSiUnD(zCl6fo8nsWn8S0K5qqk8COYzsPShPtSIheaPdb(ef1kf(wTqX1GvqLMBKg3Vod5nUTiyfrE1hU)NEOXu2z1q3iOJdmJhklOAzhPr7vjMhdL3GcLxvVhU8sBsFsvlKg3(fhK9TUEfuAJj576ktmnF3wGhu(kx44SSbjgcCOxU4e5Ga5W6TZB7xEYjBVhIfSC79yB2Ep0A47pTKLH3hUbNU2EpDEKBVph(pDaMBVpy798aZXH9RZZy8rnwoS7zq4TaMaS5FrZz(PK0uA(PXdGVujhi(ZRYPNkhxrS4)wBVhBAsqkgXkmKR3uT9(LScMACbuBlbchGGOnj4nIy6R)G0Y8gnOsJ(518nmxLYfr82Ve7nQxdJ1CrdPn3ahkFbsWuj8GeO4PNHpfgbbi2T3)zcitBVVtxJpF7xkwuNUNI)A79)(uR(r85LZeWrMk6oUGr3s5xGeJKfvceFwfYa452HZnL5bbUcuCaQzrokBWKGYBar05PXq3yvvqK7ixJl)HlOzqq(vfByA0)bYZcTgWMkwee(ynUxyaSiQFb(AWF6On8TqyZznDedQk5qI1ah9nSesZFIZMWmBcxZ7A9uGqdp8KuxGS00HnwmHqCgP85INQ0glb5W97nLnhPRbYhnEtgDiULF2NlghaSnQ)HUzqj2xJBqIjjsb7NUjPGVL73fS)dXjWNWNYlEqFjaaX3Epmk2n0MAHI)0A9jO9)Od3oUFBEdvkEGhzH0sO4HL7jUxlfzTbLIhsWYv3(ZoKIYEkD02kj1tiMswqNpkptBpL00cP7i3vG2lrXGIiRjG5W(CDkyFVJTejqnuqdlrrYQn0ghARcn1sX9tbfz0Md06aoEz6tOPUOquKUIEqBmY3WzXMg)iYYhESrTSKQz2B)MttQkjf6iAei7ZIKV)DXeVWUUSNunqdg9)Emsu)k5sjr3f(7WyXZOOOxLhw6ZRe58vRtsPekwNe4NqB4aa6bFfw)1pYIFdDYq8dFuwuRcFQaQIF9F()4N(B)J(p(x)5F6F4xcC))Z)(F2N(5)XF6V(V538x8V95u8UTl9eAG8VmybGKEmAULvmgtJlbYvZTT3V5F)V8B)t)z7DmOYxb2dg7tbCnr(IezVps6B)v)QV9F6FE)eZaQapF23BZ855yPvJJM8LUQ7(gTF9F1V4t)z)YJT0guefKX8Ve2qFjLuHNP33qXG6UVb9t)I)UV9F5p54K40LpNdFzP)popfMGCrM7dsILvaqTmS(19WSUmQ2)waEHHXRUcer)YKkbsh8aXai)pKWJrqcShAdwubZzbusUXZCztvErc)SL2KrfqUa3pcHAvqsM)sw6A1n7INwcditQ24fuAisOHihieLaHAVCwuD4Vatjf21RU(MZb(I)1dMm6c)RUgIq(mTQxbaYLbUHXkDfM8OQIuXBcbpb2kAnu)n0q7ME3mD0GlhPQxTXNpfU1TtuLubLkhmkab2eELykEd6BMz(DENqK)CaO)teG83qG98E0hQ(HdiS5pCatbP(yq)ANJ)6)XMXHAiCm7(d568hUz7s69q5hQzBa667hsgzhJ)3qzX(hQzv(61qU5c1CZnR(16aZEao0G9VyiqieAjrcYx9ivZRKhGOm5bsRk8xZNInRRkBTUGWDkXZJ2JoUUSmQIDqNOzISDOkaf0EgEg)QkGLNpbdXTJdEEMNHL69bidlN0a6mdB2TeEPoRinAj2MSOUag1l55scZh88KIsEAM5(6Lh2TyywJorAU8OmsWlPJq9L3OlglElPcs9RZfJ6NRe(laJijl8aQ3e6RQTq(PWs3HUrUpsTh8m57s)JN08Yluv8BZHlHxxUCGoYkOuvYT))G3ehs5d1fPqrPt(F4oVJCTf9rqeRyzEsRoUEtCJBw1qPOUwOuYYPdo)S6ZbIolAzjl6PRJXlbdaLBrClnKDuluDIu4aDWxOdnZWB1Sz)xd
		]]
		Details:ImportProfile(profile, profileName)
		Details.always_use_profile = true
		Details.always_use_profile_name = profileName
	end

    if CombuctorDB4 and TDPack2Command then
        StaticPopupDialogs["RELOADUI_ZZZADDONCHECK"] = {
            text = [[
你的大脚插件个人整合包已损坏！

检测到你用大脚原版插件覆盖了整合包，但没有清理Interface文件夹。这会导致背包打不开等问题，强烈建议不要这么做。点击“是”可禁用tdPack2插件修复背包。但插件已损坏，你之后可能会遇到其他问题。

建议进行如下操作修复插件（任选一种）：
    1. 删除 _classic_/Interface 文件夹，然后重新安装你想要的插件，比如大脚原版，或者个人整合包。注意两者不可混用。
    2. 用个人整合包覆盖 _classic_/Interface 文件夹。虽然可能有大脚原版残留，但基本上能正常运行。

选定一种插件包后，请坚持使用这种插件包指定的方法更新，不要使用其他方法更新。比如，选择个人整合包后，就不该用大脚启动器更新插件，也不能用猫盒子、桃乐豆、Twitch等更新器更新由整合包提供的插件（更新你自己加的单体插件没问题）。如果你这么做了，整合包就处于不稳定状态，可能会发生各种问题，整合包作者也无法帮你解决。唯一的解决方法可能是删除Interface文件夹重新安装。

如果你不想再看到这个提示，请禁用“整合包插件完整性检测”插件。如果一直循环弹出窗口，请重启魔兽世界。
]],
            button1 = YES,
            button2 = NO,
            OnAccept = function()
                DisableAddOn("tdPack2")
                ReloadUI()
            end,
            showAlert = 1,
            timeout = 0,
            hideOnEscape = true,
            whileDead = true,
        }
        BigFoot_DelayCall(function() StaticPopup_Show("RELOADUI_ZZZADDONCHECK") end, 1)
        return
    end

    if CombuctorAutoDisplay and not TDPack2Command then
        StaticPopupDialogs["RELOADUI_ZZZADDONCHECK"] = {
            text = [[
检测到你禁用了 tdPack2 插件，或者通过第三方更新器更新了它，背包整理功能将不可用或表现异常。

点击“是”尝试启用 tdPack2 插件。

注意：如果你通过第三方更新器更新了 tdPack2 插件，则会一直弹出这个提示，请用第三方更新器更新 Combuctor 插件以避免循环弹出该提示。

注意：用第三方更新器更新 Combuctor 插件后，背包功能会改变，某些功能甚至会不正常，你可能需要自行解决问题。

如果用第三方更新器更新后不满意，你也可以考虑用回整合包提供的 tdPack2 插件（解压整合包覆盖AddOns目录，或者用整合包自动更新器进行更新）。
]],
            button1 = YES,
            button2 = NO,
            OnAccept = function()
                EnableAddOn("tdPack2")
                ReloadUI()
            end,
            showAlert = 1,
            timeout = 0,
            hideOnEscape = true,
            whileDead = true,
        }
        BigFoot_DelayCall(function() StaticPopup_Show("RELOADUI_ZZZADDONCHECK") end, 1)
        return
    end

    if IsAddOnLoadable('Bagnon_Forever') and not CombuctorDB4 then
        StaticPopupDialogs["RELOADUI_ZZZADDONCHECK"] = {
            text = [[
检测到大脚原版残留，点击“是”禁用残留插件：

Bagnon_Forever

建议从 _classic_/Interface/AddOns 文件夹删除这个残留插件。

如果你以后换回大脚原版，可能需要在插件列表自行启用这个插件。

如果你不想再看到这个提示，请禁用“整合包插件完整性检测”插件。如果一直循环弹出窗口，请重启魔兽世界。
]],
            button1 = YES,
            button2 = NO,
            OnAccept = function()
                DisableAddOn("Bagnon_Forever")
                ReloadUI()
            end,
            showAlert = 1,
            timeout = 0,
            hideOnEscape = true,
            whileDead = true,
        }
        BigFoot_DelayCall(function() StaticPopup_Show("RELOADUI_ZZZADDONCHECK") end, 1)
        return
    end

    -- 重置背包插件以防出错
	local patchVersion = '2019-12-12-13'
	if isCombuctorNeedReset() then
		resetCombuctor()

		StaticPopupDialogs["RELOADUI_ZZZADDONCHECK"] = {
			text = "背包整合插件已更新，为了防止背包出错，需要重载界面。",
			button1 = YES,
			OnAccept = function()
				ReloadUI()
			end,
			showAlert = 1,
			timeout = 0,
			hideOnEscape = false,
            whileDead = true,
		}
        BigFoot_DelayCall(function() StaticPopup_Show("RELOADUI_ZZZADDONCHECK") end, 1)
        return
	end
end

LoaderFrame:SetScript("OnEvent", LoaderEvents)

-- 立即执行的初始化操作
if NWB then
    -- 修复部分未生效的汉化
    local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs")
    if L then
        L["You are on a layered realm."] = "你的服务器存在位面。"
        L["Click here to view current timers."] = "点击查看当前计时器信息。"
        L["|cffffff00No characters with buffs found."] = "|cffffff00你的角色身上没有世界Buff。"
        L["\nNo current timers found."] = "\n目前没有世界Buff计时器。"
        L["Layer"] = "位面"
        L["Buff records have been reset."] = "Buff记录已重置。"
    end
end
