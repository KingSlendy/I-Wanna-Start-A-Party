{
  "resourceType": "GMExtension",
  "resourceVersion": "1.2",
  "name": "window_taskbar",
  "androidactivityinject": "",
  "androidclassname": "",
  "androidcodeinjection": "",
  "androidinject": "",
  "androidmanifestinject": "",
  "androidPermissions": [],
  "androidProps": true,
  "androidsourcedir": "",
  "author": "",
  "classname": "",
  "copyToTargets": 113497714299118,
  "date": "2019-12-12T01:34:29",
  "description": "",
  "exportToGame": true,
  "extensionVersion": "1.0.0",
  "files": [
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","constants":[
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_progress_none","hidden":false,"value":"0",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_progress_unknown","hidden":false,"value":"1",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_progress_normal","hidden":false,"value":"2",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_progress_error","hidden":false,"value":"4",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_progress_paused","hidden":false,"value":"8",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_flash_stop","hidden":false,"value":"0",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_flash_window","hidden":false,"value":"1",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_flash_tray","hidden":false,"value":"2",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_flash_all","hidden":false,"value":"3",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_flash_timer","hidden":false,"value":"4",},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_flash_timernofg","hidden":false,"value":"12",},
      ],"copyToTargets":9223372036854775807,"filename":"window_taskbar.dll","final":"","functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_progress_raw","argCount":2,"args":[
            1,
            2,
          ],"documentation":"","externalName":"window_progress_raw","help":"","hidden":true,"kind":11,"returnType":2,},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_flash_raw","argCount":2,"args":[
            1,
            2,
          ],"documentation":"","externalName":"window_flash_raw","help":"","hidden":true,"kind":11,"returnType":2,},
      ],"init":"","kind":1,"order":[
        {"name":"window_progress_raw","path":"extensions/window_taskbar/window_taskbar.yy",},
        {"name":"window_flash_raw","path":"extensions/window_taskbar/window_taskbar.yy",},
      ],"origname":"extensions\\window_taskbar.dll","ProxyFiles":[
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"window_taskbar_x64.dll","TargetMask":6,},
      ],"uncompress":false,"usesRunnerInterface":false,},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","constants":[],"copyToTargets":9223372036854775807,"filename":"window_taskbar.gml","final":"","functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_taskbar_prepare_buffer","argCount":1,"args":[
            2,
          ],"documentation":"","externalName":"window_taskbar_prepare_buffer","help":"","hidden":true,"kind":11,"returnType":2,},
      ],"init":"","kind":2,"order":[
        {"name":"window_taskbar_prepare_buffer","path":"extensions/window_taskbar/window_taskbar.yy",},
      ],"origname":"extensions\\gml.gml","ProxyFiles":[],"uncompress":false,"usesRunnerInterface":false,},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","constants":[],"copyToTargets":-1,"filename":"autogen.gml","final":"","functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_progress","argCount":-1,"args":[],"documentation":"","externalName":"window_progress","help":"window_progress(status:int, current:int = 0, total:int = 0)->bool","hidden":false,"kind":2,"returnType":2,},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_flash","argCount":-1,"args":[],"documentation":"","externalName":"window_flash","help":"window_flash(flags:int, count:int = 0, freq:int = 0)->bool","hidden":false,"kind":2,"returnType":2,},
      ],"init":"","kind":2,"order":[
        {"name":"window_progress","path":"extensions/window_taskbar/window_taskbar.yy",},
        {"name":"window_flash","path":"extensions/window_taskbar/window_taskbar.yy",},
      ],"origname":"extensions\\autogen.gml","ProxyFiles":[],"uncompress":false,"usesRunnerInterface":false,},
  ],
  "gradleinject": "",
  "hasConvertedCodeInjection": true,
  "helpfile": "",
  "HTML5CodeInjection": "",
  "html5Props": false,
  "IncludedResources": [],
  "installdir": "",
  "iosCocoaPodDependencies": "",
  "iosCocoaPods": "",
  "ioscodeinjection": "",
  "iosdelegatename": "",
  "iosplistinject": "",
  "iosProps": true,
  "iosSystemFrameworkEntries": [],
  "iosThirdPartyFrameworkEntries": [],
  "license": "Proprietary",
  "maccompilerflags": "",
  "maclinkerflags": "",
  "macsourcedir": "",
  "options": [],
  "optionsFile": "options.json",
  "packageId": "",
  "parent": {
    "name": "Extensions",
    "path": "folders/Extensions.yy",
  },
  "productId": "",
  "sourcedir": "",
  "supportedTargets": 113497714299118,
  "tvosclassname": "",
  "tvosCocoaPodDependencies": "",
  "tvosCocoaPods": "",
  "tvoscodeinjection": "",
  "tvosdelegatename": "",
  "tvosmaccompilerflags": "",
  "tvosmaclinkerflags": "",
  "tvosplistinject": "",
  "tvosProps": false,
  "tvosSystemFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": [],
}