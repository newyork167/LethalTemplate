using HarmonyLib;

namespace LethalCompanyTemplate.Patches
{
    [HarmonyPatch]
    internal class HUDManagerPatch
    {
        [HarmonyPostfix]
        [HarmonyPatch(typeof(HUDManager), "PingScan_performed")]
        private static bool DebugScan()
        {
            Plugin.Log.LogInfo("Ping scan performed");
            
            return true;
        }
    }
}
