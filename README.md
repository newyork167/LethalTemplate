# Lethal Company Template

A template for a BepInEx Lethal Company Plugin

`git clone --recurse-submodules git@github.com:newyork167/LethalTemplate.git {your mod name}`

---

## FIRST STEPS

Install Thunderstore from https://thunderstore.io/ and run at least once. 

Make sure you create a profile, and from the "Get Mods" section, install [BepInExPack](https://thunderstore.io/c/lethal-company/p/BepInEx/BepInExPack/). 

Run `.\scripts\setup.ps1` to setup the project files. You will need to select the root Lethal Company install folder in your steamapps, and then you will need to select the Thunderstore profile you have a bepinex install in already.

The folder selection may sometimes get stuck behind another window, so if it seems like it's not working, check if there's a window behind the current one.

If you decide to setup everything manually, you can run `.\scripts\rename_plugin.ps1` to rename the plugin to your mod name. You will need to enter the name of your mod, and the username you want to use for it.

The setup script will run the rename script for you at the end otherwise.

## Renaming Plugin

In [plugin.cs](LethalTemplate/Plugin.cs) you will need to change the `BepInPlugin` annotation to your mod's details

```csharp
[BepInPlugin("org.newyork167.plugins.lethaltemplate", "Example Plug-In", "1.0.0.0")]
```

The first parameter is the GUID for your mod, the second is the name, and the third is the version.

You will also want to change the 

```csharp
private string PLUGIN_GUID = "org.newyork167.plugins.lethaltemplate";
```

to match the GUID you used in the `BepInPlugin` annotation.

---

[//]: # (## Building)

## Copying To Thunderstore

You can add multiple profiles to copy to by adding them to the array in [copy_to_thunderstore.ps1](scripts/copy_to_thunderstore.ps1):

```powershell
$profiles_to_copy_to = @(
    "Modding",
    "Playing"
)
```

This can be useful if you want a minimal modding profile, but then have it ready to go for a full profile.

## Credits

- EvaisaDev for work on https://github.com/EvaisaDev/UnityNetcodeWeaver