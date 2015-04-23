package project;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {

	public static void main(String[] args) {
		String archLexico = "archLexico.flex";
		String archSintactico = "archSintactico.cup";

		String[] aLexico = { archLexico };
		String[] aSintactico = { "-parser", "AnalizadorSintactico",
				archSintactico };
		jflex.Main.main(aLexico);
		try {
			java_cup.Main.main(aSintactico);
		} catch (Exception e) {
			Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
		}

		boolean mvAL = moverArch("AnalizadorLexico.java");
		boolean mvAS = moverArch("AnalizadorSintactico.java");
		boolean mvSym = moverArch("Sym.java");

		if (mvAL && mvAS && mvSym) {
			System.exit(0);
		}
	}

	public static boolean moverArch(String archName) {
		boolean efectuado = false;
		File arch = new File(archName);
		if (arch.exists()) {
			System.out.println("\n Moviendo Archivo " + arch);
			Path currentRelativePath = Paths.get("");
			String newDir = currentRelativePath.toAbsolutePath().toString()
					+ File.separator + "src" + File.separator + "project"
					+ File.separator + arch.getName();
			if(arch.renameTo(new File(newDir))){
				System.out.println("Generado "+ archName);
			}
			else{
				System.err.println("No movido" + archName);
			}
		} else{
			System.err.println("Codigo no Existe");
		}
		return efectuado;
	}

}
