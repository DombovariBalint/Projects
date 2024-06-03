package FELADAT;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;

import javax.swing.*;
import javax.swing.border.Border;

/**
 * Az ActionView osztály felel azért a nézetért, ami az aktuális animáció futását grafikus reprezentálja,
 * és ahol el is menthető az
 */
public class ActionView extends JFrame{
	/**
	 * A JComponent-en felül még egy boolean változót vettem fel,
	 * aminek akkor igaz az értéke, mikor éppen fut az animáció
	 */
	//Variables
		private boolean isAnimating = true;
		private Turmite currentAnimation;
		static private HashMap<String,Turmite> savedAnimations;
		static private ArrayList<String> names;
		//Component
	
		//---Labels
		private JLabel title = new JLabel("TURMITE",JLabel.CENTER);
		private Animation animationLabel = new Animation();
		
		//---JTextField
		private JTextField saveTextField = new JTextField(15);
		
		//---Buttons
		private JButton Continue = new JButton("CONTINUE");
		private JButton stop = new JButton("STOP");
		private JButton restart = new JButton("RESTART");
		private JButton save = new JButton("SAVE");
		
		//---JPanels
		private JPanel panel1 = new JPanel();
		private JPanel panelButtons = new JPanel();

	/**
	 * Konstruktor, ami elkészíti a nézetet
	 * Inicializája az osztály változóit
	 * Beállítja, hogy az egyes komponensek hogyan nézzenek ki, hol helyezkedjenek el
	 * A gombokhoz ActionListenereket ad, hogy azok megfelelően működjenek (command-junk projekt szinten a "click")
	 * Beállítja, hogy Frame egyes gombjai hogyan működjenek
	 * És elínditja az aktuális animáció szálát
	 * @param ca: Az aktuális animáció mögötti szál objektum
	 * @param sa: A mentett animációkat tartalmazó map
	 * @param n: A mentett animációk nevét tartalmazó List
	 */
		public ActionView(Turmite ca, HashMap<String,Turmite> sa,ArrayList<String> n) {
			//set up the view
			//Variables
			currentAnimation = ca;
			//Amennyiben egy teljesen új animáció a currentAnimation, akkor itt adok hozzá egy Animation objektumot
			if(!currentAnimation.isContinued()) {
				currentAnimation.setLabel(animationLabel);
			}
			//De ha egy folytatott animáció, akkor már a menüview-ban a kapott egy Animation objektumot
			else {
				animationLabel = currentAnimation.getLabel();
			}
			currentAnimation.start();
			savedAnimations = sa;
			names = n;
			
			///Objects:
			Border border = BorderFactory.createLineBorder(Color.ORANGE, 3);
			ContinueButton sab = new ContinueButton(saveTextField,save,Continue);
			StopButton sob = new StopButton(saveTextField,save,Continue);
			RestartButton resab = new RestartButton(saveTextField,save,Continue);
			SaveButton sav = new SaveButton(saveTextField);
			
			//---JFrame
			setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
			addWindowListener(new WindowAdapter() {
				   public void windowClosing(WindowEvent evt) { 
				     currentAnimation.stopAnimation();
				   }
				  });
			setResizable(true);
			setMinimumSize(new Dimension(600, 800));
			getContentPane().setBackground(Color.BLUE);
			
			//---JLabel
			title.setForeground(Color.ORANGE);
			title.setFont(new Font("Serif",Font.BOLD,40));
			title.setPreferredSize(new Dimension(200, 100));
		    title.setBorder(border);
		    animationLabel.setOpaque(true);
		    animationLabel.setPreferredSize(new Dimension(600,600));
		    
		    //---JTextField
		    saveTextField.setEditable(true);
		    saveTextField.setVisible(false);
		    
			//---JButtons
		    //Start
			Continue.setBackground(Color.GREEN);
			Continue.setOpaque(true);
			Continue.setBorderPainted(false);
			Continue.setFont(new Font("Serif",Font.BOLD,13));
			Continue.setFocusPainted(false);
			Continue.setActionCommand("click");
			Continue.addActionListener(sab);
			Continue.setVisible(false);
			//Stop
			stop.setBackground(Color.RED);
			stop.setOpaque(true);
			stop.setBorderPainted(false);
			stop.setFont(new Font("Serif",Font.BOLD,13));
			stop.setFocusPainted(false);
			stop.setActionCommand("click");
			stop.addActionListener(sob);
			//Restart
			restart.setBackground(Color.BLACK);
			restart.setForeground(Color.WHITE);
			restart.setOpaque(true);
			restart.setBorderPainted(false);
			restart.setFont(new Font("Serif",Font.BOLD,13));
			restart.setFocusPainted(false);
			restart.setActionCommand("click");
			restart.addActionListener(resab);
			//Save
			save.setBackground(Color.ORANGE);
			save.setForeground(Color.BLACK);
			save.setOpaque(true);
			save.setBorderPainted(false);
			save.setFont(new Font("Serif",Font.BOLD,13));
			save.setFocusPainted(false);
			save.setVisible(false);
			save.setActionCommand("click");
			save.addActionListener(sav);
			
			//---JPanel
			panel1.setOpaque(false);
			panel1.add(animationLabel);
			panelButtons.setOpaque(false);
		
			//set up the layout
			//1.
			panelButtons.add(Continue);
			panelButtons.add(stop);
			panelButtons.add(restart);
			panelButtons.add(saveTextField);
			panelButtons.add(save);
			
			//2.
			this.add(title,BorderLayout.NORTH);
			this.add(panel1, BorderLayout.CENTER);
			this.add(panelButtons, BorderLayout.SOUTH);
		}
	/**
	 * ContinueButton működését megvalósító osztály
	 */
	public class ContinueButton implements ActionListener{
			JTextField jt;
			JButton jbsave;
			JButton jbcontinue;

		/**
		 * Konstruktora az osztálynak
		 * @param tf: TextField, amibe a felhasználó beleírja mentés során a menteni kívánt animáció nevét
		 * @param b1: A saveButton referencia
		 * @param b2: A continueButton referencia
		 */
			public ContinueButton(JTextField tf, JButton b1, JButton b2) {
				jbsave = b1;
				jt = tf;
				jbcontinue = b2;
			}

		/**
		 * Az actionPerformed függvény felüldefiniálása
		 * Megnyomásakor folytatja az animáció futtatását,
		 * és a ContinueButton, a TextField és a SaveButton láthatóságát módosítja, ezzel elrejtve azokat
		 * @param ae: A gomb megnyomáshoz tartozó ActionEvent
		 */
			public void actionPerformed(ActionEvent ae) {
				if (ae.getActionCommand().equals("click")) {
					if(isAnimating == false) {
						jt.setVisible(false);
						jbsave.setVisible(false);
						jbcontinue.setVisible(false);
						isAnimating = true;
						currentAnimation.toBeContinued();
					}
				}
			}
		}
	/**
	 * StopButton működését megvalósító osztály
	 */
		public class StopButton implements ActionListener{
			JTextField jt;
			JButton jbsave;
			JButton jbcontinue;
		/**
		 * Konstruktora az osztálynak
		 * @param tf: TextField, amibe a felhasználó beleírja mentés során a menteni kívánt animáció nevét
		 * @param b1: A saveButton referencia
		 * @param b2: A continueButton referencia
		 */
			public StopButton(JTextField tf, JButton b1, JButton b2) {
				jbsave = b1;
				jt = tf;
				jbcontinue = b2;
			}
		/**
		 * Az actionPerformed függvény felüldefiniálása
		 * Megnyomásakor megállítja az animációt, (abban az esetben, ha egy mentett animációt folytat a felhasználó
		 * akkor a StopButton megnyomásakor felülírodik a korábbi állapota a mentett animációnak,
		 * és egy mentést is végrehajt a save.txt-be és name.txt-be
		 * A ContinueButton, a TextField és a SaveButton láthatóságát módosítja, ezzel megjelnítve azokat
		 * (A TextField és a SaveButton csak akkor látszódik, ha egy nem mentett animáció fut)
		 * @param ae: A gomb megnyomáshoz tartozó ActionEvent
		 */
			public void actionPerformed(ActionEvent ae) {
				if (ae.getActionCommand().equals("click")) {
					if(isAnimating == true) {
						if(!currentAnimation.isContinued()) {
							jt.setVisible(true);
							jbsave.setVisible(true);
						}
						//Automatikusan ment minden stop lenyomása esetén, ha egy mentett animációt folytattunk
						else {
							savedAnimations.replace(currentAnimation.getNev(), savedAnimations.get(currentAnimation.getNev()), currentAnimation);
							try {
								FileOutputStream foNAME = new FileOutputStream("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/name.txt");
								ObjectOutputStream oeNAME = new ObjectOutputStream(foNAME);
								oeNAME.writeObject(names);
								oeNAME.close();
								FileOutputStream foSAVE = new FileOutputStream("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/save.txt");
								ObjectOutputStream oeSAVE = new ObjectOutputStream(foSAVE);
								oeSAVE.writeObject(savedAnimations);
								oeSAVE.close();
							}
							catch(Exception e) {
								System.out.println(e.getLocalizedMessage());
								System.out.println("Sikeretelen mentése a neveknek");
							}
						}
						jbcontinue.setVisible(true);
						isAnimating = false;
						animationLabel.Stop();
					}
				}
			}
		}
		/**
	 		* RestartButton működését megvalósító osztály
	 	*/
		public class RestartButton implements ActionListener{
			JTextField jt;
			JButton jbsave;
			JButton jbcontinue;
			/**
			 * Konstruktora az osztálynak
			 * @param tf: TextField, amibe a felhasználó beleírja mentés során a menteni kívánt animáció nevét
			 * @param b1: A saveButton referencia
			 * @param b2: A continueButton referencia
			 */
			public RestartButton(JTextField tf, JButton b1, JButton b2) {
				jbsave = b1;
				jt = tf;
				jbcontinue = b2;
			}
			/**
			 * Az actionPerformed függvény felüldefiniálása
			 * Megnyomásakor újraindítja az animációt
			 * és a ContinueButton, a TextField és a SaveButton láthatóságát módosítja, ezzel elrejtve azokat
			 * @param ae: A gomb megnyomáshoz tartozó ActionEvent
			 */
			public void actionPerformed(ActionEvent ae) {
				if (ae.getActionCommand().equals("click")) {
						jt.setVisible(false);
						jbsave.setVisible(false);
						jbcontinue.setVisible(false);
						isAnimating = true;
						try {
							animationLabel.Stop();
							currentAnimation.reset();
						}
						catch(Exception e){
							System.out.println("Animáció megállítása");
						}
				}
			}
		}
	/**
	 * SaveButton működését megvalósító osztály
	 */
		public class SaveButton implements ActionListener{
			JTextField t;
		/**
		 * Konstruktora az osztálynak
		 * @param tf: TextField, amibe a felhasználó beleírja mentés során a menteni kívánt animáció nevét
		 */
			public SaveButton(JTextField tt) {

				t = tt;

			}
		/**
		 * Az actionPerformed függvény felüldefiniálása
		 * Megnyomásakor menti az animációt és nevét a save.txt-be és a name.txt-be
		 * Az animáció nevének üres String-et vagy null értékkel nem lehet adni
		 * Minden mentett animáció egyedi névvel kell, hogy rendelkezzen
		 * @param ae: A gomb megnyomáshoz tartozó ActionEvent
		 */
			public void actionPerformed(ActionEvent ae){
				if (ae.getActionCommand().equals("click")) {
					if(isAnimating == false) {
						//Amennyiben egy új animációt mentünk, akkor lehet a nevét felül írni
						if(t.getText()!=null && !t.getText().equals("") && !currentAnimation.isContinued()) {
							currentAnimation.changeName(t.getText());
						}
						//Minden animációnak egyedi névvel kell rendelkeznie
						if(!savedAnimations.containsKey(currentAnimation.getNev())) {
							savedAnimations.put(currentAnimation.getNev(),currentAnimation);
							names.add(currentAnimation.getNev());
						}

						try {
							FileOutputStream foNAME = new FileOutputStream("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/name.txt");
							ObjectOutputStream oeNAME = new ObjectOutputStream(foNAME);
							oeNAME.writeObject(names);
							oeNAME.close();
							FileOutputStream foSAVE = new FileOutputStream("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/save.txt");
							ObjectOutputStream oeSAVE = new ObjectOutputStream(foSAVE);
							oeSAVE.writeObject(savedAnimations);
							oeSAVE.close();
						}
						catch(Exception e) {
							System.out.println(e.getLocalizedMessage());
							System.out.println("Sikeretelen mentése a neveknek");
						}
					}
				}
				
			}
		}
}
