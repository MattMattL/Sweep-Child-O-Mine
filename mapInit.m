
% This file contains the functions needed to initialise and construct
% the N x M grid map. The map array is saved as 'arrMap' in 'param'.
%

function out = mapInit(param)

	% initialise constants
	param.CELL_UNKNOWN = -2;
	param.CELL_FLAG = -1;
	param.CELL_0 = 0;
	param.CELL_1 = 1;
	param.CELL_2 = 2;
	param.CELL_3 = 3;
	param.CELL_4 = 4;
	param.CELL_5 = 5;
	param.CELL_6 = 6;
	param.CELL_7 = 7;
	param.CELL_8 = 8;

	% generating an R x C map
	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS
			param.arrMap(i,j) = uicontrol(param.guiFig);
			set(param.arrMap(i, j), 'Position', getBlockPos(i, j, 1, 1, param));
			setBlockState(param, i, j, param.CELL_UNKNOWN);
		end
	end

	out = param;

end

% Calculates and returns an array containing position vectors requested.
function out = getBlockPos(i, j, dimVer, dimHor, param)

	% set the origin
	arrBlockPos(1) = param.BLOCK_MARGINE_HOR * j;
	arrBlockPos(2) = param.BLOCK_MARGINE_VER * i;

	% set a dimension vector
	arrBlockPos(3) = param.BLOCK_SIZE_HOR * dimHor;
	arrBlockPos(4) = param.BLOCK_SIZE_VER * dimVer;

	out = arrBlockPos;

end




