%
%	Project			Minesweeper Solver
%	Program Name	Sweep Child O' Mine
%	Version			lost counting
%
%	File Created	13/02/2019
%	Last Modified	11/05
%	Submission Due	13/05
%
%
%	Description
%
%	    This GUI-based MatLab program is designed to semi-automatically solve the
% 	game Minesweeper. When numeric and spatial information given by the user is
% 	appropriate, with a little help from two external naive-AI algorithm libraries,
% 	the program tries to eliminate blocks whos state could be determined.
%
%
%	Linked Libraries
%	 - main.m
%	 - mapInit.m
%	 - buttonInit.m
%	 - setBlockState.m
%	 - simpleSolver.m
%	 - aiSolver.m
%

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









