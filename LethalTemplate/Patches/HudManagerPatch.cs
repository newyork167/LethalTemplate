using HarmonyLib;
using UnityEngine.InputSystem;

namespace LethalTemplate.Patches
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
    
        [HarmonyPrefix]
        [HarmonyPatch(typeof(HUDManager), "CanPlayerScan")]
        private static bool CanPlayerScan(HUDManager __instance, ref bool __result)
        {
            Plugin.Log.LogError("CanPlayerScan called");
            __result = false;  // __result will be the return value of the original method
            
            return false; // Returning false will skip the original method
        }
    }
}
