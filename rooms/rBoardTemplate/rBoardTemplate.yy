{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rBoardTemplate",
  "creationCodeFile": "${project_dir}/rooms/rBoardSMW/RoomCreationCode.gml",
  "inheritCode": false,
  "inheritCreationOrder": false,
  "inheritLayers": false,
  "instanceCreationOrder": [
    {"name":"inst_1D5460D2_1","path":"rooms/rBoardTemplate/rBoardTemplate.yy",},
  ],
  "isDnd": false,
  "layers": [
    {"resourceType":"GMRAssetLayer","resourceVersion":"1.0","name":"Assets","assets":[],"depth":0,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Managers","depth":100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_1D5460D2_1","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"objBoard","path":"objects/objBoard/objBoard.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"objBoard","path":"objects/objBoard/objBoard.yy",},"propertyId":null,"value":"pthBoardSMW_Begin",},
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"objBoard","path":"objects/objBoard/objBoard.yy",},"propertyId":null,"value":"pthBoardSMW_A",},
          ],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":0.0,"y":-32.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Actors","depth":200,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRLayer","resourceVersion":"1.0","name":"Board","depth":300,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"resourceType":"GMRLayer","resourceVersion":"1.0","name":"Sprites","depth":400,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
            {"resourceType":"GMRAssetLayer","resourceVersion":"1.0","name":"Misc","assets":[],"depth":500,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
          ],"properties":[],"userdefinedDepth":false,"visible":true,},
        {"resourceType":"GMRLayer","resourceVersion":"1.0","name":"Instances","depth":600,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
            {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Path","depth":700,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
            {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Spaces","depth":800,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
          ],"properties":[],"userdefinedDepth":false,"visible":true,},
        {"resourceType":"GMRLayer","resourceVersion":"1.0","name":"Tiles","depth":900,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
            {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Direction","depth":1000,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":95,"SerialiseWidth":100,"TileCompressedData":[
-94,0,-6,-2147483648,-94,0,-6,-2147483648,-94,0,-6,-2147483648,-94,0,-6,-2147483648,-4885,0,-15,-2147483648,-3200,0,1,-2147483648,-99,0,-12,-2147483648,-88,0,-12,-2147483648,-88,0,-12,-2147483648,-88,0,-30,-2147483648,-70,0,-30,-2147483648,-70,0,-48,-2147483648,-47,0,-305,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"tlsRoad","path":"tilesets/tlsRoad/tlsRoad.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
            {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Road","depth":1100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":95,"SerialiseWidth":100,"TileCompressedData":[
-89,0,-11,-2147483648,-89,0,-11,-2147483648,-89,0,-11,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-95,0,-5,-2147483648,-6998,0,-2,-2147483648,-92,0,-17,-2147483648,-83,0,-17,-2147483648,-82,0,-32,-2147483648,-62,0,-38,-2147483648,-62,0,-55,-2147483648,-34,0,-326,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"tlsRoad","path":"tilesets/tlsRoad/tlsRoad.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
            {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Decoration","depth":1200,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":95,"SerialiseWidth":100,"TileCompressedData":[
-8697,0,-3,-2147483648,-97,0,-3,-2147483648,-96,0,-4,-2147483648,-96,0,-4,-2147483648,-87,0,-13,-2147483648,-79,0,-39,-2147483648,-61,0,-39,-2147483648,-49,0,-133,-2147483648,],"TileDataFormat":1,},"tilesetId":null,"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
            {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Structure","depth":1300,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":95,"SerialiseWidth":100,"TileCompressedData":[
-97,0,-3,-2147483648,-9300,0,-6,-2147483648,-94,0,],"TileDataFormat":1,},"tilesetId":null,"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
          ],"properties":[],"userdefinedDepth":false,"visible":true,},
      ],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Background","animationFPS":9.0,"animationSpeedType":0,"colour":4278190080,"depth":1400,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"hspeed":0.0,"htiled":true,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":true,"x":0,"y":0,},
  ],
  "parent": {
    "name": "Party",
    "path": "folders/Rooms/Party.yy",
  },
  "parentRoom": null,
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "roomSettings": {
    "Height": 1520,
    "inheritRoomSettings": false,
    "persistent": false,
    "Width": 1600,
  },
  "sequenceId": null,
  "views": [
    {"hborder":32,"hport":608,"hspeed":-1,"hview":608,"inherit":false,"objectId":null,"vborder":32,"visible":true,"vspeed":-1,"wport":800,"wview":800,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
  ],
  "viewSettings": {
    "clearDisplayBuffer": true,
    "clearViewBackground": false,
    "enableViews": true,
    "inheritViewSettings": false,
  },
  "volume": 1.0,
}