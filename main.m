clear;
clc;
close all;

% One master parameter containing all the variables, constants, and arrays.
param.MAP_ROWS = 9; % map size
param.MAP_COLS = 9;

param.arrMap = gobjects(param.MAP_ROWS, param.MAP_COLS);

param.BLOCK_SIZE_VER = 32;
param.BLOCK_SIZE_HOR = 32;

param.BLOCK_MARGINE_VER = param.BLOCK_SIZE_VER + 1;
param.BLOCK_MARGINE_HOR = param.BLOCK_SIZE_HOR + 1;

% declaring a GUI group
param.guiFig = figure('Name','Sweep Child O'' Mine','NumberTitle','off');

% GUI initialisations
param = mapInit(param);
param = buttonInit(param);









