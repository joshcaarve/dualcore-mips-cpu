
// PSEDUO Code

public Class Main {

	Stack<Integer> randStack = new Stack()<>;  // stack that core 0 will push to (GLOBAL)

	public static void main (String [] args) {
		
	}
		
	public int randomNum () {
		int randomNum = ?;  // some random function
		return randomNum;
	}
	public void CORE0 () {
		// CORE 0	
		int count = 0;
		int firstRand = randomNum(seed);
		int rand = firstRand;
		while (count < 255) {

			// if(!LOCKED) 
			if (randStack.length < 10) { 
				rand = randomNum(rand);
				randStack.push(rand);
				count++;
			} else {	
				// WAIT (LOCK)
			}	
		}
	}	
		
	
	public void CORE1 () {
		// CORE1
		int max = 0;    // running max
		int min = 0;    // running min
		int mean = 0;   // continuing calculating mean
		int count = 0;  // counter for how many numbers we got
			
		int randNum;
		int sum = 0;
		while (count < 255) {
			if (randStack.length > 0) {
				randNum = randStack.pop;
				sum += randNum;
				count++;
				if (randNum > max) {
					max = randNum;
				}
				if (randNum < min) {
					min = randNum;
				}
				mean = sum / count;
			}
		}
		mean = sum / count;  // if we are calculating the mean at the end (add to loop if we are keeping a running mean	
	} 
		
		

	

}
