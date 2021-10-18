
% An abstract initialisation manager. Used to change the state of a cell
% in the map.
%

function void = setBlockState(param, i, j, stateIn)

	switch(stateIn)

		case param.CELL_UNKNOWN
			setBlockToUnknwon(param, param.arrMap(i, j));

		case param.CELL_FLAG
			setBlockToMine(param, param.arrMap(i, j));

		case param.CELL_0
			setBlockToNum0(param, param.arrMap(i, j));

		case param.CELL_1
			setBlockToNum1(param, param.arrMap(i, j));

		case param.CELL_2
			setBlockToNum2(param, param.arrMap(i, j));

		case param.CELL_3
			setBlockToNum3(param, param.arrMap(i, j));

		case param.CELL_4
			setBlockToNum4(param, param.arrMap(i, j));

		case param.CELL_5
			setBlockToNum5(param, param.arrMap(i, j));

		case param.CELL_6
			setBlockToNum6(param, param.arrMap(i, j));

		case param.CELL_7
			setBlockToNum7(param, param.arrMap(i, j));

		case param.CELL_8
			setBlockToNum8(param, param.arrMap(i, j));
	
	end

end

function void = setBlockToUnknwon(param, cellIn)

	set(cellIn, 'UserData', -2);
	set(cellIn, 'Style', 'togglebutton');
	set(cellIn, 'String', '');
	set(cellIn, 'Value', 0);
	set(cellIn, 'Background', [1, 1, 1]);
	set(cellIn, 'FontSize', 16);

end

function void = setBlockToMine(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', -1);
	set(cellIn, 'String', '*');
	set(cellIn, 'Background', [1, 0, 0]);
	set(cellIn, 'ForegroundColor', [0, 0, 0]);
	set(cellIn, 'FontSize', 30);

end

function void = setBlockToNum0(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 0);
	set(cellIn, 'String', '');

end

function void = setBlockToNum1(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 1);
	set(cellIn, 'String', 1);
	set(cellIn, 'ForegroundColor', getColourPalette(12, 35, 252));

end

function void = setBlockToNum2(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 2);
	set(cellIn, 'String', 2);
	set(cellIn, 'ForegroundColor', getColourPalette(15, 122, 17));

end

function void = setBlockToNum3(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 3);
	set(cellIn, 'String', 3);
	set(cellIn, 'ForegroundColor', getColourPalette(243, 13, 26));

end

function void = setBlockToNum4(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 4);
	set(cellIn, 'String', 4);
	set(cellIn, 'ForegroundColor', getColourPalette(3, 12, 122));

end

function void = setBlockToNum5(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 5);
	set(cellIn, 'String', 5);
	set(cellIn, 'ForegroundColor', getColourPalette(123, 4, 10));

end

function void = setBlockToNum6(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 6);
	set(cellIn, 'String', 6);
	set(cellIn, 'ForegroundColor', getColourPalette(16, 124, 124));

end

function void = setBlockToNum7(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 7);
	set(cellIn, 'String', 7);
	set(cellIn, 'ForegroundColor', getColourPalette(0, 0, 0));

end

function void = setBlockToNum8(param, cellIn)

	set(cellIn, 'Value', 0);
	set(cellIn, 'Style', 'text');
	set(cellIn, 'UserData', 8);
	set(cellIn, 'String', 8);
	set(cellIn, 'ForegroundColor', getColourPalette(124, 124, 124));

end

% Takes RGB values and returns the normalised values.
function out = getColourPalette(redIn, greenIn, blueIn)

	maxRGB = 255;

	out = [redIn/maxRGB, greenIn/maxRGB, blueIn/maxRGB];

end








