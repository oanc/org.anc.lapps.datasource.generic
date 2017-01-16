package org.anc.lapps;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author Keith Suderman
 */
public class IndexText
{
	public IndexText()
	{

	}

	public void run()
	{
		String path = "/var/corpora/FDR/index.txt";
		try
		{
			Stream<String> stream = Files.lines(Paths.get(path));
			Map map = stream.map(s -> s.split(" +"))
					.collect(Collectors.toMap(a->a[0], a->a[1]));
			map.forEach((k,v) -> System.out.println(k + " = " + v));
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	public static void main(String[] args)
	{
		new IndexText().run();
	}
}
