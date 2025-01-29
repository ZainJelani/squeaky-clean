part_system_depth(global.playerPartSys, -100);
part_emitter_region(global.playerPartSys, 0, obj_dino.x - 20, obj_dino.x + 20, obj_dino.y + 20, obj_dino.y + 50, ps_shape_rectangle, ps_distr_linear);