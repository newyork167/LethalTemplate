using HarmonyLib;
using UnityEngine.InputSystem;

namespace LethalCompanyTemplate.Patches
{
    [HarmonyPatch]
    internal class HUDManagerPatch
    {
        [HarmonyPostfix]
        [HarmonyPatch(typeof(HUDManager), "PingScan_performed")]
        private static bool DebugScan(InputAction.CallbackContext context)
        {
            Plugin.Log.LogInfo("Ping scan performed");
            Plugin.Log.LogError($"{context}");
            
            return true;
        }
    }
}
