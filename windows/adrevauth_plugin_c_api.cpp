#include "include/adrevauth/adrevauth_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "adrevauth_plugin.h"

void AdrevauthPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  adrevauth::AdrevauthPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
