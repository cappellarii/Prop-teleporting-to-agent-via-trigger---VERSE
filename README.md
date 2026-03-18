🎯 `MainDeviceController` — Player Utility Device
=====================================
A flexible Verse device delivering prop attachment, stealth toggling, and a close-quarters attack tailored for Fortnite Creative/UEFN.

---

🧩 Capabilities
--------------
- Prop Synchronization: Continuously positions a designer-supplied creative_prop relative to the player with smoothing and rotation mirroring.
- Instant Invisibility: Triggers Hide() on the player’s fort_character, enabling temporary stealth on demand.
- Frontal Melee Burst: Casts a short-range scan in front of the player, dealing 200 damage to detected enemy agents.

---

⚙️ Configurable Inputs
----------------------
Parameter          | Type                 | Description
------------------ | -------------------- | ---------------------------------------------------------
AttachedProp       | creative_prop        | Prop that follows the player (e.g., trail, pet, weapon).
InvTrigger         | trigger_device       | Activates the invisibility routine.
AttackInput        | input_trigger_device | Input listener wired to invoke DoAttack.
PropTrigger        | trigger_device       | Starts the prop-attachment loop via GrabAgent.

---

📘 Core Routines
----------------
DoAttack(agent: agent)
  • Computes a forward point (Position + Forward * 100.0).
  • Iterates over all players within 180 units of the attacker.
  • Applies 200.0 damage to opposing teams.

AttachProp(agent: agent)
  • Runs as a suspends loop with 0.001-second ticks.
  • Forces AttachedProp to match the player’s position minus 75 units on Z.
  • Keeps the prop aligned with the agent’s rotation plus a 180.5° yaw offset.

BuyPowerInvisible(agent: agent)
  • Immediately hides the player’s fort_character.

GrabAgent(agent: agent)
  • Launches AttachProp for the agent via spawn for asynchronous tracking.

---

🧪 Setup Checklist
------------------
1. Add the MainDeviceController to your level.
2. Assign the editable devices (AttachedProp, AttackInput, InvTrigger, PropTrigger).
3. Confirm AttackInput is configured to forward the agent reference when activated.
4. Optionally adjust damage, radius, or offsets directly in the Verse script.
