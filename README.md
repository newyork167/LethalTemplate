# LethalCompanyTemplate
A template for a BepInEx 5 Plugin, using the correct .csproj configuration for Lethal Company modding

---

## FIRST STEPS

Install Thunderstore from https://thunderstore.io/ and run at least once. 

Make sure you create a profile, and from the "Get Mods" section, install [BepInExPack](https://thunderstore.io/c/lethal-company/p/BepInEx/BepInExPack/). 

Run `.\Scripts\setup.ps1` to setup the project files. You will need to select the root Lethal Company install folder in your steamapps, and then you will need to select the Thunderstore profile you have a bepinex install in already.

---

[//]: # (## Building)

## Copying To Thunderstore

You can add multiple profiles to copy to by adding them to the array in `.\Scripts\copy_to_thunderstore.ps1`:

```powershell
$profiles_to_copy_to = @(
    "Modding",
    "Playing"
)
```

This can be useful if you want a minimal modding profile, but then have it ready to go for a full profile.
