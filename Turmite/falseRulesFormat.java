package FELADAT;

/**
 * Egy saját Exception arra az esetre, ha a rule.xml-ből beolvasott szabályok formátuma helytelen
 */
public class falseRulesFormat extends Throwable {
	/**
	 * Az error() metódus kiírja a standard output-ra a hibaüzenetet
	 */
	public void error() {
		System.out.println("Hibás szabály formátum");
	}
}
