package ben
{
	import ben.librairy.RingObservance;
	import ben.src.model.constante.ObservanceDatas;

	public class computeObservanceDatas
	{
		private var calendrier:Array;
		private var utiliJour:Array;
		
		public function computeObservanceDatas(utiliJour:Array)
		{
			this.utiliJour = utiliJour;
		}
		
		private function setupData():void
		{	
			var jour:int= 0 ;
			var dateDebutObservance:Date = new Date();
			var tranche:Array = new Array;
			
			dateDebutObservance = new Date("04/04/2013");
			//on commence les observance à la date butoir fixée par la ss
			//			if(dateDebutObservance < ObservanceDatas.DATE_BUTOIRE_OBSERVANCE){
			//				dateDebutObservance = ObservanceDatas.DATE_BUTOIRE_OBSERVANCE;
			//				while(utiliJour[jour++].day != dateDebutObservance);
			//			}
			
			
			//tout nouveau patient est en 9.1 pendant 13 semaines*7jours
			jour = remplirTranche(tranche, ObservanceDatas.PERIODE_OBSERVANCE_91, jour);
			calendrier.push({
				observant :  true,
				forfait : 9.1,
				utilisation : tranche
			});
			
			tranche = new Array();
			
			//puis on rempli le tableau par tranche de 28 jours
			while(jour < utiliJour.length){
				jour = remplirTranche(tranche, ObservanceDatas.PERIODE_OBSERVANCE, jour);
				calendrier.push({
					observant : estObservant(tranche),
					forfait : 9.2,
					utilisation : tranche
				});
				tranche = new Array();
			}
			
			//TODO : les jours doivent être consécutifs avant de les rentrer dans le tableau
		}
		
		//rempli la tranche avec le nombre d'éléments demandé
		private function remplirTranche(tranche:Array, periodeObservance:int, jour:int):int
		{
			var sommeJour:int = 0;
			
			if (periodeObservance == ObservanceDatas.PERIODE_OBSERVANCE_91)
				//nous sommes en 9.1
				while( sommeJour!= periodeObservance && jour < utiliJour.length){
					if(!estSuspendu("")){
						tranche.push(utiliJour[jour]);
						sommeJour++;
					}
					jour++;
				}
				//forfait 9.2 et 9.3
			else if(periodeObservance == ObservanceDatas.PERIODE_OBSERVANCE){ 
				while( sommeJour!= periodeObservance && jour < utiliJour.length){
					if(!estSuspendu("")){
						tranche.push(utiliJour[jour]);
						sommeJour++;
					}else 
						break;
					jour++;
				}
				while(estSuspendu(""))
					jour++;
			}else{
				throw new Error("impossible remplir tranche, forfait inconnu pour le patient XX");
			}
			
			return jour;
		}		
		
		/**
		 * savoir si un patient est supendu sur une date donnée
		 */
		private function estSuspendu(date:String):Boolean
		{
			return false;
		}
		
		/**
		 * L’observance s’apprécie par période de 28 jours consécutifs.
		 *  Au cours de cette période, le patient doit utiliser effectivement son appareil à PPC pendant au moins 84 heures et 
		 * avoir une utilisation effective de son appareil à PPC d’au moins 3 heures par 24 heures pendant au moins 20 jours.
		 */
		private function estObservant(tabObservance:Array):Boolean
		{
			var util:Number = 0;
			var utilSomme:Number = 0;
			var sommeJour:int = 0;
			
			//periode de 28 jours consécutifs si non, on déclare observant par défaut
			if (tabObservance.length != ObservanceDatas.PERIODE_OBSERVANCE){
				return true;
			}
			
			for(var i:int = 0 ; i < tabObservance.length ; i++){
				util = tabObservance[i].util;
				utilSomme += util;
				if (util >= 3.0) sommeJour++;
			}
			//trace (sommeJour + " " + utilSomme );
			//utilisation d'au moins 3h pendant au moins 20j
			if (sommeJour < 20) return false;
			//utilisation au moins 84h 
			if (utilSomme < 84) return false;
			
			return true;			
		}
		
		/**
		 * – pendant 8 semaines consécutives et s’il demeure non-observant pendant les 4 semaines consécutives suivantes, la prise en charge par l’AMO est transférée dès la première de ces 4 semaines sur le forfait 9.3 (1185421) ; 
		 * – pendant 16 semaines, soit quatre périodes de 28 jours consécutifs, au cours des 52 dernières semaines de traitement au titre de ce forfait et s’il demeure non observant pendant 4 semaines supplémentaires, la prise en charge par l’AMO est transférée dès la première de ces 4 semaines sur le forfait 9.3 (1185421). 
		 */
		private function facuration():void
		{
			
			if (calendrier.length == 1 ) {
				return;
			}else
				var tranche:int = 1;
			
			while (tranche < calendrier.length){
				
				tranche = calculForfait(tranche, 9.2);
				tranche = calculForfait(tranche, 9.3);
				
				//double non prise en charge
				if (tranche < calendrier.length){
					calendrier[tranche].forfait = 100;
					tranche++;
				}
				
				var initiale:int = tranche;
				var estNonPrisEnCharge:Boolean = true;
				//on part du principe que tant que l'on reçoit des observances
				while(estNonPrisEnCharge && tranche < calendrier.length){
					calendrier[tranche].forfait = 20;
					tranche++;
					//26 semaines = 6 tranches + 2 semaines
					//mais une tranche déjà prise par la double non prise en charge du if précédent
					if(tranche-initiale == 5 ){
						estNonPrisEnCharge = false;
						reformaterCalendrier(tranche);
					}
				}
				
				//le patient peut être repris en charge s'il est observant
				while(tranche < calendrier.length){
					//si observant on incrémente pas la tranche
					if (calendrier[tranche].observant == true) 
						break;
					
					calendrier[tranche].forfait = 20;
					tranche++;
				}
				
			}
		}
		
		/**
		 * reformate le calendrier pour une reprise en charge de l'AMO
		 * @param tranche tranche à partir de laquelle on reformate le calendrier
		 * 
		 */
		private function reformaterCalendrier(tranche:int):void
		{ 
			//la 26eme semaine correspond à la deuxieme semaine d'une tranche
			//il faut reformater le calendrier pour reprendre l'observance à partir de la semaine 26
			//on va donc concatener : sem 26+27+28 et sem 29 de la tranche suivante et ainsi de suite
			
			
			//bloc permettant de séparer une tranche tq tranche = bloc1s@@bloc3s
			//splice modifie le tableau, slice non
			var bloc3s:Array  = calendrier[tranche].utilisation.splice(14, calendrier[tranche].utilisation.length - 1);
			var bloc1s:Array;
			
			while (tranche < calendrier.length ){
				//si les jours sont consécutifs
				//cas 1 : tranche suivante vide
				//cas 2 : au plus 1 semaine dans la tranche suivante
				//cas 3 : sinon
				if(jourConsecutif(tranche) == true){
					//cas1 : on push la nouvelle tranche au sommet du calendrier
					if(calendrier[tranche+1] == null || calendrier[tranche+1].utilisation.length == 0){
						calendrier.push({
							observant : estObservant(bloc3s),
							forfait : 100,
							utilisation : bloc3s
						});
						return;
					}
						//cas2 : on concat 1s@@3s dans la tranche suivante et on peu sortir(car semaine+1 et +2 forcément non consécutives)
					else if(calendrier[tranche+1].utilisation.length <= 14){
						bloc1s = calendrier[tranche+1].utilisation.splice(0, calendrier[tranche+1].utilisation.length-1) ;
						var temp:Array = bloc3s.concat(bloc1s);
						calendrier[tranche+1] = ({
							observant : estObservant(temp),
							forfait : 100,
							utilisation : temp
						});
						return;
						//cas 3 : on concat bloc1 et bloc3 et on continue à reformater le tableau
					} else {
						bloc1s = calendrier[tranche+1].utilisation.slice(0, 14) ;
						temp = bloc3s.concat(bloc1s);
						bloc3s  = calendrier[tranche+1].utilisation.splice(14, calendrier[tranche+1].utilisation.length - 1);
						calendrier[tranche+1] = ({
							observant : estObservant(temp),
							forfait : 100,
							utilisation : temp
						});
					}
					//si non consécutif alors on
				}else{
					var periode:Object = ({
						observant : estObservant(bloc3s),
						forfait : 100,
						utilisation : bloc3s
					});
					insertionTranche(periode , tranche+1);
					return;
				}
				tranche++;
			}
		}
		
		private function jourConsecutif(tranche:int):Boolean
		{
			//calendrier[tranche].utilisation[ObservanceDatas.PERIODE_OBSERVANCE] == calendrier[tranche+1].utilisation[0]-1
			return true;
		}
		
		/**
		 * insert une periode d'observance à un index/une tranche donnée
		 * 
		 * @param periode tableau de jours à inséré
		 * @param tranche index à laquel on insère le tableau
		 * 
		 */
		private function insertionTranche(periode:Object, tranche:int):void
		{
			calendrier.push(calendrier[calendrier.length]);
			for (var i:int = calendrier.length ; i < tranche ; i--){
				calendrier[i] = calendrier[i-1];
			}
			calendrier[tranche] = periode;
		}
		
		/**
		 * calcul du forfait à partir de la tranche donné 
		 * jusqu'à la fin de la prise en charge au forfait demandé
		 * 
		 * retourne la tranche de fin de prise en charge au forfait demandé
		 */
		private function calculForfait(tranche:int, forfait:Number):int
		{
			//1 an = 52 semaines = 4*13 tranches d'observance
			var sommeNonObservantConsecutif:int = 0 ;
			/**
			 * maximum pour changer de forfait 16 semaines = 4*4 periodes
			 */
			var tabNonObservant:RingObservance = new RingObservance(4);
			var estForfaitCourrant:Boolean = true;
			
			while (estForfaitCourrant && tranche < calendrier.length){
				calendrier[tranche].forfait = forfait;
				//on vérifie que les tranches soient consécutives, sinon les critères d'arrêts sont raz
				if(calendrier[tranche].utilisation.length < ObservanceDatas.PERIODE_OBSERVANCE){
					sommeNonObservantConsecutif = 0;
					tabNonObservant.flush();
					tranche++;
				}else{
					if(!calendrier[tranche].observant){
						sommeNonObservantConsecutif++;
						//si raison 1 ou 2 il ne faut pas incrémenter la tranche car la prise en charge 
						//par l’AMO est transférée dès la première de ces 4 semaines sur le forfait suivant 
						if(sommeNonObservantConsecutif == 3 ||
							tabNonObservant.add(tranche) == 1)
							estForfaitCourrant = false;
						else
							tranche++;
					}else{
						sommeNonObservantConsecutif = 0;
						tranche++;							
					}
				}
			}
			
			return tranche;
		}
		
		
		/**
		 * Affiche le calendrier
		 * 
		 */		
		private function afficheCalendrier():void {
			for(var jour:int = 0 ; jour < calendrier.length ; jour++)
				trace( jour + " " +
					calendrier[jour].observant + " " +
					calendrier[jour].forfait + " " +
					calendrier[jour].utilisation.length);
		}		
		
	}
}