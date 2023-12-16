using BepInEx;

namespace LethalCompanyTemplate
{
    
    [BepInPlugin("org.newyork167.plugins.lethaltemplate", "Example Plug-In", "1.0.0.0")]
    public class Plugin : BaseUnityPlugin
    {
        private string PLUGIN_GUID = "org.newyork167.plugins.lethaltemplate";
        private void Awake()
        {
            // Plugin startup logic
            Logger.LogInfo($"Plugin {PLUGIN_GUID} is loaded!");
            Logger.LogError($"TESTING ERROR LOG");
        }
    }
}