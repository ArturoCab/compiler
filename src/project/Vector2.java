package project;

public class Vector2 {
	
	protected int x,y;
	
	public Vector2(int x, int y){
		setVector2(x, y);
	}
	
	public Vector2(String str){
		int comma=str.indexOf(",");
		int x = Integer.parseInt(str.substring(0, comma-1));
		int y = Integer.parseInt(str.substring(comma+1,str.length()-1));
		setVector2(x,y);
	}

	private void setVector2(int x, int y) {
		this.x=x;
		this.y=y;
	}

}
