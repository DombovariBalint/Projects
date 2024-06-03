package FELADAT;

import java.io.*;
import java.util.*;
/**
//Main osztályban először feltöltöm a save.txt-ből map objektum tartalmát,
 //amiben a mentett animációk (Turmite) kerülnek
//Majd létrehozok egy MenuView-t és elindul a működés
*/
public class Main {
	/**
	 * Main függvény
	 * Mielőtt megjeleníti a menűnek a nézetét, azelőtt betölti a mentett animációkat a save.txt fájlból
	 * @param args
	 */
	public static void main(String args[]) {
		//Variables
		HashMap<String,Turmite> savedAnimations = new HashMap<String,Turmite> ();
		//Load the saved Objects
		try {
			FileInputStream fiSAVE = new FileInputStream("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/save.txt");
			if(fiSAVE.available()!=0) {
				ObjectInputStream inSAVE = new ObjectInputStream(fiSAVE);
				savedAnimations = (HashMap<String,Turmite>)inSAVE.readObject();
				inSAVE.close();
			}
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Sikertelen betöltés\n");
		}
		//Start the view
		MenuView menu = new MenuView(savedAnimations);
		menu.setVisible(true);
		
	}
}
