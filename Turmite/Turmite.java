package FELADAT;

import java.io.Serializable;
import java.util.HashMap;

import javax.swing.JLabel;
/**
//Egy Turmite egy szálként fogható fel
//Egy animációhoz egyféle szabályrendszer(Symmetrical,Random) van,
 //amit az animáció létrehozásakor állítunk be a Rules HashMap-ben.
//Mivel 4 féle eset lehet az állapotoknfüggvényében (aktuális cella és a termesz állapota)
 (0-0,
 0-1,
 1-0,
 1-1)
 //így a HashMap maximum 4 db Rule-t tartalmazhat
 */
public class Turmite extends Thread implements Serializable {
	//Variables
	/**
	 * Az egyes változók jelentését a get-er esetén fejtettem ki
	 */
	private volatile boolean stopSignal;
	static private int id = 0;
	private String name;
	private boolean [][] stateArray = new boolean [600][600];
	private HashMap<String,Rule> Rules = new HashMap<String,Rule>();
	private int xPosition;
	private int yPosition;
	private int state;
	private Direction currentDirection;
	private Animation currentLabel = new Animation();
	private int wait;
	private boolean continued = false;
	/**
	 * Konstruktor
	 * A tábla közepére állítja a termeszt és default értékeket ad az egyes változóknak
	 * @param s: wait értékét annak függvényében állítom be, hogy a felhasználó milyen sebességet állított be
	 *         a MenuView-ban
	 */
	public Turmite(int s) {
		name = "DefaultName" + (id + 1);
		id++;
		state = 0;
		wait = s;
		currentDirection = Direction.NORTH;
		stopSignal = false;
		xPosition = 299;
		yPosition = 299;
		for(int i=0; i < 600; i++) {
			for(int f = 0; f<600;f++) {
				stateArray[i][f]=false;
			}
		}
	}
	//gettes
	/**
	 *get-er stateArray
	 */
	public boolean[][] getStateArray(){
		return stateArray;
	}

	/**
	 * get-er x pozició
	 * @return
	 */
	public int getX() {
		return xPosition;
	}
	/**
	 * get-er y pozició
	 * @return
	 */
	public int getY() {
		return yPosition;
	}
	/**
	 * get-er szabályrendszer
	 * @return
	 */
	public HashMap<String,Rule> getRules(){
		return Rules;
	}
	/**
	 * get-er termesz állapota
	 * @return
	 */
	public int getStateOfTurmite(){
		return state;
	}
	/**
	 * get-er nev
	 * @return
	 */
	public String getNev() {
		return name;
	}
	/**
	 * get-er irány, amerre a termesz néz
	 * @return
	 */
	public Direction getDirection() {
		return currentDirection;
	}
	/**
	 * get-er az adott szálhoz tartozó Animation objektum
	 * @return
	 */
	public Animation getLabel() {
		return currentLabel;
	}
	/**
	 * get-er egy mentett animáció folytatása?
	 * @return
	 */
	public boolean isContinued() {
		return continued;
	}
	//setters
	/**
	 * set-er Wait
	 * @param s
	 */
	public void setWait(int s) {
		wait = s;
	}
	/**
	 * set-er currentLabel
	 * @param jb
	 */
	public void setLabel(Animation jb){
		currentLabel = jb;
	}
	/**
	 * //Mentés esetén megváltoztatható a név
	 * //Amennyiben a felhasználó nem ad meg nevet akkor default értékkel mentem el
	 * @param newName
	 */
		public void changeName(String newName) {
			if(newName!=null) {
				name = newName;
			}
		}
	/**
	 * Saját clone függvény, ami egy paraméterként átadott objektum bizonyos attributumait lemásolja
	 * @param copy: lemásolt objektum
	 */
	public void clone(Turmite copy) {
		continued = true;
		this.name = copy.getNev();
		this.stateArray = copy.getStateArray();
		this.xPosition = copy.getX();
		this.yPosition = copy.getY();
		this.Rules = copy.getRules();
		this.state = copy.getStateOfTurmite();
		this.currentDirection = copy.getDirection();
	}

	/**
	 * Új Rule objektum felvétel a Rules szabály rendszerbe
	 * @param key
	 * @param newRule
	 */
	public void addRule(String key, Rule newRule) {
		if(Rules.size()<4) {
			if(!Rules.containsKey(key)) {
				Rules.put(key, newRule); 
			}
		}
	}
	/**
	//Mikor mentett animációt egymás után kettőször futtatunk,
	//akkor kell ez a függvény, hogy mentett állapotnak megfelelően jelenjen meg az animáció
	 */
	public void refreshLabel() {
		currentLabel.refreshLabel(stateArray);
	}
	/**
	//Újra indítja a szálat, 
	//Amennyiben a szál úgy állt le, hogy stopSignal értéke is változott visszaállítja azt
	//(bezárták az animációhoz tartozó ablakot)
	 */
	public void toBeContinued() {
		currentLabel.Restart();
		if(stopSignal) {
			stopSignal = false;
		}
	}
	/**
	//Alapállapotba állítja a Turmite objektumot
	//majd újrafutatja azt Animation osztály Restart függvényével
	 */
	public void reset() {
		state = 0;
		currentDirection = Direction.NORTH;
		xPosition = 299;
		yPosition = 299;
		for(int i=0; i < 600; i++) {
			for(int f = 0; f<600;f++) {
				stateArray[i][f]=false;
			}
		}
		currentLabel.Restart();
	}

	/**
	 * A szál végleges leállítása
	 * Az ActionView-ban a StopButton megnyomásakor nem ez hívódik meg
	 * Ez az ActionView bezárásakor hívódik meg
	 */
	public void stopAnimation() {
		stopSignal = true;
	}

	/**
	 * Mivel a Turmite osztály a Thread osztályból származik le, így felül kellett definiálnom a run függvényt.
	 * Egy lépésben a következőt csinálja: a stateArray[yPosition][xPosition] aktuális pozíció és a termesz
	 * aktuális állapota alapján (state) megkeresi ehhez állapothoz tartozó lépés szabályát a Rules map-ből,
	 * majd módosítja az aktuális cella értékét és a termesz állapotát a szabály alapján,
	 * meghívja changeDirection függvényt, léptetve ezzel a termeszt,
	 * végül frissíti az animációhoz tartozó nézetet, és egy kicsit várakoztatja a szálat annak függvényében
	 * hogy a felhasználó milyen lejátszási sebbeséget állított be.
	 */
	public void run() {
		while(!stopSignal) {
			if(stateArray[yPosition][xPosition]) {
				if(state==0) {
					Rule current = Rules.get("0-1");
					if(current.getNextValue()==0) {
						stateArray[yPosition][xPosition]=false;
					}
					else {
						stateArray[yPosition][xPosition]=true;
					}
					state = current.getNextState();
					changeDirection(current.getRotation());
					currentLabel.refreshLabel(stateArray);
					try{Thread.sleep(wait);}
					 catch(InterruptedException e)
					 {System.out.println(e);} 
				}
				else {
					Rule current = Rules.get("1-1");
					if(current.getNextValue()==0) {
						stateArray[yPosition][xPosition]=false;
					}
					else {
						stateArray[yPosition][xPosition]=true;
					}
					state = current.getNextState();
					changeDirection(current.getRotation());
					currentLabel.refreshLabel(stateArray);
					try{Thread.sleep(wait);}
					 catch(InterruptedException e)
					 {System.out.println(e);} 
				}
			}
			else {
				if(state==0) {
					Rule current = Rules.get("0-0");
					if(current.getNextValue()==0) {
						stateArray[yPosition][xPosition]=false;
					}
					else {
						stateArray[yPosition][xPosition]=true;
					}
					state = current.getNextState();
					changeDirection(current.getRotation());
					currentLabel.refreshLabel(stateArray);
					try{Thread.sleep(wait);}
					 catch(InterruptedException e)
					 {System.out.println(e);} 
				}
				else {
					Rule current = Rules.get("1-0");
					if(current.getNextValue()==0) {
						stateArray[yPosition][xPosition]=false;
					}
					else {
						stateArray[yPosition][xPosition]=true;
					}
					state = current.getNextState();
					changeDirection(current.getRotation());
					currentLabel.refreshLabel(stateArray);
					try{Thread.sleep(wait);}
					 catch(InterruptedException e)
					 {System.out.println(e);} 
				}
			}
		}
		
	}
	/**
	//Meghatározza, hogy fordulás után hova fog lépni a termesz 
	//Módosítja a pozícióját, és az aktuális irányát
	 */
	private void changeDirection(Rotation next) {
		loop: switch(next) {
		case LEFT:
			switch(currentDirection) {
			case NORTH:
				currentDirection = Direction.WEST;
				if(xPosition==0) {
					xPosition=599;
				}
				else {
					xPosition--;
				}
				break loop;
			case EAST:
				currentDirection = Direction.NORTH;
				if(yPosition==0) {
					yPosition=599;
				}
				else {
					yPosition--;
				}
				break loop;
			case SOUTH:
				currentDirection = Direction.EAST;
				if(xPosition==599) {
					xPosition=0;
				}
				else {
					xPosition++;
				}
				break loop;
			case WEST:
				currentDirection = Direction.SOUTH;
				if(yPosition==599) {
					yPosition=0;
				}
				else {
					yPosition++;
				}
				break loop;
			}
		case RIGHT:
			switch(currentDirection) {
			case NORTH:
				currentDirection = Direction.EAST;
				if(xPosition==599) {
					xPosition=0;
				}
				else {
					xPosition++;
				}
				break loop;
			case EAST:
				currentDirection = Direction.SOUTH;
				if(yPosition==599) {
					yPosition=0;
				}
				else {
					yPosition++;
				}
				break loop;
			case SOUTH:
				currentDirection = Direction.WEST;
				if(xPosition==0) {
					xPosition=599;
				}
				else {
					xPosition--;
				}
				break loop;
			case WEST:
				currentDirection = Direction.NORTH;
				if(yPosition==0) {
					yPosition=599;
				}
				else {
					yPosition--;
				}
				break loop;
			}
		case NoTURN:
			switch(currentDirection) {
			case NORTH:
				if(yPosition==0) {
					yPosition=599;
				}
				else {
					yPosition--;
				}
				break loop;
			case EAST:
				if(xPosition==599) {
					xPosition=0;
				}
				else {
					xPosition++;
				}
				break loop;
			case SOUTH:
				if(yPosition==599) {
					yPosition=0;
				}
				else {
					yPosition++;
				}
				break loop;
			case WEST:
				if(xPosition==0) {
					xPosition=599;
				}
				else {
					xPosition--;
				}
				break loop;
			}
		case uTURN:
			switch(currentDirection) {
			case NORTH:
				currentDirection = Direction.SOUTH;
				if(yPosition==599) {
					yPosition=0;
				}
				else {
					yPosition++;
				}
				break loop;
			case EAST:
				currentDirection = Direction.WEST;
				if(xPosition==0) {
					xPosition=599;
				}
				else {
					xPosition--;
				}
				break loop;
			case SOUTH:
				currentDirection = Direction.NORTH;
				if(yPosition==0) {
					yPosition=599;
				}
				else {
					yPosition--;
				}
				break loop;
			case WEST:
				currentDirection = Direction.EAST;
				if(xPosition==599) {
					xPosition=0;
				}
				else {
					xPosition++;
				}
				break loop;
			}
		}
	}
	
}
