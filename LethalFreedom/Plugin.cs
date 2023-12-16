using BepInEx;
using BepInEx.Logging;
using UnityEngine;

namespace LethalFreedom
{
    
    [BepInPlugin("org.newyork167.plugins.lethal_freedom", "Lethal Freedom", "0.0.1.0")]
    public class Plugin : BaseUnityPlugin
    {
        private string PLUGIN_GUID = "org.newyork167.plugins.lethal_freedom";
        
        internal static ManualLogSource Log;
        private void Awake()
        {
            // Plugin startup logic
            Logger.LogInfo($"Plugin {PLUGIN_GUID} is loaded!");
            Logger.LogError($"TESTING ERROR LOG");
        }
    }
}