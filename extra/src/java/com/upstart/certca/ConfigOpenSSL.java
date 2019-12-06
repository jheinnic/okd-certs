import org.stringtemplate.v4.*;

public class ConfigOpenSSL {
	public static void main(String[] args) {
		ST hello = new ST("Hello, <name>");
		hello.add("name", "World");
		System.out.println(hello.render());
		System.out.println(args[0]);
		System.out.println(args[1]);
	}
}
