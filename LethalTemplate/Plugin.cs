using BepInEx;
using BepInEx.Logging;
using UnityEngine;

namespace LethalTemplate
{
    [BepInPlugin("org.newyork167.plugins.lethaltemplate", "Example Plug-In", "1.0.0.0")]
    public class Plugin : BaseUnityPlugin
    {
        private string PLUGIN_GUID = "org.newyork167.plugins.lethaltemplate";
        internal static ManualLogSource Log;
        
        private void Awake()
        {
            Log = Logger;

            // Plugin startup logic
            Log.LogInfo($"Plugin {PLUGIN_GUID} is loaded!");
            Log.LogError($"TESTING ERROR LOG");
            
            // Netcode patcher from EvaisaDev https://github.com/EvaisaDev/UnityNetcodeWeaver
            var types = Assembly.GetExecutingAssembly().GetTypes();
            foreach (var type in types)
            {
                var methods = type.GetMethods(BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static);
                foreach (var method in methods)
                {
                    var attributes = method.GetCustomAttributes(typeof(RuntimeInitializeOnLoadMethodAttribute), false);
                    if (attributes.Length > 0)
                    {
                        method.Invoke(null, null);
                    }
                }
            }
        }
    }
}