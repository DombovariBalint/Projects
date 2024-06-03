package FELADAT;

import java.io.*;
/**
//Az osztály a Turmite-hoz tartozó szabályrendszer egyik lehetséges esetét reprezentálja a következőképp:
//4 féle kezdőállapot lehetséges, amit a névben rögzítek: 0-0, 0-1, 1-0, 1-1
//Pl.: 0-0 érték jelentése a következő: A termesz és az aktuális cella állapota is 0
// A next jelőli a fordulást irányát
//A nextValue az aktuális cella következő értéke
//A nextState a termesz következő állapota
 */
public class Rule implements Serializable {
	String name;
	Rotation next;
	int nextValue;
	int nextState;
	/**
	 * Konstrukor
	 * @param s: név
	 * @param r: fordulás irány(enum)
	 * @param iv: következő értéke az aktuális cellának(0/1)
	 * @param is: következő állapota a temresznek(0/1)
	 */
	public Rule(String s, Rotation r, int iv, int is) {
		name = s;
		next = r;
		nextValue = iv;
		nextState = is;
	}

	/**
	 * get-er name
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * get-er fordulás
	 * @return
	 */
	public Rotation getRotation() {
		return next;
	}

	/**
	 * get-er következő értéke az aktuális cellának
	 * @return
	 */
	public int getNextValue() {
		return nextValue;
	}

	/**
	 * get-er következő állapota a temresznek
	 * @return
	 */
	public int getNextState() {
		return nextState;
	}
}
