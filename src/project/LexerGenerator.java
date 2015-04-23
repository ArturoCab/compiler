package project;

import java.io.File;

public class LexerGenerator {

		public static final String path ="src/project/Lexer.flex";
		
		public static void main(String[] args) {
			// TODO Auto-generated method stub

			generarLexer(path);
		}

		public static void generarLexer(String path){
			File file = new File(path);
			jflex.Main.generate(file);
		}
		

	}
