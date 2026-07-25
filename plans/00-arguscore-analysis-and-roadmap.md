# ArgusCore — Analysis & Implementation Plan

> Generated: 2026-05-30
> Source of truth: ROADMAP.md + live codebase scan

---

## Phase 0 — Documentation Discovery (Findings)

**Sources consulted:**
- `ROADMAP.md` — full phase-by-phase plan with per-task status
- `README.md` — build requirements and config layout
- `CMakeLists.txt` — build system structure and module wiring
- `modules/cmake/AddModule.cmake` — `add_argus_module()` API
- `.github/workflows/build-linux.yml` / `build-windows.yml` — CI pipeline
- `src/server/scripts/` — content script structure
- `logs/` — reference codebase inventory

**Current Phase Status:**

| Phase | Title | Status |
|---|---|---|
| 1 | Safe Rebranding | Validated |
| 2 | Custom Script Integration | Complete |
| 3 | Build System Cleanup | Validated |
| 4 | Dependency Updates | Validated (MariaDB pending) |
| 5 | Code Modernization | Complete |
| 6 | CI, Testing, Profiling | Complete |
| 7 | Modular System | **In progress** |
| 8 | Safe Async Systems | Complete |
| 9 | Map Threading Research | Complete |
| 10 | World Layering | Complete (design only) |
| 11 | NPC Gameplay Systems | **In progress** |
| 12 | Class Spell Restoration | **In progress** |

---

## Architecture Overview

```
ArgusCore/
├── src/
│   ├── common/          Networking (Asio), crypto, config, logging, threading, collision
│   ├── server/
│   │   ├── bnetserver/  Auth + realm selection (port 3724)
│   │   ├── worldserver/ Main game server (port 8085)
│   │   ├── game/        Core game logic (~52 subsystems: Units, Spells, Maps, AI, Handlers…)
│   │   ├── scripts/     Content scripts — organized by zone and class
│   │   │   ├── Spells/  spell_dk.cpp, spell_monk.cpp, spell_dh.cpp …
│   │   │   ├── BrokenIsles/, Argus/, Northrend/ …  zone content
│   │   │   └── Custom/  standalone features (now empty — scripts moved to modules)
│   │   ├── database/    DB abstraction + schema updater (UpdateFetcher, DBUpdater)
│   │   └── shared/      Shared packet/network/realm code between servers
│   └── tools/
├── modules/             AzerothCore-style external module system
│   ├── cmake/AddModule.cmake  add_argus_module() helper
│   └── (mod-* subdirs auto-discovered at configure time)
├── sql/
│   ├── base/            Initial schema (DO NOT modify post-import)
│   ├── updates/<db>/master/   RELEASED updates (committed)
│   ├── pending/<db>/    PENDING (WIP/pre-review, not committed)
│   ├── custom/<db>/     CUSTOM (server-local, never committed)
│   └── old/             ARCHIVED legacy
├── logs/                Reference codebases (read-only)
│   ├── LegionCore-7.3.5-merged/  Primary Phase 12 spell source
│   ├── TrinityCore-master/
│   ├── TrinityCore-Cata/
│   └── SkyFire_548-main/
└── .github/workflows/
    ├── build-linux.yml  4 jobs: Debug+tests, ASAN, UBSAN, Profile
    └── build-windows.yml  MSVC RelWithDebInfo + artifact ZIP
```

**Module wiring:** `modules/` → `add_argus_module()` → global `ARGUS_MODULE_LIBRARIES` property → root `CMakeLists.txt` links into `worldserver` + generates `modules_loader.cpp` calling `Add<NAME>Scripts()`.

**Script registration:** Each script class calls `RegisterSpellScript(ClassName)` (or similar) inside an `AddSC_*()` function, which is declared in the relevant `*_script_loader.cpp`.

**SQL update states:** `RELEASED | ARCHIVED | CUSTOM | MODULE | PENDING` — tracked in `UpdateFetcher::State` (`src/server/database/`).

---

## Phase 7 — Modular System (Remaining Work)

**What's done:** Module infrastructure (CMake helper, auto-discovery, script loader generation, DB state enum expansion, `sql/pending/` and `sql/custom/` directories with `.gitkeep`).

**One task remaining:**

### 7A — Module SQL Auto-Discovery in DBUpdater

**Goal:** At startup, `DBUpdater` scans `modules/mod-*/sql/<db>/` and registers discovered directories as `MODULE`-state include paths — no manual `updates_include` entries needed per module.

**File to edit:** `src/server/database/Database/DBUpdater.cpp`

**Pattern to follow:** Look at how `sql/updates/<db>/master/` is registered as `RELEASED`; replicate the scan logic but walk `modules/mod-*/sql/<db>/` via filesystem iteration.

**Verification:**
- [ ] Create a test module with a `sql/world/` migration file
- [ ] Start server — confirm the migration is applied without any manual DB row insertion
- [ ] Confirm `updates` table shows state = `MODULE`
- [ ] No existing RELEASED updates affected

**Anti-pattern:** Do not hardcode module names — use directory glob/scan.

---

## Phase 11 — NPC Gameplay Systems (Remaining Work)

Pathfinding and obstacle-jumping are done. All three power-type levels are unstarted.

### 11A — Level 1: Display (SQL only)

**Goal:** Set correct `unit_class` in `creature_template` for humanoid NPCs so the right power bar displays. No code changes.

**Steps:**
1. Query `creature_template` for `unit_class = 0` on humanoid-type entries where class should not be 0
2. Write SQL update → `sql/pending/world/rev_<timestamp>.sql`
3. Validate in-game: mage NPC shows mana bar, warrior shows rage bar

**Tool:** `tools/create_sql.ps1` generates the pending file.

**Verification:**
- [ ] Named humanoid NPCs display correct power bar type

### 11B — Level 2: Resource Consumption (Code)

**Goal:** NPC spells actually consume mana/rage/energy. A mage NPC can run OOM.

**Steps:**
1. Grep `src/server/game/Spells/` for where spell cost checks are bypassed for non-player units
2. Remove or conditionalize the bypass — NPCs with `unit_class != 0` pay spell costs
3. Run full compile + boot test
4. Validate: mage NPC mana depletes; no existing boss script regressions

**Critical guard:** Boss scripts that rely on infinite resources must not break. Audit any script in `src/server/scripts/` that sets `UNIT_FLAG_PACIFIED` or adjusts power before casting.

**Verification:**
- [ ] NPC mana drains under sustained cast pressure
- [ ] All boss scripts in existing raid/dungeon directories unaffected

### 11C — Level 3: AI Resource Management (Code + AI)

**Goal:** NPCs regenerate resources naturally, build rage on hit, and adjust ability priority based on current resource level.

**Steps:**
1. Implement class-appropriate regen rates per `unit_class` in the creature update path
2. Expose `GetPowerPercent()` helper on creature AI base class
3. Add resource-gated ability priority to key humanoid NPC scripts (opt-in per script)

**Anti-pattern:** Do NOT apply globally — Level 3 is opt-in per creature script to avoid AI overhead regression.

**Verification:**
- [ ] Warrior NPCs generate rage on hit/damage
- [ ] Mage NPCs use filler spells when low mana
- [ ] No measurable AI update time regression (check with profiling build)

---

## Phase 12 — Class Spell Restoration (Remaining Work)

**Source:** `logs/LegionCore-7.3.5-merged/src/server/scripts/Spells/`
**Target:** `src/server/scripts/Spells/`
**Rule:** One struct per commit. Compile + in-game test before next. Commit format: `feat(scripts/spell): port spell_<name> from LegionCore`

### 12A — Blocked DK Spells (Requires API Extension First)

These 4 DK spells cannot be ported until the following hooks are added to ArgusCore's spell system:

| Hook needed | Spells blocked |
|---|---|
| `DoCalcMaxDuration` | `spell_dk_bonestorm` |
| `GetRndEffectTarget()` | `spell_dk_blood_mirror`, `spell_dk_breath_of_sindragosa` |
| `AddEffectTarget()` | `spell_dk_breath_of_sindragosa` |
| `ClearSpellTargets` / `AddDelayedEvent` / `ExistSpellTarget` / `AddSpellTargets` | `spell_dk_glacial_advance`, `spell_dk_glacial_advance_damage` |

**Decision required:** Either add these hooks to the spell script system (see TrinityCore-master for reference implementations), or design workarounds that achieve the same behavior using available hooks.

**Verification before unblocking:**
- [ ] New hook compiles cleanly
- [ ] Existing spell scripts using related hooks still pass CI

### 12B — Monk (30 spells — all pending)

All 30 Monk spells in `logs/LegionCore-7.3.5-merged/src/server/scripts/Spells/spell_monk.cpp` are unported. Port in this suggested order (simpler first):

1. `spell_monk_disable` — movement impair, simple
2. `spell_monk_zen_pilgrimage` / `spell_monk_zen_pilgrimage_return` — teleport pair
3. `spell_monk_transcendence` / `spell_monk_transcendence_transfer` — spirit copy pair
4. `spell_monk_zen_flight_check` / `spell_monk_remove_zen_flight`
5. `spell_monk_flying_serpent_kick`
6. `spell_monk_expel_harm`
7. `spell_monk_zen_pulse`
8. `spell_monk_chi_wave` / `spell_monk_chi_wave_dummy` / `spell_monk_chi_wave_filter`
9. `spell_monk_power_strikes`
10. `spell_monk_hurricane_strike`
11. `spell_monk_whirling_dragon_punch_activater` / `spell_monk_whirling_dragon_punch_activated`
12. `spell_monk_storm_earth_and_fire` / `spell_monk_storm_earth_and_fire_clone_visual` / `spell_monk_clone_cast`
13. `spell_monk_gift_of_the_ox`
14. `spell_monk_guard`
15. `spell_monk_purifying_brew` / `spell_monk_purified_healing`
16. `spell_monk_enveloping_mist`
17. `spell_monk_sheiluns_gift`
18. `spell_monk_touch_of_karma`
19. `spell_monk_touch_of_death`
20. `spell_monk_dampen_harm`
21. `spell_monk_diffuse_magic`

### 12C — Paladin (24 spells — all pending)

Port order (simpler/isolated first):

1. `spell_pal_lay_on_hands`
2. `spell_pal_divine_shield`
3. `spell_pal_hand_of_protection`
4. `spell_pal_divine_intervention`
5. `spell_pal_divine_steed`
6. `spell_pal_zeal`
7. `spell_pal_holy_wrath`
8. `spell_pal_divine_storm`
9. `spell_pal_holy_shock`
10. `spell_pal_shield_of_the_righteous`
11. `spell_pal_shield_of_vengeance`
12. `spell_pal_ardent_defender`
13. `spell_pal_light_of_the_protector`
14. `spell_pal_last_defender` / `spell_pal_at_last_defender`
15. `spell_pal_at_aura_of_sacrifice`
16. `spell_pal_at_devotion_aura`
17. `spell_pal_greater_blessing_of_kings`
18. `spell_pal_holy_shield`
19. `spell_pal_holy_prism` / `spell_pal_holy_prism_effect` / `spell_pal_holy_prism_heal` / `spell_pal_holy_prism_damage`
20. `spell_pal_lights_hammer`

### 12D — Warlock (16 spells — all pending)

Port order:

1. `spell_warl_banish`
2. `spell_warl_burning_rush`
3. `spell_warl_demon_skin`
4. `spell_warl_soul_harvest`
5. `spell_warl_doom_bolt`
6. `spell_warl_corruption`
7. `spell_warl_unstable_affliction` / `spell_warl_unstable_affliction_R2`
8. `spell_warl_streten_insanity`
9. `spell_warl_seed_of_corruption_dota`
10. `spell_warl_demonic_circle_summon` / `spell_warl_demonic_circle_teleport`
11. `spell_warl_demonic_gateway` / `spell_warl_demonic_gateway_cast` / `spell_warl_demonic_gateway_duration` / `spell_warl_demonic_gateway_at`

### 12E — Hunter (15 spells — all pending)

1. `spell_hun_tame_beast`
2. `spell_hun_pet_heart_of_the_phoenix`
3. `spell_hun_ancient_hysteria`
4. `spell_hun_masters_call`
5. `spell_hun_fireworks` / `spell_hun_fetch`
6. `spell_hun_kill_command`
7. `spell_hun_dire_beast`
8. `spell_hun_cobra_shot`
9. `spell_hun_beast_cleave`
10. `spell_hun_flanking_strike`
11. `spell_hun_a_murder_of_crows`
12. `spell_hun_explosive_shot` / `spell_hun_explosive_shot_detonate`
13. `spell_hun_explosive_trap`

### 12F — Warrior (12 spells — all pending)

1. `spell_warr_charge_check_cast` / `spell_warr_charge_drop_fire`
2. `spell_warr_intercept`
3. `spell_war_intervene`
4. `spell_warr_shield_block`
5. `spell_warr_revenge`
6. `spell_warr_execute`
7. `spell_warr_bloodthirst`
8. `spell_warr_heroic_leap`
9. `spell_warr_fervor_of_battle`
10. `spell_warr_ravager` / `spell_warr_ravager_visual`

### 12G — Druid (12 spells — all pending)

1. `spell_dru_cat_form`
2. `spell_dru_travel_form` / `spell_dru_travel_form_remove`
3. `spell_dru_incarnation` / `spell_dru_incarnation_tree_of_life`
4. `spell_dru_lifebloom`
5. `spell_dru_rake`
6. `spell_dru_shred`
7. `spell_dru_rip`
8. `spell_dru_thrash`
9. `spell_dru_ferocious_bite`
10. `spell_dru_ashamanes_frenzy`

### 12H — Mage (8 spells — all pending)

1. `spell_elem_invisibility`
2. `spell_mage_displacement`
3. `spell_mage_illusion`
4. `spell_mage_flameglow`
5. `spell_mage_cauterize`
6. `spell_mage_erosion`
7. `spell_mage_arcane_barrage`
8. `spell_mage_flurry`

### 12I — DH Blocked Spells (Requires API Extension)

Requires `GetAreaObjectList` (6 spells) and `GetAura()->GetRndEffectTarget()` / `m_whoHasMyAuras` (4 spells). Same decision as 12A — add hooks or design workarounds.

### 12J — Rogue (1 spell)

1. `spell_rog_shadowy_duel_main` — verify no `m_whoHasMyAuras` dependency before porting

---

## Phase 13 — Outstanding CI / Stability (Recommended Addition)

From Phase 6 outstanding items:

- [ ] **Server profiling investigation** — server is "noticeably slow"; run with InfluxDB metrics (map update times, DB latency, session update times) and profile before any optimization work
- [ ] **24h+ uptime test** — CI only verifies compile + unit tests; a 24h stability run under load would validate Phase 8/9 async work
- [ ] **48h+ uptime test** — required to close Phase 8 validation

---

## Phase 14 — MariaDB LTS (Deferred)

From Phase 4: MariaDB LTS not yet tested. Floor stays 10.6.3 until a build is validated.

- [ ] Test MariaDB 11.x LTS on a Linux build
- [ ] Update minimum version in `README.md` and `cmake/` find scripts if needed

---

## Phase 15 — Docker/CI Image (Deferred)

From Phase 1: Docker/container names still use upstream TrinityCore images. Needs own CI image build.

- [ ] Build ArgusCore-branded CI Docker image
- [ ] Push to Docker Hub or GHCR
- [ ] Update `build-linux.yml` to pull custom image

---

## Execution Rules (from ROADMAP.md — apply to all phases)

- Every change: **SMALL**, **ISOLATED**, **COMPILE**, **BOOT**, **TEST IN-GAME**
- Never combine gameplay refactors with threading changes
- Never rewrite large systems at once
- Never optimize before profiling
- Stability > modernization speed
- Maintain backward compatibility

---

## Immediate Next Steps (Priority Order)

1. **Phase 7A** — Module SQL auto-discovery (unblocks all future modules from needing manual DB setup)
2. **Phase 12B–J** — Continue spell ports class by class (simple spells first, blocked ones after API hooks are added)
3. **Phase 12A / 12I** — Design API hook additions needed to unblock DK and DH remaining spells
4. **Phase 11A** — NPC power type display (SQL only, low risk, high gameplay impact)
5. **Phase 13** — Profiling investigation (blocking any future performance work)
6. **Phase 11B** — NPC resource consumption (after profiling baseline established)
