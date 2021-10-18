
% This algorithm probabilistically determines the state of blocks. The
% probability of the blocks around a centre block being the mine is
% calculated and saved to the 'probability space', and the sum of
% probability is calculated to use the two main equations declared in
% the function 'probBackpropagation'.
%

function void = aiSolver(param, flag)

	param.arrProb(param.MAP_ROWS, param.MAP_COLS) = 0; % the probability map

	for i = 1:param.MAP_ROWS
		for j = 1:param.MAP_COLS

			numClue = param.arrMap(i, j).UserData;

			if(1 <= numClue && numClue <= 8)

				if(~countUnknownBlocks(param, i, j, 0)) % optimisation
					continue;
				end

				if(param.debugger.Value == 1) % DEBUGGER
					fprintf('[AI] Searching around (%d, %d)...\n', i, j);
				end

				% initialise the probability map
				for k = 1:param.MAP_ROWS
					for l = 1:param.MAP_COLS
						param.arrProb(k, l) = 0.0;
					end
				end

				% calculate and propagate the probability
				numUnknown = countUnknownBlocks(param, i, j, 0);
				numMine = countMineBlocks(param, i, j, 0); 

				numProb = (numClue - numMine) / numUnknown;
				param = setProbabilityMap(param, i, j, numProb);

				% set four assistant blocks
				probBackpropagation(param, i+1, j+0, numUnknown);
				probBackpropagation(param, i-1, j+0, numUnknown);
				probBackpropagation(param, i+0, j+1, numUnknown);
				probBackpropagation(param, i+0, j-1, numUnknown);

				% DEBUGGER
				if(param.debugger.Value == 1)
					for k = param.MAP_ROWS:-1:1
						for l = 1:param.MAP_COLS
							fprintf('%.2f  ', param.arrProb(k, l));
						end
						fprintf('\n');
					end
					fprintf('\n');
				end

			end

		end
	end

end

% Probabilistically determines the location of the mines.
function void = probBackpropagation(param, i, j, entropyIn)

	% error handling
	if(i<1 || i>param.MAP_ROWS || j<1 || j>param.MAP_COLS)
		return;
	elseif(param.arrMap(i, j).UserData<1 || param.arrMap(i, j).UserData>8)
		return;
	elseif(entropyIn > countUnknownBlocks(param, i, j, 0))
		return;
	end

	% set the variables needed to proceed
	numClue = param.arrMap(i, j).UserData;
	sumProb = getSumOfProbability(param, i, j);
	numMine = countMineBlocks(param, i, j, 0); 
	numUnknown = countUnknownBlocks(param, i, j, 1);

	if(param.debugger.Value)
		fprintf('(%2d, %2d) N = %.2f | p = %.2f | * = %.2f | ? = %.2f\n', i, j, numClue, sumProb, numMine, numUnknown);
	end

	% IF clue == prob + mines + unknowns
	% THEN all the unknowns around are the mines
	if(numClue == sumProb + numMine + numUnknown) % Key Eq 1

		openBlocksAround(param, i, j, param.CELL_FLAG);
		
		if(param.debugger.Value)
			fprintf('\n[AI] All set to -2\n');
		end

	end

	% IF clue == prob + mines
	% THEN the rest are safe
	if(numClue == sumProb + numMine) % Key Eq 2

		openBlocksAround(param, i, j, param.CELL_0);

		if(param.debugger.Value)
			fprintf('\n[AI] All set to 0\n');
		end

	end

end

% Calculates and returns the sum of probabilities around a block.
function out = getSumOfProbability(param, i, j)

	sum =       getProbabilityAt(param, i-1, j+0);
	sum = sum + getProbabilityAt(param, i-1, j+1);
	sum = sum + getProbabilityAt(param, i+0, j+1);
	sum = sum + getProbabilityAt(param, i+1, j+1);
	sum = sum + getProbabilityAt(param, i+1, j+0);
	sum = sum + getProbabilityAt(param, i+1, j-1);
	sum = sum + getProbabilityAt(param, i+0, j-1);
	sum = sum + getProbabilityAt(param, i-1, j-1);

	out = sum;

end

function out = getProbabilityAt(param, i, j)

	if(i<1 || i>param.MAP_ROWS || j<1 || j>param.MAP_COLS)
		out = 0;
	else
		out = param.arrProb(i, j);
	end

end

% Generates the probability space around a single block passed.
function out = setProbabilityMap(param, i, j, chanceIn)

	param = setProbabilityAt(param, i-1, j+0, chanceIn);
	param = setProbabilityAt(param, i-1, j+1, chanceIn);
	param = setProbabilityAt(param, i+0, j+1, chanceIn);
	param = setProbabilityAt(param, i+1, j+1, chanceIn);
	param = setProbabilityAt(param, i+1, j+0, chanceIn);
	param = setProbabilityAt(param, i+1, j-1, chanceIn);
	param = setProbabilityAt(param, i+0, j-1, chanceIn);
	param = setProbabilityAt(param, i-1, j-1, chanceIn);

	out = param;

end

function out = setProbabilityAt(param, i, j, chanceIn)

	if(i<1 || i>param.MAP_ROWS || j<1 || j>param.MAP_COLS)
		out = param;
		return;
	end

	if(param.arrMap(i, j).UserData == param.CELL_UNKNOWN)
		param.arrProb(i, j) = chanceIn;
	end

	out = param;

end

% Counts and returns the number of unrevealed blocks around a cell.
function out = countUnknownBlocks(param, i, j, dependency)

	count =         compBlockState(param, i-1, j+0, -2, dependency);
	count = count + compBlockState(param, i-1, j+1, -2, dependency);
	count = count + compBlockState(param, i+0, j+1, -2, dependency);
	count = count + compBlockState(param, i+1, j+1, -2, dependency);
	count = count + compBlockState(param, i+1, j+0, -2, dependency);
	count = count + compBlockState(param, i+1, j-1, -2, dependency);
	count = count + compBlockState(param, i+0, j-1, -2, dependency);
	count = count + compBlockState(param, i-1, j-1, -2, dependency);

	out = count;

end

% Counts and returns the number of mines around a cell.
function out = countMineBlocks(param, i, j, dependency)

	count =         compBlockState(param, i-1, j+0, -1, dependency);
	count = count + compBlockState(param, i-1, j+1, -1, dependency);
	count = count + compBlockState(param, i+0, j+1, -1, dependency);
	count = count + compBlockState(param, i+1, j+1, -1, dependency);
	count = count + compBlockState(param, i+1, j+0, -1, dependency);
	count = count + compBlockState(param, i+1, j-1, -1, dependency);
	count = count + compBlockState(param, i+0, j-1, -1, dependency);
	count = count + compBlockState(param, i-1, j-1, -1, dependency);

	out = count;

end

% Returns 1 if a block passed is in the same state specified. 0, otherwise.
function out = compBlockState(param, i, j, stateIn, dependencyIn)

	% preventing buffer overflows
	if(i<1 || i>param.MAP_ROWS || j<1 || j>param.MAP_COLS)
		out = 0;
		return;
	end

	% compare states and return
	if(dependencyIn && param.arrProb(i, j) ~= 0)
		out = 0;
	else
		out = (param.arrMap(i, j).UserData == stateIn);
	end

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
	elseif(param.arrProb(i, j) ~= 0)
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






