global.speedModifier = 1;
global.bubbleMeter = 200;
global.comboMultiplier = 1;
global.comboExtensionTimer = 0;
score = 0;

// Particle System
global.comboPartSys = part_system_create(ps_multiplier_bubbles);
self.emitter = part_emitter_create(global.comboPartSys);
self.part_type = part_type_create();

// start creating obstacles
alarm[0] = room_speed * 3;

// start creating clouds
alarm[1] = room_speed * 10;

// combo timer
alarm[4] = room_speed;