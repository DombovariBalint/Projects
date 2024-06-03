package FELADAT;

import java.awt.Color;
import java.awt.Graphics;

import javax.swing.*;

/**
 * Az animáció grafikus megjelnítésért felelős osztály
 * Az animáció egy 600x600-os táblán rajzolódik ki és minden cella színe vagy fehér vagy fekete
 * Az animáció futásakor ebből az osztályból létrehozott objektum monitorába lépbe az animációhoz tartozó szál (Turmite)
 */
public class Animation extends JLabel{
	/**
	 * A stateArray reprezentálja az egyes cellák állapotát
	 * A stopSignal változón keresztül lehet WAIT állapotba léptetni az animációhoz tartozó szálat
	 */
	//Variables
	private boolean[][] stateArray = new boolean[600][600];
	private volatile boolean stopSignal;

	/**
	 * Konstruktora az osztálynak
	 * A stateArray minden egyes cellájába false értéket állít be, ezáltal alapból fekete színű minden cella
	 */
	public Animation() { 
		for(int i=0; i < 600; i++) {
			for(int f = 0; f<600;f++) {
				stateArray[i][f]=false;
			}
		}
	}

	/**
	 * stopSignálhoz tartozó get-er
	 * @return
	 */
	public boolean getStopSignal() {
		return stopSignal;
	}

	/**
	 * stop utasítás kiadásakor ezzel függvénnyel adom ki a jelet a szálnak, és ezzel WAIT állapotba billentem azt
	 */
	public void Stop() {
		stopSignal = true;
	}

	/**
	 * A várakozó szál felébresztése
	 */
	public synchronized void Restart() {
		stopSignal = false;
		this.notify();
	}

	/**
	 * A szál futása közben, miután a Turmite osztályban lévő algoritmus módosítja a stateArray-ben lévő értékeket,
	 * megkapja ez a függvény, és amennyiben a stopSignal értéke engedi,
	 * folyamatosan frissíti az animáció grafikus reprezentációját
	 * @param refresh: Turmite objektumban módosított stateArray
	 */
	public synchronized void refreshLabel(boolean[][] refresh) {
		if(!stopSignal) {
			stateArray = refresh;
			this.repaint();
		}
		else {
			try {
				this.wait();
			}
			catch(InterruptedException e) {
				System.out.println("Megállt a szál");
			}
		}
	}

	/**
	 * Az stateArray-ben szereplő értékek kirajzolása grafikusan
	 * @param g: kirajzoláshoz kell
	 */
	public void paint(Graphics g) {
		for(int i = 0; i<600;i++) {
			for(int f = 0; f<600;f++) {
				if(stateArray[i][f]) {
					g.setColor(Color.WHITE);
				}
				else {
					g.setColor(Color.BLACK);
				}
				g.fillRect(f,i,1,1);	
			}
		}
	}
}
