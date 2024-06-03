package FELADAT;

import java.awt.*;
import java.util.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.Border;
import org.w3c.dom.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import java.io.*;
/**
 * A menü nézethez tartozó osztály, ami 3 JComboboxot és egy gombot tartalmaz az alkalmazás vezérléséhez
 */
public class MenuView extends JFrame{
	//Init
	static private Object[ ] speedArray= {"LOW", "MEDIUM", "HIGH"}; 
	static private Object[ ] animationArray= {"SYMMETRICAL", "RANDOM"};
	//---Maximum 100 animation can be saved
	static private Object[ ] savedArray = new Object[101];
	static private HashMap<String,Turmite> savedAnimations;
	static private ArrayList<String> names= new ArrayList<String>();
	static {
		//Load the name of the saved animations
		savedArray[0]="New Animation";
		try {
			//Sajnos csak így látja a name.txt fájlt a Reader, másképp IOExceptiont-t dob folyamatosan
			FileInputStream fiNAME = new FileInputStream("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/name.txt");
			int i = 1;
			if(fiNAME.available()!=0) {
				ObjectInputStream inNAME = new ObjectInputStream(fiNAME);
				names =(ArrayList<String>)inNAME.readObject();
				for(String s : names) {
					savedArray[i]= s;
					i++;
				}
				inNAME.close();
			}
			for(;i<101;i++) {
				savedArray[i]= "-";
			}
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			System.out.println(e.getLocalizedMessage());
			System.out.println("Nem található a name.txt/nem sikerült a neveket betölteni\n");
		}
	}
	
	//Component
	//---Labels
	private JLabel title = new JLabel("TURMITE",JLabel.CENTER);
	private JLabel speedLabel = new JLabel("SPEED:");
	private JLabel animationLabel = new JLabel("ANIMATION TYPE:");
	private JLabel savedLabel = new JLabel("SAVED ANIMATIONS:");
	//---Buttons
	private JButton start = new JButton(" START ");
	
	//---ComboBoxes
	private JComboBox<String> speed = new JComboBox(speedArray);
	private JComboBox<String> animation = new JComboBox(animationArray);
	private JComboBox<String> savedAnimation = new JComboBox(savedArray);
	//---Panels
	private JPanel panel1 = new JPanel();
	private JPanel panel2 = new JPanel();
	private JPanel panelSpeed = new JPanel(new GridBagLayout());
	private JPanel panelAnimation = new JPanel(new GridBagLayout());
	private JPanel panelSave = new JPanel(new GridBagLayout());

	/**
	 * Konstrukotor, ami elkészíti a menühöz tartozó nézetet.
	 * Beállítja az egyes komponensek kinézetét.
	 * A gomboknak ActionListener add.
	 * Elkészíti a layOut-ot.
	 * @param sa: A Main osztályban a save.txt-ből beolvasott HashMap
	 */
	public MenuView(HashMap<String,Turmite> sa) {
		super("TURMITE");
		//Variables
		savedAnimations = sa;
		//setup the view
		
		//---JFrame
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setResizable(false);
		setMinimumSize(new Dimension(600, 300));
		getContentPane().setBackground(Color.BLUE);
		
		//---JLabel
		title.setForeground(Color.ORANGE);
		title.setFont(new Font("Serif",Font.BOLD,40));
		title.setPreferredSize(new Dimension(200, 100));
		Border border = BorderFactory.createLineBorder(Color.ORANGE, 3);
	    title.setBorder(border);
		speedLabel.setForeground(Color.ORANGE);
		speedLabel.setFont(new Font("Serif",Font.PLAIN,14));
		animationLabel.setForeground(Color.ORANGE);
		animationLabel.setFont(new Font("Serif",Font.PLAIN,14));
		savedLabel.setForeground(Color.ORANGE);
		savedLabel.setFont(new Font("Serif",Font.PLAIN,14));
		//---JButtons
		start.setBackground(Color.GREEN);
		start.setOpaque(true);
		start.setBorderPainted(false);
		start.setFont(new Font("Serif",Font.BOLD,14));
		start.setFocusPainted(false);
		StartButton sb = new StartButton(speed,animation,savedAnimation);
		start.setActionCommand("click");
		start.addActionListener(sb);
		//---JComboBox
		speed.setFont(new Font("Serif",Font.PLAIN,14));
		animation.setFont(new Font("Serif",Font.PLAIN,14));
		savedAnimation.setFont(new Font("Serif",Font.PLAIN,14));
		//---JPanel
		panel1.setOpaque(false);
		panel2.setOpaque(false);
		panelSpeed.setOpaque(false);
		panelSpeed.setPreferredSize(new Dimension(190, 100));
		panelAnimation.setOpaque(false);
		panelAnimation.setPreferredSize(new Dimension(190, 100));
		panelSave.setOpaque(false);
		panelSave.setPreferredSize(new Dimension(190, 100));
		
		//setup the layout
		
		//1.---JComboBoxes
		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;//set the x location of the grid for the next component
        c.gridy = 0;//set the y location of the grid for the next component
        panelSpeed.add(speedLabel,c);
        c.gridy = 1;
        panelSpeed.add(speed,c);
        
        c.gridx = 0;//set the x location of the grid for the next component
        c.gridy = 0;//set the y location of the grid for the next component
        panelAnimation.add(animationLabel,c);
        c.gridy = 1;
        panelAnimation.add(animation,c);
        
        c.gridx = 0;//set the x location of the grid for the next component
        c.gridy = 0;//set the y location of the grid for the next component
        panelSave.add(savedLabel,c);
        c.gridy = 1;
        panelSave.add(savedAnimation,c);
        
		//2.
		panel1.add(panelSpeed);
		panel1.add(panelAnimation);
		panel1.add(panelSave);
		panel2.add(start);
		
		//3.
		this.add(title, BorderLayout.NORTH);
		this.add(panel1,BorderLayout.CENTER);
		this.add(panel2, BorderLayout.SOUTH);
		
	}
	/**
	//Az új Tumrite objektum létrehozása és szabályokkal történő feltöltés a rule.xml fájlból
	 */
	public Turmite readRulesXML(JComboBox<String> animationB,int sp) throws falseRulesFormat {
		Turmite newTurmite = new Turmite(sp);
		try {
			DocumentBuilderFactory factory =
			DocumentBuilderFactory.newInstance(); factory.setValidating(true); factory.setNamespaceAware(true);
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new java.io.File("/Users/balintdombovari/Desktop/Prog3/HAZI/src/FELADAT/rule.xml"));
			NodeList nList = document.getElementsByTagName("rule");
			String[] rulesString = new String[4];
			 loop: for (int temp = 0; temp < nList.getLength(); temp++) {
			        Node nNode = nList.item(temp);
			        if (nNode.getNodeType() == Node.ELEMENT_NODE) {
			            Element eElement = (Element) nNode;
			            if(eElement.getAttribute("name").equals(animationB.getSelectedItem())) {
			            	rulesString[0] = eElement.getElementsByTagName("first")
	                                 .item(0).getTextContent();
			            	rulesString[1] = eElement.getElementsByTagName("second")
	                                 .item(0).getTextContent();
			            	rulesString[2] = eElement.getElementsByTagName("third")
	                                 .item(0).getTextContent();
			            	rulesString[3] = eElement.getElementsByTagName("fourth")
	                                 .item(0).getTextContent();
			            	break loop;
			            }
			        }
			 }
			
			for(int i=0;i<4;i++) {
				String[] currentRULE= rulesString[i].split("-");
				//a beolvasott szabály formai ellenőrzése
				if(currentRULE.length!=5) {
					throw new falseRulesFormat();
				}
				for(String s : currentRULE) {
					if(!s.equals("0") && !s.equals("1") && !s.equals("R") && !s.equals("L") && !s.equals("N") && !s.equals("U")) {
						throw new falseRulesFormat();
					}
				}
				String key = currentRULE[0]+"-"+currentRULE[1];
				int a = Integer.parseInt(currentRULE[3]);
				int b = Integer.parseInt(currentRULE[4]);
				//Forgásirány meghatározása
				Rotation r;
				switch(currentRULE[2]) {
				case "R":
					r = Rotation.RIGHT;
					break;
				case "L":
					r = Rotation.LEFT;
					break;
				case "N":
					r = Rotation.NoTURN;
					break;
				case "U":
					r = Rotation.uTURN;
					break;
				default:
					r = Rotation.RIGHT;
					break;
				}
				Rule newRule = new Rule(key,r,a,b);
				newTurmite.addRule(key,newRule);
			}
		
		}
		catch(Exception e) {
			System.out.println("Hibás fájl beolvasás (Rule.txt)");
		}
		return newTurmite;
	}

	/**
	 * StartButton működését megvalósító osztály
	 */
	public class StartButton implements ActionListener{
		JComboBox<String> speedB;
		JComboBox<String> animationB;
		JComboBox<String> saveAnimationB;

		/**
		 * Konstruktor
		 * @param jb1: Speed érték kiválasztásához tartozó JComboBox
		 * @param jb2: Az animáció típusának kiválasztásához tartozó JComboBox
		 * @param jb3: A mentett animációk kiválasztásához tartozó JComboBox
		 */
		public StartButton(JComboBox<String> jb1, JComboBox<String> jb2,JComboBox<String> jb3) {
			speedB = jb1;
			animationB = jb2;
			saveAnimationB = jb3;
		}

		/**
		 * Amennyiben egy új animációt hoz létre a felhasználó, akkor beállítom az animáció sebeségét,
		 * majd futtatom azt egy ActionView-ban (külön ablakban).
		 * Amennyiben egy mentett animációt futtat a felhasználó, akkor kikeresem azt a HashMap-ből,
		 * leklónozom a saját clone fügvényemmel,
		 * Majd egy új szálként futattom, biztosítva ezzel,
		 * hogy nehogy véletlen egy TERMINATED állapotban lévő szálat futtasak.
		 * @param ae: A gomb megnyomásához tartozó ActionEvent
		 */
		public void actionPerformed(ActionEvent ae) {
			if (ae.getActionCommand().equals("click")) {
				if(((String)saveAnimationB.getSelectedItem()).equals("New Animation")) {
					try {
						ActionView view;
						switch((String)speedB.getSelectedItem()) {
						case "LOW":
							view = new ActionView(readRulesXML(animationB,5),savedAnimations,names);
							view.setVisible(true);
							break;
						case "MEDIUM":
							view = new ActionView(readRulesXML(animationB,2),savedAnimations,names);
							view.setVisible(true);
							break;
						case "HIGH":
							view = new ActionView(readRulesXML(animationB,1),savedAnimations,names);
							view.setVisible(true);
							break;
						}
					}
					catch(falseRulesFormat e) {
						e.error();
					}
				}
				else if(((String)saveAnimationB.getSelectedItem()).equals("-")) {}
				else{
					Turmite secondaryTurmite = savedAnimations.get(saveAnimationB.getSelectedItem());
					Turmite continueTurmite = new Turmite(5);
					continueTurmite.clone(secondaryTurmite);
					continueTurmite.setLabel(new Animation());
					continueTurmite.refreshLabel();
					switch((String)speedB.getSelectedItem()) {
					case "LOW":
						continueTurmite.setWait(5);
						break;
					case "MEDIUM":
						continueTurmite.setWait(2);
						break;
					case "HIGH":
						continueTurmite.setWait(1);
						break;
					}
					if(secondaryTurmite != null) {
						ActionView view = new ActionView(continueTurmite,savedAnimations,names);
						view.setVisible(true);
					}
					else {
						System.out.println("Nem sikerült a map-ből kiszedni a mentett objektumot");
					}
				}
				
			}
			
		}
	}
}
