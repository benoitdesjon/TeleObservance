package ben.librairy
{
	public class RingObservance extends Ring
	{
		public function RingObservance(sizeRing:int)
		{
			super(sizeRing);
		}
		
		/**
		 * return the difference beetween the min and tha max value of the ring
		 */
		public function width():int{
			var max:int = structure[0];
			var min:int = structure[0];
			for(var i:int = 1 ; i < lengthStruct ; i++){
				//si l'anneau n'est pas rempli on sort de la boucle 
				if (structure[i] == -1) return int.MAX_VALUE;
				if (structure[i] > max ) max = structure[i];
				else if (structure[i] < min ) min = structure[i];
			}
			
			return Math.abs(max-min);
		}
		
		/**
		 * renvoie 1 si l'élément que l'on rajoute rend le patient non observant
		 * (4semaines de non obervance + 1s de changement de forfait )
		 */
		override public function add(element:Object):int
		{
			if(this.width() <= 13 && structure[head] == int(element)-1){
				super.add(element);
				return 1;
			}else{
				super.add(element);
				return 0;
			}
		}
		
		
	}
}