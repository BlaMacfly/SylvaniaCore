# ArgusCore Fix Backlog

Tracks the incremental security/stability/correctness/blizzlike maintenance pass.
One fix per entry. See repo root workflow conventions for process rules.

Legend: `[ ]` open · `[WIP]` in progress · `[DONE]` shipped

---

## P0 — Security / Corruption

### [WIP] Core/Player - Vendor purchase quantity desync (validate-vs-deliver truncation)

**Subsystem:** Entities/Player, item vendor purchase

**Problem:** `Player::BuyItemFromVendorSlot(..., uint32 count, ...)` validates stock
limits, gold price, and extended-cost reagent/currency ownership against the full
client-supplied `count` (an `int32` read directly off `CMSG_BUY_ITEM`'s `Quantity`
field, widened to `uint32`). It then forwards `count` into
`Player::_StoreOrEquipNewItem(..., uint8 count, ...)`, which silently narrows it to
`count % 256`. Actual item delivery, reagent/currency consumption
(`DestroyItemCount`/`RemoveCurrency`), and vendor stock decrement
(`UpdateVendorItemCurrentCount`) all use the truncated value, while the "can you
afford/own this" checks earlier used the untruncated value. A single crafted packet
with `Quantity > 255` desyncs what was validated from what actually executes —
a client-triggerable economic integrity fault.

**Files:** `src/server/game/Entities/Player/Player.cpp`
(`BuyItemFromVendorSlot`, `_StoreOrEquipNewItem`),
`src/server/game/Handlers/ItemHandler.cpp` (`HandleBuyItemOpcode`)

**Reference:** None directly ported; DestinyCore keeps `count` as `uint8` end-to-end
(no widening, so no desync there). ArgusCore widened the outer function to `uint32`
without updating the inner one.

**Fix:** Clamp `count` to `uint8` range immediately after the existing
`if (count < 1) count = 1;` cheat guard in `BuyItemFromVendorSlot`, before any
validation runs, so every downstream check validates the exact quantity that will
be charged and delivered.

**Test:** See commit / manual test instructions below.

---

## P1 — Stability

### [ ] Core/Unit - TriggerAuraHeartbeat iterator invalidation

**Subsystem:** Entities/Unit, Spells/Auras

**Problem:** `Unit::TriggerAuraHeartbeat()` (`Unit.cpp:513-519`) iterates
`m_appliedAuras` (a `std::multimap`) with a plain range-based `for` while calling
`Aura::Heartbeat()`, which invokes arbitrary `AuraScript::OnHeartbeat` hooks. If a
heartbeat hook removes the aura currently being visited (a normal aura-scripting
pattern — "cancel self if condition no longer met"), `Unit::_UnapplyAura` erases
that exact map node mid-loop, which is undefined behavior for the range-for's
hidden iterator.

**Files:** `src/server/game/Entities/Unit/Unit.cpp`

**Reference:** Not present in DestinyCore (the heartbeat-aura mechanic is
Legion-specific). Fix is precedented in-tree: `Unit::AtEnterCombat()` /
`Unit::AtExitCombat()` (same file, ~line 8774) invoke the same class of arbitrary
aura-script hook over the same container using an erase-safe idiom (capture the
pointer, advance the iterator, *then* invoke the hook).

**Fix:** Convert `TriggerAuraHeartbeat`'s loop to the same erase-safe idiom already
used by `AtEnterCombat`/`AtExitCombat`.

**Status:** Not started — next in queue after the vendor purchase fix.

### [ ] Core/Vehicle - Null seat dereference in VehicleHandler

**Subsystem:** Handlers/VehicleHandler, Entities/Vehicle

**Problem:** `HandleRequestVehiclePrevSeat`, `HandleRequestVehicleNextSeat`,
`HandleMoveChangeVehicleSeats`, and `HandleRequestVehicleSwitchSeat`
(`VehicleHandler.cpp:45-113`) call `Vehicle::GetSeatForPassenger()`, which is
documented to return null if the passenger isn't currently seated, and dereference
the result without a null check (contrast `CombatHandler.cpp:51-52`, which at
least `ASSERT`s). A rapid double-send of a vehicle-seat opcode during a seat-change
race window is a plausible client-triggerable null deref.

**Files:** `src/server/game/Handlers/VehicleHandler.cpp`

**Reference:** Same missing check exists in DestinyCore — inherited from upstream
TrinityCore, not ArgusCore-specific. Lower priority than the heartbeat bug since
it's long-standing and shared across forks, but still a live crash bug.

**Status:** Not started.

### [ ] Core/Loot - Unguarded division in HandleLootMoneyOpcode

**Subsystem:** Handlers/LootHandler

**Problem:** `uint32 goldPerPlayer = uint32((loot->gold) / (playersNear.size()));`
(`LootHandler.cpp:~168`) has no guard against `playersNear` being empty. In normal
play the looter is always included, so this is low-exploitability today, but it's
an unguarded integer division on a client-triggerable path (`CMSG_LOOT_MONEY`).

**Files:** `src/server/game/Handlers/LootHandler.cpp`

**Reference:** Same pattern exists in DestinyCore; not ArgusCore-specific.

**Status:** Not started — low priority, defensive-only.

---

## P2 — Core Correctness

### [ ] Core/Bank - Slot/PackSlot argument order inconsistency

**Subsystem:** Handlers/BankHandler

**Problem:** `HandleAutoBankReagentOpcode` calls
`GetItemByPos(autoBankReagent.PackSlot, autoBankReagent.Slot)` while
`HandleAutoStoreBankReagentOpcode` calls
`GetItemByPos(autoStoreBankReagent.Slot, autoStoreBankReagent.PackSlot)` — reversed
argument order relative to its sibling. Each packet's `Read()` implementation reads
the two fields in different wire order, so this may be self-consistent and not an
actual bug — needs verification against a real client packet capture before
touching it.

**Files:** `src/server/game/Handlers/BankHandler.cpp`

**Status:** Needs verification, not confirmed as a bug. Low priority.

---

## P3 — Blizzlike Gameplay

(Not populated by this pass — see `ROADMAP.md` / `plans/00-arguscore-analysis-and-roadmap.md`
for the active class-spell-porting and content workstreams, which are tracked
separately from this security/stability backlog.)

---

## P4 — Performance / Cleanup

(Not populated by this pass.)

---

## Notes on scope

This backlog is deliberately shallow on first pass — it reflects two targeted,
read-only audits (item/gold/trade exploit surface; crash/stability surface) rather
than an exhaustive line-by-line review. Areas checked and found solidly guarded
during this pass (not re-audited unless something changes nearby): `TradeHandler`,
`MailHandler` (including mail money/COD overflow guards), `AuctionHouseHandler`,
`GuildHandler`/`Guild.cpp` bank-item moves, `VoidStorageHandler`, movement/teleport
coordinate validation (`MovementHandler.cpp`, `ValidateMovementInfo`), `Spell.cpp`/
`SpellEffects.cpp` target-pointer handling, `LootHandler.cpp` target/master-loot
lookups, `Group.cpp` aura/member iteration.
