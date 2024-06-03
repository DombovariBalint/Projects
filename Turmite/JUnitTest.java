package FELADAT;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.*;
import org.junit.jupiter.api.Test;

/**
 * 10 db JUnit teszt a Turmite, Rule, és Animation osztályokhoz
 * A tesztek a get-erek keresztül elleőrzik az egyes osztályok konstruktoraik helyes működését
 * Sajnos számára érthetetlen okból a @Before részek nem futottak le,
 * így az alábbi módon hoztam létre az egyes osztályokhoz tartozó objektumokat.
 * A tesztek nevében szerepel, hogy az adott teszt mit tesztel.
 */
public class JUnitTest {
	Turmite testTurmite = new Turmite(5);
	Rule testRule = new Rule("Nev",Rotation.LEFT,1,1);
	Animation testAnimation = new Animation();
	/*@BeforeClass
	public void init() {
		System.out.println("BeforeClass");
		testTurmite = new Turmite(5);
		testRule = new Rule("Nev",Rotation.LEFT,1,1);
		testAnimation = new Animation();
	}
	@Before
	public void init2() {
		System.out.println("Before");
		testTurmite = new Turmite(5);
		testRule = new Rule("Nev",Rotation.LEFT,1,1);
		testAnimation = new Animation();
	}
	*/
	
	@Test
	public void testAnimationGetStopSignal() {
		assertFalse(testAnimation.getStopSignal());
	}
	@Test
	public void testRuleGetNames() {
		assertEquals("Nev",testRule.getName());
	}
	@Test
	public void testRulesGetRotation() {
		assertEquals(Rotation.LEFT,testRule.getRotation());
	}
	@Test
	public void testRuleNextValue() {
		assertEquals(1,testRule.getNextValue());
	}
	@Test
	public void testRuleNextState() {
		assertEquals(1,testRule.getNextState());
	}
	@Test
	public void testTurmiteGetX() {
		assertEquals(299,testTurmite.getX());
	}
	@Test
	public void testTurmiteGetY() {
		assertEquals(299,testTurmite.getY());
	}
	@Test
	public void testTurmiteGetDirection() {
		assertEquals(Direction.NORTH,testTurmite.getDirection());
	}
	@Test
	public void testTurmiteGetState() {
		assertEquals(0,testTurmite.getStateOfTurmite());
	}
	@Test
	public void testTurmiteIsContinued() {
		assertFalse(testTurmite.isContinued());
	}

}
