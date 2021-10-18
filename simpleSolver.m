
% The simple solver. Checks the 8 blocks around a numbered block and solves
% if the number of mines and unknown blocks match.
%

function void = simpleSolver(param)

	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS

			numClue = param.arrMap(i, j).UserData;

			if(1 <= numClue && numClue <= 8)

				numUnknown = countUnknownBlocks(param, i, j);
				numMine = countMineBlocks(param, i, j);

				% set all to mine
				if(numClue == numMine + numUnknown)
					openBlocksAround(param, i, j, param.CELL_FLAG);
				end

				% open all
				if(numClue == numMine)
					openBlocksAround(param, i, j, param.CELL_0);
				end

			end
			
		end
	end

end

% Counts and returns the number of unrevealed blocks around a cell.
function out = countUnknownBlocks(param, i, j)

	count =         returnBlockState(param, i-1, j+0, -2);
	count = count + returnBlockState(param, i-1, j+1, -2);
	count = count + returnBlockState(param, i+0, j+1, -2);
	count = count + returnBlockState(param, i+1, j+1, -2);
	count = count + returnBlockState(param, i+1, j+0, -2);
	count = count + returnBlockState(param, i+1, j-1, -2);
	count = count + returnBlockState(param, i+0, j-1, -2);
	count = count + returnBlockState(param, i-1, j-1, -2);

	out = count;

end

% Counts and returns the number of mines around a cell.
function out = countMineBlocks(param, i, j)

	count =         returnBlockState(param, i-1, j+0, -1);
	count = count + returnBlockState(param, i-1, j+1, -1);
	count = count + returnBlockState(param, i+0, j+1, -1);
	count = count + returnBlockState(param, i+1, j+1, -1);
	count = count + returnBlockState(param, i+1, j+0, -1);
	count = count + returnBlockState(param, i+1, j-1, -1);
	count = count + returnBlockState(param, i+0, j-1, -1);
	count = count + returnBlockState(param, i-1, j-1, -1);

	out = count;

end

% Returns 1 if a block passed is in the state specified. 0, otherwise.
function out = returnBlockState(param, i, j, stateIn)

	% preventing buffer overflows
	if(i<1 || i>param.MAP_ROWS || j<1 || j>param.MAP_COLS)
		out = 0;
		return;
	end

	% compare the state and return
	out = (param.arrMap(i, j).UserData == stateIn);

end

% Opens and resets the blocks around a single block specified.
function void = openBlocksAround(param, i, j, stateIn)

	openBlockAt(param, i-1, j+0, stateIn);
	openBlockAt(param, i-1, j+1, stateIn);
	openBlockAt(param, i+0, j+1, stateIn);
	openBlockAt(param, i+1, j+1, stateIn);
	openBlockAt(param, i+1, j+0, stateIn);
	openBlockAt(param, i+1, j-1, stateIn);
	openBlockAt(param, i+0, j-1, stateIn);
	openBlockAt(param, i-1, j-1, stateIn);

end

function void = openBlockAt(param, i, j, stateIn)

	if(i<1 || i>param.MAP_ROWS || j<1 || j>param.MAP_COLS)
		return;
	end

	if(param.arrMap(i, j).UserData == param.CELL_UNKNOWN)
		
		switch(stateIn)

			case 0
				setBlockState(param, i, j, param.CELL_0);
				set(param.arrMap(i, j), 'BackgroundColor', [0, 1, 0]);

			case param.CELL_FLAG
				setBlockState(param, i, j, param.CELL_FLAG);

		end

	end

end




