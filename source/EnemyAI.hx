package;

class EnemyAI
{
	/*
	 * Enemy AI Goals:
		 * If the enemy can use one of its tokens to capture one or more tokens, it should play that move.
		 * If there are two or more moves available, they should play the move with the highest success ratio.
		 * If no move would result in a successful capture, the enemy should place a token in a strategic position.
	 *
	 * Points ranking:
		 * Successfully capture a token - 4
		 * playing attack vs attack - 3
		 * playing attack vs defense - 2
		 * placing highest possible defense toward open spaces - 1
		 * All other sides - 0
	 * 
	 * The way this will work is that it will cycle through each empty space, determine the value of that space based on the above criteria
	 * Then for each space it will cycle through each token in  the computer's hand and score each token on its potential to get that value.
	 * It will then calculate a ratio of space value to token value and determine the best token to play in that space.
	 * It will repeat that for eachspace and then pick the highest ratio as that move. 
	 * 
	 * */
	public static function makeMove(gameGrid:Array<Dynamic>, walls:Array<Dynamic>, hand:Array<Dynamic> ):Array<Int>
	{
		var tokenPos:Int;
		var gridX:Int;
		var gridY:Int;
		var returnVals:Array<Int>;
		
		returnVals = [];
		tokenPos = Std.random(hand.length);
		returnVals.push(tokenPos);
		do
		{
			gridX = Std.random(4);
			gridY = Std.random(3);
		}while (checkEmptyGridSpace(gameGrid, gridX, gridY) == false);
		
		returnVals.push(gridX);
		returnVals.push(gridY);
		
		return returnVals;
	}
	
	private static function calculateMoves(gameGrid:Array<Dynamic>, walls:Array<Dynamic>, hand:Array<Dynamic>):Array<Dynamic>
	{
		for (i in 0...gameGrid.length)
		{
			for (j in 0...gameGrid[i].length)
			{
				if (gameGrid[i][j] == null)
				{
					
				}
			}
		}
		
		return new Array();
	}
	
	private static function checkEmptyGridSpace(gameGrid:Array<Dynamic>,gridX:Int,gridY:Int):Bool
	{
		if ((gridY == 0 || gridY == 2) && gridX == 3)
		{
			return false;
		}
		else
		{
			if (gameGrid[gridY][gridX] == null)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}