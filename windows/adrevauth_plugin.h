#ifndef FLUTTER_PLUGIN_ADREVAUTH_PLUGIN_H_
#define FLUTTER_PLUGIN_ADREVAUTH_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace adrevauth {

class AdrevauthPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AdrevauthPlugin();

  virtual ~AdrevauthPlugin();

  // Disallow copy and assign.
  AdrevauthPlugin(const AdrevauthPlugin&) = delete;
  AdrevauthPlugin& operator=(const AdrevauthPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace adrevauth

#endif  // FLUTTER_PLUGIN_ADREVAUTH_PLUGIN_H_
