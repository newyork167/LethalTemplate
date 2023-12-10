using BepInEx;

namespace LethalCompanyTemplate
{
    
    [BepInPlugin("org.bepinex.plugins.exampleplugin", "Example Plug-In", "1.0.0.0")]
    public class Plugin : BaseUnityPlugin
    {
        private string PLUGIN_GUID = "org.bepinex.plugins.exampleplugin";
        private void Awake()
        {
            // Plugin startup logic
            Logger.LogInfo($"Plugin {PLUGIN_GUID} is loaded!");
        }
    }
}