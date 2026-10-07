#!/usr/bin/env python3
# Patch du Rare Finder de World Quest Tracker 7.3 pour La Legion de Sylvania.
# Usage : patch_wqt.py <WorldQuestTracker.lua>
import sys, subprocess

p = sys.argv[1]
raw = open(p, 'rb').read().decode('utf-8')
assert '\r\n' in raw
s = raw.replace('\r\n', '\n')

import re
def rep(old, new):
    # tolerant aux espaces en fin de ligne (les lignes vides du fichier d origine portent des tabulations)
    global s
    pat = '\n'.join(re.escape(l.rstrip()) + '[ \t]*' for l in old.split('\n'))
    m = list(re.finditer(pat, s))
    assert len(m) == 1, (old[:70], len(m))
    s = s[:m[0].start()] + new + s[m[0].end():]

# --- table vignette -> PNJ, construite depuis notre base (VignetteID des rares suivis)
argus = open('/home/ubuntu/tmp/wqt_rares.txt').read().strip()
isles = "110342,110367,109648,110346,109692,109281,109677,109584,109641,109702,109653,109990,109630,110361,92117,109594,109575,109620"
isles_q = {110367: 45483, 110361: 45484, 110346: 45485, 110342: 45487, 109990: 45488, 109702: 45489, 109692: 45490,
           109677: 45491, 109653: 45492, 109648: 45493, 109641: 45494, 109630: 45495, 109620: 45496, 109594: 45497,
           109584: 45499, 109281: 45501, 109575: 45515, 92117: 38468}
rows = subprocess.run(['sudo', 'mysql', '-N', '-e',
    f"SELECT VignetteID, entry, name FROM dc_world.creature_template WHERE VignetteID > 0 AND entry IN ({argus},{isles}) ORDER BY entry"],
    capture_output=True, text=True, check=True).stdout.strip().split('\n')
vign = '\n'.join(f"\t[{v}] = {e}, --{n.lower()}" for v, e, n in (r.split('\t') for r in rows))
quests = '\n'.join(f"\trf.RaresQuestIDs [{e}] = rf.RaresQuestIDs [{e}] or {q}" for e, q in isles_q.items())

block = f"""--> [Sylvania] numero de vignette -> PNJ. Le serveur place le numero de la vignette dans son GUID
--> (Vignette-0-x-carte-x-NUMERO-x) : on reconnait le rare sans dependre de son nom ni de la langue du client.
--> Argus + rares des Iles brisees. Donnees tirees de la base du serveur La Legion de Sylvania.
rf.SylvaniaVignettes = {{
{vign}
}}
for _, npcId in pairs (rf.SylvaniaVignettes) do
	rf.RaresToScan [npcId] = true
end
{quests}

rf:SetScript ("OnEvent", function (self, event, ...)"""
rep('rf:SetScript ("OnEvent", function (self, event, ...)', block)

# --- VIGNETTE_ADDED : partout, plus seulement sur Argus
rep('''	elseif (event == "VIGNETTE_ADDED") then
		if (WorldQuestTracker.IsArgusZone (GetCurrentMapAreaID())) then
			rf.ScanMinimapForRares()
		end
	end''', '''	elseif (event == "VIGNETTE_ADDED") then
		--> [Sylvania] partout (Iles brisees comprises), plus seulement sur Argus
		rf.ScanMinimapForRares()
	end''')

# --- scan de la minicarte : sans guilde, par numero de vignette, enregistrement local
rep('''function rf.ScanMinimapForRares()
	if (not IsInGuild()) then
		return
	end
	for i = 1, C_Vignettes.GetNumVignettes() do
		local serial = C_Vignettes.GetVignetteGUID (i)
		if (serial) then
			local _, _, name, objectIcon = C_Vignettes.GetVignetteInfoFromInstanceID (serial)
			if (objectIcon and (objectIcon == 41 or objectIcon == 4733)) then
				local npcId = WorldQuestTracker.db.profile.rarescan.name_cache [name]
				if (npcId and rf.RaresToScan [npcId]) then''', '''function rf.ScanMinimapForRares()
	--> [Sylvania] plus besoin d'etre en guilde : le rare est enregistre localement, la guilde n'est qu'un bonus
	for i = 1, C_Vignettes.GetNumVignettes() do
		local serial = C_Vignettes.GetVignetteGUID (i)
		if (serial) then
			local _, _, name, objectIcon = C_Vignettes.GetVignetteInfoFromInstanceID (serial)
			--> [Sylvania] d'abord par le numero de vignette, sinon l'ancienne methode (icone + nom deja vu)
			local npcId = rf.SylvaniaVignettes [WorldQuestTracker:GetNpcIdFromGuid (serial)]
			if (not npcId and objectIcon and (objectIcon == 41 or objectIcon == 4733)) then
				npcId = WorldQuestTracker.db.profile.rarescan.name_cache [name]
			end
			name = name or rf.RaresENNames [npcId] or ("Rare " .. tostring (npcId))
			do
				if (npcId and rf.RaresToScan [npcId]) then''')

rep('''								local data = LibStub ("AceSerializer-3.0"):Serialize ({rf.COMM_IDS.RARE_SPOTTED, UnitName ("player"), "GUILD", rareName, serial, map, x, y, true, time()})

								WorldQuestTracker:SendCommMessage (WorldQuestTracker.COMM_PREFIX, data, "GUILD")

								if (WorldQuestTracker.db.profile.rarescan.playsound and (not rf.MinimapScanCooldown [npcId] or rf.MinimapScanCooldown [npcId]+60 < time())) then''', '''								--> [Sylvania] enregistrement local (icone sur la carte), meme sans guilde
								rf.RareSpotted (UnitName ("player"), "LOCAL", rareName, serial, map, x, y, true, time())

								if (IsInGuild()) then
									local data = LibStub ("AceSerializer-3.0"):Serialize ({rf.COMM_IDS.RARE_SPOTTED, UnitName ("player"), "GUILD", rareName, serial, map, x, y, true, time()})
									WorldQuestTracker:SendCommMessage (WorldQuestTracker.COMM_PREFIX, data, "GUILD")
								end

								--> [Sylvania] message dans la discussion
								if (not rf.MinimapScanCooldown [npcId] or rf.MinimapScanCooldown [npcId]+60 < time()) then
									print ("|cFFFF9900[WQT]|r Rare repere : |cFFFFFF00" .. rareName .. "|r")
								end

								if (WorldQuestTracker.db.profile.rarescan.playsound and (not rf.MinimapScanCooldown [npcId] or rf.MinimapScanCooldown [npcId]+60 < time())) then''')

# --- ciblage : enregistrement local aussi sans guilde
rep('''					local data = LibStub ("AceSerializer-3.0"):Serialize ({rf.COMM_IDS.RARE_SPOTTED, UnitName ("player"), "GUILD", rareName, serial, map, x, y, true, time()})

					if (IsInGuild()) then''', '''					local data = LibStub ("AceSerializer-3.0"):Serialize ({rf.COMM_IDS.RARE_SPOTTED, UnitName ("player"), "GUILD", rareName, serial, map, x, y, true, time()})

					--> [Sylvania] enregistrement local, meme sans guilde
					rf.RareSpotted (UnitName ("player"), "LOCAL", rareName, serial, map, x, y, true, time())

					if (IsInGuild()) then''')

open(p, 'wb').write(s.replace('\n', '\r\n').encode('utf-8'))
print('ok', len(rows), 'vignettes')
