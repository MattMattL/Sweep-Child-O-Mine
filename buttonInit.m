
% Initialisations of the utility buttons.
%

function out = buttonInit(param)

	param.METHOD_SOLVER = 1001;
	param.METHOD_ATTACKER = 1002;

	i = 0;
	j = param.MAP_COLS + 1;

	% turn the debugger off (default)
	param.debugger = uicontrol(param.guiFig, 'Style', 'togglebutton', 'Value', 0, 'String', 'DEBUGGER', 'Fontsize', 25, 'Background', [0, 0, 0], 'Units', 'pixels', 'Position', getBlockPos(i+1, j+16, 8, 8, param));
	
	% buttons with the number 1-8
	for k = 1:8

		param.arrButton(k) = uicontrol(param.guiFig, ...
			'Style', 'pushbutton', ...
			'FontSize', 12, ...
			'String', 8-k+1, ...
			'Background', [1, 1, 1], ...
			'Units', 'pixels', ...
			'Position', getBlockPos(i+k+1, j+1, 1, 2, param), ...
			'CallBack', {@openSelectedBlocks, param, 8-k+1});

	end

	% number '0'
	param.arrButton(9) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'FontSize', 12, ...
		'String', '0', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+10, j+1, 1, 2, param), ...
		'CallBack', {@openSelectedBlocks, param, 0});

	% 'Flag'
	param.arrButton(10) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'FontSize', 12, ...
		'String', 'Flag', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+1, j+1, 1, 2, param), ...
		'CallBack', {@openSelectedBlocks, param, -1});

	% 'Select Area'
	param.arrButton(11) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'String', 'Select Area', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+9, j+4, 2, 2, param), ...
		'CallBack', {@selectRegion, param});

	% 'Solve' (Simple Solutions)
	param.arrButton(12) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'String', 'Solve', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+7, j+4, 2, 2, param), ...
		'CallBack', {@callSearchMethod, param, param.METHOD_SOLVER});

	% 'Search' (Probabilistic Search)
	param.arrButton(13) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'String', 'Search', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+5, j+4, 2, 2, param), ...
		'CallBack', {@callSearchMethod, param, param.METHOD_ATTACKER});

	% 'Hide Hints'
	param.arrButton(14) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'String', 'Hide Hints', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+3, j+4, 2, 2, param), ...
		'CallBack', {@hideHints, param});

	% 'Reset'
	param.arrButton(21) = uicontrol(param.guiFig, ...
		'Style', 'pushbutton', ...
		'String', 'Reset', ...
		'Background', [1, 1, 1], ...
		'Units', 'pixels', ...
		'Position', getBlockPos(i+1, j+4, 2, 2, param), ...
		'CallBack', {@resetAllCells, param});

	out = param;

end


%% Function Declarations

% Opens the blocks selected by the user and rewrites the block info.
function void = openSelectedBlocks(objIn, eventIn, param, flag)

	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS

			if(param.arrMap(i, j).Value == 1)
				setBlockState(param, i, j, flag);
			end

		end
	end

end

% Selects every blocks in the area between two blocks selected by the user.
function void = selectRegion(objIn, eventIn, param)

	rowA = 0; colA = 0;
	rowB = 0; colB = 0;

	pointSearched = 0;

	% search through the map until two selected points are set
	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS

			if(param.arrMap(i, j).Value == 1)
				if(~rowA)
					rowA = i;
					colA = j;
				else
					rowB = i;
					colB = j;
				end
			end

		end
	end

	% checking for possible errors
	if(~rowA || ~colA || ~rowB || ~colB)
		return;
	end

	if(rowA > rowB)
		temp = rowA;
		rowA = rowB;
		rowB = temp;
	end

	if(colA > colB)
		temp = colA;
		colA = colB;
		colB = temp;
	end

	% highlight the area
	for i = rowA:rowB
		for j = colA:colB

			if(param.arrMap(i, j).UserData == -2)
				set(param.arrMap(i, j), 'Value', 1);
			end

		end
	end

end

% Hides the tiles highlighted by a green background.
function void = hideHints(objIn, eventIn, param)

	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS

			% hide clues
			if(param.arrMap(i, j).BackgroundColor == [0, 1, 0])
				set(param.arrMap(i, j), 'Style', 'togglebutton');
				set(param.arrMap(i, j), 'Background', [1, 1, 1]);
				set(param.arrMap(i, j), 'UserData', param.CELL_UNKNOWN);
			end

			% cancel block selections
			param.arrMap(i, j).Value = 0;

		end
	end

end

% Cleans the entire map and restarts the game
function void = resetAllCells(objIn, eventIn, param)

	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS

			if(param.arrMap(i, j).Value == 0)

				setBlockState(param, i, j, param.CELL_UNKNOWN);

				if(param.debugger.Value == 0)
					pause(0.5/(param.MAP_ROWS * param.MAP_COLS));
				end

			else
				set(param.arrMap(i, j), 'Value', 0);
			end

		end
	end

end

% Executes solver algorithm called by the user
function void = callSearchMethod(objIn, eventIn, param, methodIn)

	switch(methodIn)

		case param.METHOD_SOLVER
			for i = 1:10;
				simpleSolver(param);
				pause(0.06);
			end

		case param.METHOD_ATTACKER
			for i = 1:4

				for j = 1:8
					simpleSolver(param)
					pause(0.02);
				end

				aiSolver(param);
				pause(0.05);

			end

	end

end


% Calculates and returns an array containing position vectors requested.
function out = getBlockPos(i, j, dimVer, dimHor, param)

	% set the origin vector
	arrBlockPos(1) = param.BLOCK_MARGINE_HOR * j;
	arrBlockPos(2) = param.BLOCK_MARGINE_VER * i;

	% calculate the dimension vector
	arrBlockPos(3) = param.BLOCK_SIZE_HOR * dimHor;
	arrBlockPos(4) = param.BLOCK_SIZE_VER * dimVer;

	out = arrBlockPos;

end




