* psr_base
* Projects Sources Requirement Base

* This plugin like your project base
* I mean you can import any file directly


* Let me tell you parts of plugin *


* Everything we need to create before app initialize:
lib/common -> {  
  font_models: Fonts to used in the plugin;
  regular_expression: All Regular Expression to used in the plugin;
}


* Controls are to control what we want to do on different pages:
lib/controllers -> {
  shake_controller: This is to control the shaking of your widgets;
  steps_controller: This is to control the data you want to display step by step;
}


* Models are we want convert our data to that
lib/models -> {
  local_models: When we want just convert data to dart and not have function in class
}


* Plugin emulators: i'm sure you get that this folder whats for😁
* Sometimes we want to do something and we need create a plugin
* BUT Sometimes that do it's not very big
* So i created a folder and import plugin emulators on there
lib/plugin_emulators -> {
  forms_builder -> {
    
  }
  multiple_ui -> {
    
  }
}












